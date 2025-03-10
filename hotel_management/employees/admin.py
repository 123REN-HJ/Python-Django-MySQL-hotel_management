from django.contrib import admin

from employees.models import Employee


@admin.register(Employee)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ('name', 'position', 'phone', 'email', 'address', 'salary', 'hire_date', 'status')
    ordering = ('-name',)
    list_display_links = ('name', )
    actions_on_top = True
    actions_on_bottom = False
    search_fields = ['name', 'position', 'phone']
    fieldsets = (
        (None, {
            'fields': ('name', 'position', 'phone'),
        }),
        ('详细信息', {
            'fields': ('email', 'address', 'salary', 'hire_date', 'status'),
        }),
    )
    list_per_page = 20
