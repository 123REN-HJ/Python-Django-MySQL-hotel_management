from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q
from .models import Income, OrderReview, Expense
from .forms import OrderReviewForm
from reservations.models import Reservation
from customers.models import Customer
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.utils import timezone

# Create your views here.

@login_required
def order_list(request):
    """显示用户已完成的订单列表和评价/支付选项"""
    # 获取用户的已退房订单
    reservations = Reservation.objects.filter(
        user=request.user,
        status='checked_out'
    ).select_related('room', 'customer').order_by('-check_out_date')
    
    # 如果是管理员，可以查看所有已退房订单
    if request.user.is_superuser and request.GET.get('all') == '1':
        reservations = Reservation.objects.filter(
            status='checked_out'
        ).select_related('room', 'customer', 'user').order_by('-check_out_date')
    
    # 获取订单的支付和评价状态
    for reservation in reservations:
        # 检查支付状态
        reservation.is_paid = Income.objects.filter(reservation=reservation).exists()
        # 检查评价状态
        try:
            reservation.review = OrderReview.objects.get(reservation=reservation)
        except OrderReview.DoesNotExist:
            reservation.review = None
    
    return render(request, 'finance/order_list.html', {
        'reservations': reservations,
        'title': '我的订单',
        'is_admin': request.user.is_superuser
    })

@login_required
def expense_list(request):
    try:
        # 先获取当前用户关联的Customer对象
        customer = Customer.objects.get(user=request.user)
        # 获取该客户的所有消费记录
        expenses = Expense.objects.filter(
            Q(description__icontains=customer.name) |
            Q(description__icontains=customer.phone_number)
        ).order_by('-date')
    except Customer.DoesNotExist:
        expenses = Expense.objects.none()
        messages.warning(request, '未找到您的客户信息，请联系管理员。')
    
    return render(request, 'finance/expense_list.html', {
        'expenses': expenses
    })

@login_required
def add_review(request, reservation_id):
    try:
        # 先获取当前用户关联的Customer对象
        customer = Customer.objects.get(user=request.user)
        # 获取预订信息，确保只能评价自己的已退房订单
        reservation = get_object_or_404(
            Reservation, 
            id=reservation_id,
            customer=customer,
            status='checked_out'  # 只允许评价已退房的订单
        )
        
        # 检查是否已经评价过
        if hasattr(reservation, 'review'):
            messages.error(request, '您已经评价过这个订单了')
            return redirect('finance:order_list')
        
        if request.method == 'POST':
            form = OrderReviewForm(request.POST)
            if form.is_valid():
                review = form.save(commit=False)
                review.reservation = reservation
                review.user = request.user
                review.save()
                messages.success(request, '评价提交成功！感谢您的反馈。')
                return redirect('finance:order_list')
        else:
            form = OrderReviewForm()
        
        return render(request, 'finance/add_review.html', {
            'form': form,
            'reservation': reservation
        })
    except Customer.DoesNotExist:
        messages.error(request, '未找到您的客户信息，请联系管理员。')
        return redirect('finance:order_list')

@login_required
@require_POST
def pay_order(request, reservation_id):
    try:
        reservation = Reservation.objects.get(id=reservation_id)
        
        # 检查权限
        if not request.user.is_superuser and reservation.user != request.user:
            return JsonResponse({
                'success': False,
                'error': '您没有权限支付此订单'
            })
        
        # 检查订单状态
        if reservation.status != 'checked_out':
            return JsonResponse({
                'success': False,
                'error': '只能支付已退房的订单'
            })
        
        # 检查是否已支付
        if Income.objects.filter(reservation=reservation).exists():
            return JsonResponse({
                'success': False,
                'error': '此订单已支付'
            })
        
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
            'message': '支付成功'
        })
        
    except Reservation.DoesNotExist:
        return JsonResponse({
            'success': False,
            'error': '订单不存在'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'error': str(e)
        })

@login_required
def income_list(request):
    """显示用户的收入记录"""
    # 获取用户的收入记录
    if request.user.is_superuser:
        # 管理员可以看到所有收入记录
        incomes = Income.objects.all().select_related('reservation', 'reservation__room')
    else:
        # 普通用户只能看到自己的收入记录
        incomes = Income.objects.filter(
            reservation__user=request.user
        ).select_related('reservation', 'reservation__room')
    
    return render(request, 'finance/income_list.html', {
        'incomes': incomes,
        'title': '收入记录'
    })
