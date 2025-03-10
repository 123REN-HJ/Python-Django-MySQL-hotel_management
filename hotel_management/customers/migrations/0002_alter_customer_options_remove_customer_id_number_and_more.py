# Generated by Django 4.2.17 on 2025-03-05 23:55

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):
    dependencies = [
        ("customers", "0001_initial"),
    ]

    operations = [
        migrations.AlterModelOptions(
            name="customer",
            options={"verbose_name": "顾客", "verbose_name_plural": "顾客"},
        ),
        migrations.RemoveField(
            model_name="customer",
            name="id_number",
        ),
        migrations.RemoveField(
            model_name="customer",
            name="membership_level",
        ),
        migrations.RemoveField(
            model_name="customer",
            name="phone",
        ),
        migrations.RemoveField(
            model_name="customer",
            name="points",
        ),
        migrations.AddField(
            model_name="customer",
            name="created_at",
            field=models.DateTimeField(
                default=django.utils.timezone.now, verbose_name="创建时间"
            ),
        ),
        migrations.AddField(
            model_name="customer",
            name="phone_number",
            field=models.CharField(
                blank=True, max_length=11, null=True, unique=True, verbose_name="手机号码"
            ),
        ),
        migrations.AddField(
            model_name="customer",
            name="updated_at",
            field=models.DateTimeField(auto_now=True, verbose_name="更新时间"),
        ),
        migrations.AlterField(
            model_name="customer",
            name="address",
            field=models.CharField(
                blank=True, max_length=200, null=True, verbose_name="地址"
            ),
        ),
        migrations.AlterField(
            model_name="customer",
            name="email",
            field=models.EmailField(max_length=254, verbose_name="邮箱"),
        ),
    ]
