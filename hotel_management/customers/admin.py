from django.contrib import admin
from django.contrib.auth.models import User

# Register your models here.
from customers.models import Customer


@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'email', 'user', 'created_at', 'updated_at']
    list_filter = ['created_at', 'updated_at']
    search_fields = ['name', 'phone_number', 'email', 'user__username']
    raw_id_fields = ['user']
    list_per_page = 10

    fieldsets = (
        ('基本信息', {
            'fields': ('name', 'phone_number', 'email')
        }),
        ('其他信息', {
            'fields': ('address',)
        }),
    )

    readonly_fields = ['created_at', 'updated_at']

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "user":
            kwargs["queryset"] = User.objects.filter(is_staff=False)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

    def save_model(self, request, obj, form, change):
        # 如果是新建客户且没有指定用户
        if not change and not obj.user:
            # 创建新用户
            username = obj.phone_number  # 使用手机号作为用户名
            user = User.objects.create_user(
                username=username,
                email=obj.email,
                password=username  # 初始密码设置为手机号
            )
            obj.user = user
        super().save_model(request, obj, form, change)
