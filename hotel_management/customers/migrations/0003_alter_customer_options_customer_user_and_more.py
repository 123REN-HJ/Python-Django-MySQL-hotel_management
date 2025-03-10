# Generated by Django 4.2.20 on 2025-03-07 01:38

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("customers", "0002_alter_customer_options_remove_customer_id_number_and_more"),
    ]

    operations = [
        migrations.AlterModelOptions(
            name="customer",
            options={"verbose_name": "顾客", "verbose_name_plural": "顾客管理"},
        ),
        migrations.AddField(
            model_name="customer",
            name="user",
            field=models.OneToOneField(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
                to=settings.AUTH_USER_MODEL,
                verbose_name="用户",
            ),
        ),
        migrations.AlterField(
            model_name="customer",
            name="address",
            field=models.TextField(blank=True, verbose_name="地址"),
        ),
        migrations.AlterField(
            model_name="customer",
            name="created_at",
            field=models.DateTimeField(auto_now_add=True, verbose_name="创建时间"),
        ),
        migrations.AlterField(
            model_name="customer",
            name="email",
            field=models.EmailField(blank=True, max_length=254, verbose_name="邮箱"),
        ),
        migrations.AlterField(
            model_name="customer",
            name="phone_number",
            field=models.CharField(max_length=15, verbose_name="联系方式"),
        ),
    ]
