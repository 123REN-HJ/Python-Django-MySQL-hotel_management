from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone


# Create your models here.
class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, verbose_name='用户', null=True, blank=True)
    name = models.CharField(max_length=100, verbose_name='姓名')
    phone_number = models.CharField(max_length=15, verbose_name='联系方式')
    email = models.EmailField(blank=True, verbose_name='邮箱')
    address = models.TextField(blank=True, verbose_name='地址')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')

    class Meta:
        verbose_name = '顾客'
        verbose_name_plural = '顾客管理'

    def __str__(self):
        return self.name
