from django.db import models
from django.contrib.auth.models import User
from django.conf import settings
from customers.models import Customer
from rooms.models import Room
from django.utils import timezone
from django.core.exceptions import ValidationError


def get_default_user():
    return User.objects.filter(is_superuser=True).first().id


# Create your models here.
class Reservation(models.Model):
    STATUS_CHOICES = (
        ('pending', '待确认'),
        ('confirmed', '已确认'),
        ('checked_in', '已入住'),
        ('checked_out', '已退房'),
        ('cancelled', '已取消'),
    )

    user = models.ForeignKey(
        User, 
        on_delete=models.CASCADE, 
        verbose_name='预订用户',
        default=get_default_user
    )
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, verbose_name='客户')
    room = models.ForeignKey(Room, on_delete=models.CASCADE, verbose_name='房间')
    check_in_date = models.DateField(verbose_name='入住日期')
    check_out_date = models.DateField(verbose_name='退房日期')
    number_of_guests = models.IntegerField(verbose_name='入住人数')
    special_requests = models.TextField(blank=True, verbose_name='特殊要求')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending', verbose_name='状态')
    total_price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='总价', null=True, blank=True)
    notes = models.TextField(blank=True, verbose_name='备注')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    def __str__(self):
        return f"{self.room.room_number} - {self.customer.name} ({self.check_in_date} to {self.check_out_date})"

    class Meta:
        verbose_name = '预订'
        verbose_name_plural = '预订管理'
        ordering = ['-created_at']

    def clean(self):
        if self.check_in_date and self.check_out_date:
            if self.check_in_date >= self.check_out_date:
                raise ValidationError('退房日期必须晚于入住日期')
            
            # 检查日期范围内是否有其他预订
            overlapping = Reservation.objects.filter(
                room=self.room,
                status__in=['pending', 'confirmed', 'checked_in'],
                check_in_date__lt=self.check_out_date,
                check_out_date__gt=self.check_in_date
            )
            
            if self.pk:
                overlapping = overlapping.exclude(pk=self.pk)
            
            if overlapping.exists():
                raise ValidationError('该房间在所选日期范围内已被预订')

    def save(self, *args, **kwargs):
        if not self.total_price:  # 如果总价为空
            self.total_price = self.room.price * (self.check_out_date - self.check_in_date).days
        super().save(*args, **kwargs)
