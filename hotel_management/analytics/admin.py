from django.contrib import admin
from django.db.models import Avg, Sum, Count
from django.utils import timezone
from datetime import timedelta
from django.views.generic import TemplateView
from django.contrib.admin.views.decorators import staff_member_required
from django.utils.decorators import method_decorator
from reservations.models import Reservation
from finance.models import Income, Expense
from rooms.models import Room

@method_decorator(staff_member_required, name='dispatch')
class DashboardView(TemplateView):
    template_name = 'admin/analytics/dashboard.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        
        # 获取最近30天的数据
        thirty_days_ago = timezone.now().date() - timedelta(days=30)
        
        # 计算房间总数
        total_rooms = Room.objects.count()
        
        # 计算当前入住率
        current_bookings = Reservation.objects.filter(
            check_in_date__lte=timezone.now().date(),
            check_out_date__gt=timezone.now().date()
        ).count()
        current_occupancy = (current_bookings / total_rooms * 100) if total_rooms > 0 else 0
        
        # 获取最近30天的收入数据
        monthly_income = Income.objects.filter(
            date__gte=thirty_days_ago
        ).aggregate(Sum('amount'))['amount__sum'] or 0
        
        # 获取最近30天的预订数据
        monthly_bookings = Reservation.objects.filter(
            created_at__gte=thirty_days_ago
        ).count()
        
        # 获取每日入住率数据（用于图表）
        daily_occupancy = []
        daily_revenue = []
        
        for i in range(7):
            date = timezone.now().date() - timedelta(days=i)
            bookings = Reservation.objects.filter(
                check_in_date__lte=date,
                check_out_date__gt=date
            ).count()
            occupancy = (bookings / total_rooms * 100) if total_rooms > 0 else 0
            daily_occupancy.append({
                'date': date.strftime('%m-%d'),
                'occupancy': round(occupancy, 1)
            })
            
            # 获取每日收入
            daily_income = Income.objects.filter(date=date).aggregate(
                Sum('amount'))['amount__sum'] or 0
            daily_revenue.append({
                'date': date.strftime('%m-%d'),
                'revenue': float(daily_income)
            })
        
        # 反转列表使其按时间正序显示
        daily_occupancy.reverse()
        daily_revenue.reverse()
        
        context.update({
            'current_occupancy': round(current_occupancy, 1),
            'monthly_income': monthly_income,
            'monthly_bookings': monthly_bookings,
            'daily_occupancy': daily_occupancy,
            'daily_revenue': daily_revenue,
        })
        
        return context 