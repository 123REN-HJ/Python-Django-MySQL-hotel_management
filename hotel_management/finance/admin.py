# Register your models here.
from django.contrib import admin
from finance.models import Income, Expense, OrderReview
from reservations.models import Reservation
from django.urls import path, reverse
from django.utils.html import format_html
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.http import HttpResponseRedirect
from decimal import Decimal


class OrderReviewInline(admin.TabularInline):
    """在预订详情中显示评价"""
    model = OrderReview
    extra = 0
    readonly_fields = ['user', 'rating', 'comment', 'created_at']
    can_delete = False
    verbose_name = "订单评价"
    verbose_name_plural = "订单评价"
    
    def has_add_permission(self, request, obj=None):
        return False


@admin.register(Income)
class IncomeAdmin(admin.ModelAdmin):
    list_display = ('date', 'amount', 'source', 'description', 'reservation')
    ordering = ('-date',)
    list_display_links = ('amount', )
    actions_on_top = True
    actions_on_bottom = False
    search_fields = ['date', 'source', 'description']
    list_filter = ['source', 'date']
    raw_id_fields = ['reservation']
    fieldsets = (
        ('收入详情', {
            'fields': ('date', 'amount', 'source', 'description', 'reservation'),
        }),
    )
    list_per_page = 20


@admin.register(Expense)
class ExpenseAdmin(admin.ModelAdmin):
    list_display = ('date', 'amount', 'category', 'description')
    ordering = ('-date',)
    list_display_links = ('amount', )
    actions_on_top = True
    actions_on_bottom = False
    search_fields = ['date', 'category', 'description']
    list_filter = ['category', 'date']
    fieldsets = (
        ('支出详情', {
            'fields': ('date', 'amount', 'category', 'description'),
        }),
    )
    list_per_page = 20


