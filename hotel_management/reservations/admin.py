from django.contrib import admin
from django.urls import path
from django.shortcuts import render, redirect
from django.contrib import messages
from django.utils import timezone
from django.utils.html import format_html
from django.http import HttpResponseRedirect
from django.urls import reverse
from datetime import datetime
from .models import Reservation
from customers.models import Customer
from rooms.models import Room
from finance.models import Income, OrderReview
from finance.admin import OrderReviewInline


# 添加订单评价内联显示
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


@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ['id', 'customer', 'room', 'check_in_date', 'check_out_date', 'status', 'created_at', 'get_action_buttons']
    list_filter = ['status', 'check_in_date', 'check_out_date']
    search_fields = ['customer__name', 'room__room_number']
    
    change_list_template = 'admin/reservation/reservation_changelist.html'
    
    actions = ['mark_as_checked_in', 'mark_as_checked_out', 'mark_as_cancelled']
    
    # 添加订单评价内联显示
    inlines = [OrderReviewInline]
    
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('book-room/', self.book_room_view, name='book-room'),
        ]
        return custom_urls + urls
    
    def book_room_view(self, request):
        # 获取可用房间
        available_rooms = Room.objects.filter(status='available')
        
        if request.method == 'POST':
            room_id = request.POST.get('room')
            check_in = request.POST.get('check_in_date')
            check_out = request.POST.get('check_out_date')
            guests = request.POST.get('number_of_guests')
            special_requests = request.POST.get('special_requests', '')
            
            try:
                # 转换日期字符串为日期对象
                check_in_date = datetime.strptime(check_in, '%Y-%m-%d').date()
                check_out_date = datetime.strptime(check_out, '%Y-%m-%d').date()
                
                room = Room.objects.get(id=room_id)
                customer = Customer.objects.get(name=request.user.username)
                
                # 创建预订
                reservation = Reservation.objects.create(
                    user=request.user,
                    customer=customer,
                    room=room,
                    check_in_date=check_in_date,
                    check_out_date=check_out_date,
                    number_of_guests=int(guests),
                    special_requests=special_requests,
                    status='pending'  # 使用小写以匹配 STATUS_CHOICES
                )
                
                # 更新房间状态
                room.status = 'reserved'
                room.save()
                
                messages.success(request, '预订成功！')
                return redirect('admin:reservations_reservation_changelist')
                
            except ValueError as e:
                messages.error(request, f'预订失败：日期格式无效')
            except Exception as e:
                messages.error(request, f'预订失败：{str(e)}')
        
        context = {
            'available_rooms': available_rooms,
            'title': '预订房间',
            'opts': self.model._meta,
        }
        return render(request, 'admin/reservation/book_room.html', context)
    
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            qs = qs.filter(user=request.user)
        return qs
    
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            return ['status', 'created_at', 'updated_at']
        return ['created_at', 'updated_at']

    def save_model(self, request, obj, form, change):
        if change and 'status' in form.changed_data:
            old_status = Reservation.objects.get(pk=obj.pk).status
            new_status = obj.status
            
            # 更新房间状态
            if new_status == 'confirmed':
                obj.room.status = 'reserved'
            elif new_status == 'checked_in':
                obj.room.status = 'occupied'
            elif new_status in ['checked_out', 'cancelled']:
                obj.room.status = 'available'
            
            obj.room.save()
            
            # 添加状态变更消息
            messages.success(request, f'预订状态从 {dict(Reservation.STATUS_CHOICES).get(old_status)} 更改为 {dict(Reservation.STATUS_CHOICES).get(new_status)}')
        
        if not change:
            obj.user = request.user
        super().save_model(request, obj, form, change)
    
    def has_add_permission(self, request):
        # 禁用默认的添加按钮
        return False
    
    def has_change_permission(self, request, obj=None):
        if obj is None:
            return True
        return request.user.is_superuser or obj.user == request.user
    
    def has_delete_permission(self, request, obj=None):
        if obj is None:
            return True
        return request.user.is_superuser or obj.user == request.user

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "customer" and not request.user.is_superuser:
            kwargs["queryset"] = Customer.objects.filter(name=request.user.username)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

    def get_fields(self, request, obj=None):
        fields = ['room', 'customer', 'check_in_date', 'check_out_date', 'status', 
                 'total_price', 'number_of_guests', 'special_requests', 'notes']
        if obj:  # 只在编辑时显示时间字段
            fields.extend(['created_at', 'updated_at'])
        return fields

    def get_fieldsets(self, request, obj=None):
        fieldsets = [
            ('预订信息', {
                'fields': ('room', 'customer', 'check_in_date', 'check_out_date', 
                          'status', 'total_price', 'number_of_guests', 'special_requests')
            }),
            ('备注信息', {
                'fields': ('notes',),
                'classes': ('collapse',)
            })
        ]
        if obj:  # 只在编辑时显示时间信息
            fieldsets.append(
                ('时间信息', {
                    'fields': ('created_at', 'updated_at'),
                    'classes': ('collapse',)
                })
            )
        return fieldsets

    def get_actions(self, request):
        # 移除批量操作
        actions = super().get_actions(request)
        if not request.user.is_superuser:
            return {}
        return actions

    def get_action_buttons(self, obj):
        """为每行添加操作按钮"""
        if not obj:
            return ''
        
        if not self.request.user.is_superuser:
            return ''

        button_style = """
            background-color: {bg_color}; 
            color: {text_color}; 
            margin: 2px;
            padding: 4px 8px;
            border-radius: 4px;
            border: 1px solid {border_color};
            text-decoration: none;
            font-size: 12px;
            transition: all 0.3s;
        """

        buttons = []
        
        if obj.status == 'pending':
            buttons.append(
                f'<a class="button" href="#" onclick="confirmReservation({obj.id})" style="'
                f'{button_style.format(bg_color="#e7f5e7", text_color="#2c662d", border_color="#93d3b5")}">确认</a>'
            )
        elif obj.status == 'confirmed':
            buttons.append(
                f'<a class="button" href="#" onclick="checkInReservation({obj.id})" style="'
                f'{button_style.format(bg_color="#e7f0ff", text_color="#1a56db", border_color="#9ec5fe")}">办理入住</a>'
            )
        elif obj.status == 'checked_in':
            buttons.append(
                f'<a class="button" href="#" onclick="checkOutReservation({obj.id})" style="'
                f'{button_style.format(bg_color="#e7f6f8", text_color="#1a7f8c", border_color="#9eeaf9")}">办理退房</a>'
            )
        
        if obj.status not in ['checked_out', 'cancelled']:
            buttons.append(
                f'<a class="button" href="#" onclick="cancelReservation({obj.id})" style="'
                f'{button_style.format(bg_color="#fde7e7", text_color="#922c2c", border_color="#fca5a5")}">取消</a>'
            )
        
        return format_html(''.join(buttons))
    
    get_action_buttons.short_description = '操作'
    get_action_buttons.allow_tags = True

    def changelist_view(self, request, extra_context=None):
        # 保存 request 对象以供后续使用
        self.request = request
        return super().changelist_view(request, extra_context)

    def mark_as_checked_in(self, request, queryset):
        updated = queryset.update(status='checked_in')
        self.message_user(request, f'成功将 {updated} 条预订标记为已入住')
    mark_as_checked_in.short_description = '标记为已入住'
    
    def mark_as_checked_out(self, request, queryset):
        for reservation in queryset:
            # 更新预订状态
            reservation.status = 'checked_out'
            
            # 更新房间状态为可用
            reservation.room.status = 'available'
            reservation.room.save()
            
            reservation.save()
            
            # 创建收入记录
            Income.objects.get_or_create(
                reservation=reservation,
                defaults={
                    'date': timezone.now().date(),
                    'amount': reservation.total_price,
                    'source': 'Room',
                    'description': f'房间 {reservation.room.room_number} 的住宿费用'
                }
            )
        
        self.message_user(request, f'成功将 {queryset.count()} 条预订标记为已退房，并创建了相应的收入记录')
    mark_as_checked_out.short_description = '标记为已退房'
    
    def mark_as_cancelled(self, request, queryset):
        updated = queryset.update(status='cancelled')
        self.message_user(request, f'成功将 {updated} 条预订标记为已取消')
    mark_as_cancelled.short_description = '标记为已取消'
    
    class Media:
        js = ('admin/js/reservation_actions.js',)
