from django.db import models


# Create your models here.
class Employee(models.Model):
    name = models.CharField(max_length=100, verbose_name='姓名')
    position = models.CharField(max_length=100, verbose_name='职位')
    phone = models.CharField(max_length=15, verbose_name='联系方式')
    email = models.EmailField(blank=True, verbose_name='邮箱')
    address = models.TextField(blank=True, verbose_name='地址')
    salary = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='工资')
    hire_date = models.DateField(verbose_name='入职日期')
    status = models.CharField(max_length=20, default='Active', verbose_name='状态')

    def __str__(self):
        return self.name
