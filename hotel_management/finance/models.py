from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from reservations.models import Reservation
from django.contrib.auth.models import User


# Create your models here.
class Income(models.Model):
    INCOME_SOURCES = (
        ('Room', '客房收入'),
        ('Food', '餐饮收入'),
        ('Other', '其他收入'),
    )

    date = models.DateField(verbose_name='日期')
    amount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='金额')
    source = models.CharField(max_length=50, choices=INCOME_SOURCES, verbose_name='收入来源')
    description = models.TextField(blank=True, verbose_name='描述')
    reservation = models.OneToOneField(Reservation, on_delete=models.SET_NULL, null=True, blank=True, verbose_name='关联预订')

    class Meta:
        verbose_name = '收入'
        verbose_name_plural = '收入管理'

    def __str__(self):
        return f"{self.date} - {self.source}: {self.amount}"


class Expense(models.Model):
    EXPENSE_CATEGORIES = (
        ('Salary', '员工工资'),
        ('Maintenance', '维修费用'),
        ('Utilities', '水电费'),
        ('Other', '其他支出'),
    )

    date = models.DateField(verbose_name='日期')
    amount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='金额')
    category = models.CharField(max_length=50, choices=EXPENSE_CATEGORIES, verbose_name='支出类别')
    description = models.TextField(blank=True, verbose_name='描述')

    class Meta:
        verbose_name = '支出'
        verbose_name_plural = '支出管理'

    def __str__(self):
        return f"{self.date} - {self.category}: {self.amount}"

class OrderReview(models.Model):
    RATING_CHOICES = (
        (1, '1星'),
        (2, '2星'),
        (3, '3星'),
        (4, '4星'),
        (5, '5星'),
    )
    
    reservation = models.OneToOneField(Reservation, on_delete=models.CASCADE, related_name='review', verbose_name='预订')
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name='评价用户')
    rating = models.IntegerField(
        choices=RATING_CHOICES,
        validators=[MinValueValidator(1), MaxValueValidator(5)],
        verbose_name='评分'
    )
    comment = models.TextField(verbose_name='评价内容')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        verbose_name = '订单详情'
        verbose_name_plural = '订单详情'
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.reservation} - {self.rating}星"