@admin.register(OrderReview)
class OrderReviewAdmin(admin.ModelAdmin):
    """订单评价管理"""
    list_display = ('reservation', 'get_customer', 'get_room', 'rating_stars', 'comment', 'created_at')
    list_filter = ['rating', 'created_at']
    search_fields = ['reservation__room__room_number', 'reservation__customer__name', 'comment']
    readonly_fields = ['reservation', 'user', 'created_at', 'updated_at']
    fieldsets = (
        ('评价信息', {
            'fields': ('reservation', 'user', 'rating', 'comment')
        }),
        ('时间信息', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
    
    def get_customer(self, obj):
        if obj.reservation and obj.reservation.customer:
            return obj.reservation.customer.name
        return "-"
    get_customer.short_description = '客户'
    
    def get_room(self, obj):
        if obj.reservation and obj.reservation.room:
            return obj.reservation.room.room_number
        return "-"
    get_room.short_description = '房间号'
    
    def rating_stars(self, obj):
        stars = '★' * obj.rating + '☆' * (5 - obj.rating)
        return format_html('<span style="color: #f8a100;">{}</span>', stars)
    rating_stars.short_description = '评分'
    
    def has_add_permission(self, request):
        """禁止直接添加评价，必须通过订单列表添加"""
        return False
    
    def get_queryset(self, request):
        """管理员可以看到所有评价，普通用户只能看到自己的评价"""
        # 获取所有评价的QuerySet
        qs = super().get_queryset(request)
        
        # 根据用户权限过滤
        if not request.user.is_superuser:
            qs = qs.filter(user=request.user)
            
        # 始终返回QuerySet，而非单个对象
        return qs


# 注册自定义URL和视图
def completed_orders_view(request):
    """显示用户的已完成订单列表，并提供评价功能"""
    # 获取用户的已退房订单
    reservations = Reservation.objects.filter(
        user=request.user,
        status='checked_out'
    ).select_related('room', 'customer').order_by('-check_out_date')
    
    # 如果是管理员，可以看到所有已退房订单
    if request.user.is_superuser:
        reservations = Reservation.objects.filter(
            status='checked_out'
        ).select_related('room', 'customer', 'user').order_by('-check_out_date')
    
    # 获取订单的评价状态
    for reservation in reservations:
        try:
            reservation.review = OrderReview.objects.get(reservation=reservation)
        except OrderReview.DoesNotExist:
            reservation.review = None
        
        # 检查支付状态
        reservation.is_paid = Income.objects.filter(reservation=reservation).exists()
    
    context = {
        'title': '订单评价管理',
        'reservations': reservations,
        'cl': {
            'result_count': len(reservations)
        },
        'is_admin': request.user.is_superuser,
        'has_permission': True,
        'app_label': 'finance',
        'site_header': admin.site.site_header,
        'site_title': admin.site.site_title,
    }
    
    return render(request, 'admin/finance/completed_orders_changelist.html', context)


def add_review_view(request, reservation_id):
    """添加评价视图"""
    reservation = get_object_or_404(Reservation, id=reservation_id, status='checked_out')
    
    # 检查权限，只能评价自己的订单
    if not request.user.is_superuser and reservation.user != request.user:
        messages.error(request, '您无权评价此订单')
        return HttpResponseRedirect(reverse('admin:completed-orders'))
    
    # 检查是否已经评价过
    try:
        review = OrderReview.objects.get(reservation=reservation)
        messages.warning(request, '您已经评价过此订单')
        return HttpResponseRedirect(reverse('admin:completed-orders'))
    except OrderReview.DoesNotExist:
        pass
    
    if request.method == 'POST':
        rating = request.POST.get('rating')
        comment = request.POST.get('comment')
        
        if not rating or not comment:
            messages.error(request, '评分和评价内容不能为空')
        else:
            # 创建评价
            OrderReview.objects.create(
                reservation=reservation,
                user=request.user,
                rating=rating,
                comment=comment
            )
            messages.success(request, '评价提交成功！')
            return HttpResponseRedirect(reverse('admin:completed-orders'))
    
    return render(request, 'admin/finance/add_review.html', {
        'reservation': reservation,
        'title': '添加订单评价',
        'site_header': admin.site.site_header,
        'has_permission': True,
        'app_label': 'finance',
    })


# 通过get_urls方法注册自定义URL
original_get_urls = admin.AdminSite.get_urls

def get_urls(self):
    """添加自定义URL"""
    urls = original_get_urls(self)
    custom_urls = [
        path('finance/completed-orders/', self.admin_view(completed_orders_view), name='completed-orders'),
        path('finance/add-review/<int:reservation_id>/', self.admin_view(add_review_view), name='add-review'),
        path('finance/satisfaction-analysis/', self.admin_view(satisfaction_analysis_view), name='satisfaction-analysis'),
        path('finance/order-bill/<int:reservation_id>/', self.admin_view(order_bill_view), name='order-bill'),
    ]
    return custom_urls + urls

# 覆盖AdminSite.get_urls方法
admin.AdminSite.get_urls = get_urls

# 在文件末尾添加客户满意度分析视图
def satisfaction_analysis_view(request):
    """客户满意度分析视图，统计和展示评价数据"""
    from django.db.models import Count, Avg, Case, When, IntegerField, F
    from django.db.models.functions import TruncMonth, ExtractMonth
    import json
    from datetime import datetime, timedelta
    
    # 基础统计数据
    total_reviews = OrderReview.objects.count()
    avg_rating = OrderReview.objects.aggregate(avg=Avg('rating'))['avg'] or 0
    
    # 评分分布
    rating_distribution = OrderReview.objects.values('rating').annotate(
        count=Count('id')
    ).order_by('rating')
    
    # 转换为适合图表使用的格式
    rating_labels = []
    rating_data = []
    rating_colors = []
    
    # 颜色映射
    color_map = {
        1: '#dc3545',  # 红色
        2: '#fd7e14',  # 橙色
        3: '#ffc107',  # 黄色
        4: '#20c997',  # 青绿色
        5: '#28a745',  # 绿色
    }
    
    # 初始化数据
    rating_counts = {i: 0 for i in range(1, 6)}
    
    # 填充实际数据
    for item in rating_distribution:
        rating_counts[item['rating']] = item['count']
    
    # 构建图表数据
    for rating, count in rating_counts.items():
        rating_label = f"{rating}星 ({count}个)"
        rating_labels.append(rating_label)
        rating_data.append(count)
        rating_colors.append(color_map.get(rating, '#6c757d'))
    
    # 计算满意度百分比
    satisfaction_percentage = sum(rating_counts[i] * i for i in range(1, 6)) / (total_reviews * 5) * 100 if total_reviews > 0 else 0
    
    # 按月份统计评分趋势（近12个月）
    end_date = datetime.now().date()
    start_date = end_date - timedelta(days=365)
    
    monthly_ratings = OrderReview.objects.filter(
        created_at__date__gte=start_date,
        created_at__date__lte=end_date
    ).annotate(
        month=TruncMonth('created_at')
    ).values('month').annotate(
        avg_rating=Avg('rating'),
        count=Count('id')
    ).order_by('month')
    
    # 转换为图表格式
    trend_labels = []
    trend_data = []
    review_counts = []
    
    # 准备月份数据
    for i in range(12):
        month_date = (end_date - timedelta(days=30 * i)).replace(day=1)
        month_str = month_date.strftime('%Y-%m')
        trend_labels.insert(0, month_str)
        trend_data.insert(0, 0)  # 默认评分为0
        review_counts.insert(0, 0)  # 默认评价数为0
    
    # 填充实际数据
    for item in monthly_ratings:
        month_str = item['month'].strftime('%Y-%m')
        if month_str in trend_labels:
            idx = trend_labels.index(month_str)
            trend_data[idx] = round(item['avg_rating'], 2)
            review_counts[idx] = item['count']
    
    # 按房间类型统计评分
    room_type_ratings = OrderReview.objects.values(
        'reservation__room__room_type'
    ).annotate(
        avg_rating=Avg('rating'),
        count=Count('id')
    ).order_by('-avg_rating')
    
    # 转换房间类型代码为名称
    for item in room_type_ratings:
        room_type = item['reservation__room__room_type']
        # 获取房间类型名称 (需要从Room模型获取choices)
        from rooms.models import Room
        room_types = dict(Room.ROOM_TYPES)
        item['room_type_name'] = room_types.get(room_type, '未知')
    
    # 评价内容词云数据
    from django.db.models import Value
    from django.db.models.functions import Concat
    
    # 获取最近100条评价
    recent_reviews = OrderReview.objects.all().order_by('-created_at')[:100]
    
    # 创建评价摘要数据
    review_summaries = []
    for review in recent_reviews:
        review_summaries.append({
            'id': review.id,
            'rating': review.rating,
            'comment': review.comment[:100] + '...' if len(review.comment) > 100 else review.comment,
            'customer': review.reservation.customer.name if review.reservation and review.reservation.customer else "未知",
            'room': review.reservation.room.room_number if review.reservation and review.reservation.room else "未知",
            'date': review.created_at.strftime('%Y-%m-%d'),
        })
    
    # 准备上下文数据
    context = {
        'title': '客户满意度分析',
        'has_permission': True,
        'site_header': admin.site.site_header,
        'site_title': admin.site.site_title,
        'app_label': 'finance',
        
        # 基础统计数据
        'total_reviews': total_reviews,
        'avg_rating': round(avg_rating, 2),
        'satisfaction_percentage': round(satisfaction_percentage, 1),
        
        # 评分分布数据
        'rating_labels': json.dumps(rating_labels),
        'rating_data': json.dumps(rating_data),
        'rating_colors': json.dumps(rating_colors),
        
        # 评分趋势数据
        'trend_labels': json.dumps(trend_labels),
        'trend_data': json.dumps(trend_data),
        'review_counts': json.dumps(review_counts),
        
        # 房间类型评分数据
        'room_type_ratings': room_type_ratings,
        
        # 最近评价
        'review_summaries': review_summaries,
    }
    
    return render(request, 'admin/finance/satisfaction_analysis.html', context)

# 添加账单详情视图
def order_bill_view(request, reservation_id):
    """显示订单的账单详情"""
    from reservations.models import Reservation
    from django.contrib.auth.decorators import login_required
    
    # 获取预订信息
    reservation = get_object_or_404(Reservation, id=reservation_id)
    
    # 检查权限，只能查看自己的订单账单
    if not request.user.is_superuser and reservation.user != request.user:
        messages.error(request, '您无权查看此订单账单')
        return HttpResponseRedirect(reverse('admin:completed-orders'))
    
    # 获取相关的收入记录
    income = Income.objects.filter(reservation=reservation).first()
    
    # 计算账单明细
    days = (reservation.check_out_date - reservation.check_in_date).days
    daily_rate = reservation.room.price
    room_total = daily_rate * days
    
    # 服务费和税收计算示例（实际计算规则根据需求调整）
    service_fee = room_total * Decimal('0.1')  # 服务费10%
    tax = room_total * Decimal('0.05')  # 税费5%
    total_amount = room_total + service_fee + tax
    
    # 准备上下文数据
    context = {
        'title': '订单账单详情',
        'reservation': reservation,
        'income': income,
        'has_permission': True,
        'site_header': admin.site.site_header,
        'site_title': admin.site.site_title,
        'app_label': 'finance',
        
        # 账单明细
        'check_in_date': reservation.check_in_date,
        'check_out_date': reservation.check_out_date,
        'days': days,
        'daily_rate': daily_rate,
        'room_total': room_total,
        'service_fee': service_fee,
        'tax': tax,
        'total_amount': total_amount,
        'is_paid': income is not None,
        'payment_date': income.date if income else None,
    }
    
    return render(request, 'admin/finance/order_bill.html', context)
