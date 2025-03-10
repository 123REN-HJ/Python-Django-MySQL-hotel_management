from django.shortcuts import render, redirect, get_object_or_404
from django.views.generic import TemplateView, FormView
from django.urls import reverse_lazy
from .models import Reservation
from rooms.models import Room
from customers.models import Customer
from django.contrib import messages
from .forms import BookingForm
from django.http import JsonResponse
from django.contrib.auth.decorators import user_passes_test, login_required
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.utils import timezone
from finance.models import Income, OrderReview
from decimal import Decimal

# Create your views here.

@require_POST
@csrf_exempt
@user_passes_test(lambda u: u.is_superuser)
def update_reservation_status(request, reservation_id, action):
    try:
        reservation = Reservation.objects.get(id=reservation_id)
        
        status_map = {
            'confirm': 'Confirmed',
            'check-in': 'CheckIn',
            'check-out': 'CheckOut',
            'cancel': 'Cancelled'
        }
        
        if action in status_map:
            old_status = reservation.status
            new_status = status_map[action]
            reservation.status = new_status
            
            # 更新房间状态
            if new_status == 'Confirmed':
                reservation.room.status = 'reserved'
            elif new_status == 'CheckIn':
                reservation.room.status = 'occupied'
            elif new_status in ['CheckOut', 'Cancelled']:
                reservation.room.status = 'available'
            
            reservation.room.save()
            reservation.save()
            
            # 创建收入记录
            Income.objects.create(
                date=timezone.now().date(),
                amount=reservation.total_price,
                source='Room',
                description=f'房间 {reservation.room.room_number} 的住宿费用',
                reservation=reservation
            )
            
            return JsonResponse({
                'success': True,
                'message': f'预订状态从 {dict(Reservation.STATUS).get(old_status)} 更改为 {dict(Reservation.STATUS).get(new_status)}'
            })
        
        return JsonResponse({
            'success': False,
            'error': '无效的操作'
        })
        
    except Reservation.DoesNotExist:
        return JsonResponse({
            'success': False,
            'error': '预订不存在'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'error': str(e)
        })

@login_required
def update_reservation_status(request, reservation_id, action):
    reservation = get_object_or_404(Reservation, id=reservation_id)
    success = False
    error = None

    try:
        if action == 'confirm':
            reservation.status = 'confirmed'
            reservation.room.status = 'reserved'
            reservation.room.save()
            reservation.save()
            success = True
        elif action == 'check-in':
            reservation.status = 'checked_in'
            reservation.room.status = 'occupied'
            reservation.room.save()
            reservation.save()
            success = True
        elif action == 'check-out':
            reservation.status = 'checked_out'
            # 更新房间状态为可用
            reservation.room.status = 'available'
            reservation.room.save()
            reservation.save()
            
            # 创建收入记录
            Income.objects.create(
                date=timezone.now().date(),
                amount=reservation.total_price,
                source='Room',
                description=f'房间 {reservation.room.room_number} 的住宿费用',
                reservation=reservation
            )
            
            success = True
        elif action == 'cancel':
            reservation.status = 'cancelled'
            # 取消预订也需要更新房间状态为可用
            reservation.room.status = 'available'
            reservation.room.save()
            reservation.save()
            success = True
        else:
            error = '无效的操作'
    except Exception as e:
        error = str(e)

    return JsonResponse({
        'success': success,
        'error': error
    })

@login_required
def reservation_detail(request, reservation_id):
    """显示预订详情，包括支付和评价入口"""
    # 获取预订信息
    reservation = get_object_or_404(Reservation, id=reservation_id)
    
    # 检查权限
    if not request.user.is_superuser and reservation.user != request.user:
        messages.error(request, '您没有权限查看此预订')
        return redirect('reservations:list')
    
    # 计算入住天数
    nights = (reservation.check_out_date - reservation.check_in_date).days
    
    # 检查支付状态
    is_paid = Income.objects.filter(reservation=reservation).exists()
    
    # 获取评价
    try:
        review = OrderReview.objects.get(reservation=reservation)
    except OrderReview.DoesNotExist:
        review = None
    
    context = {
        'reservation': reservation,
        'nights': nights,
        'is_paid': is_paid,
        'review': review,
    }
    
    return render(request, 'reservations/detail.html', context)

@login_required
def reservation_list(request):
    """显示用户的所有预订"""
    # 获取用户的所有预订
    if request.user.is_superuser:
        reservations = Reservation.objects.all().select_related('room', 'customer')
    else:
        reservations = Reservation.objects.filter(user=request.user).select_related('room', 'customer')
    
    # 按状态分组
    pending = reservations.filter(status='pending')
    confirmed = reservations.filter(status='confirmed')
    checked_in = reservations.filter(status='checked_in')
    checked_out = reservations.filter(status='checked_out')
    cancelled = reservations.filter(status='cancelled')
    
    context = {
        'pending': pending,
        'confirmed': confirmed,
        'checked_in': checked_in,
        'checked_out': checked_out,
        'cancelled': cancelled,
    }
    
    return render(request, 'reservations/list.html', context)

@login_required
def cancel_reservation(request, reservation_id):
    """取消预订"""
    reservation = get_object_or_404(Reservation, id=reservation_id)
    
    # 检查权限
    if not request.user.is_superuser and reservation.user != request.user:
        messages.error(request, '您没有权限取消此预订')
        return redirect('reservations:list')
    
    # 检查状态
    if reservation.status not in ['pending', 'confirmed']:
        messages.error(request, '只有待确认或已确认的预订可以取消')
        return redirect('reservations:detail', reservation_id=reservation.id)
    
    # 取消预订
    reservation.status = 'cancelled'
    
    # 更新房间状态
    reservation.room.status = 'available'
    reservation.room.save()
    
    reservation.save()
    
    messages.success(request, '预订已成功取消')
    return redirect('reservations:list')