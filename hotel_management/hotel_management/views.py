from django.contrib.auth.views import LoginView
from django.shortcuts import redirect
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.urls import reverse, reverse_lazy
from django.views.generic import CreateView
from django.contrib.auth.models import User, Permission
from customers.models import Customer
from django.contrib.contenttypes.models import ContentType
from reservations.models import Reservation
from finance.models import Expense

class CustomLoginView(LoginView):
    template_name = 'custom_login.html'
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['role'] = self.request.GET.get('role', 'customer')
        return context
    
    def form_valid(self, form):
        role = self.request.POST.get('role')
        username = form.cleaned_data.get('username')
        password = form.cleaned_data.get('password')
        
        try:
            user = authenticate(username=username, password=password)
            
            if user is not None:
                if role == 'admin' and user.is_superuser:
                    login(self.request, user)
                    return redirect('admin:index')
                elif role == 'customer':
                    login(self.request, user)
                    if user.has_perm('reservations.view_reservation'):
                        return redirect('admin:index')
                    else:
                        messages.error(self.request, '账户未激活，请联系管理员')
                        return self.form_invalid(form)
                else:
                    messages.error(self.request, '您选择的用户类型与账号不匹配')
                    return self.form_invalid(form)
            else:
                messages.error(self.request, '用户名或密码错误')
                return self.form_invalid(form)
                
        except Exception as e:
            messages.error(self.request, f'登录时发生错误: {str(e)}')
            return self.form_invalid(form)
            
    def form_invalid(self, form):
        """如果表单验证失败，确保错误信息被显示"""
        for field in form.errors:
            for error in form.errors[field]:
                messages.error(self.request, f'{field}: {error}')
        return super().form_invalid(form)

class CustomerRegisterView(CreateView):
    model = User
    template_name = 'customer_register.html'
    fields = ['username', 'password', 'email']
    success_url = reverse_lazy('customer_login')

    def form_valid(self, form):
        user = form.save(commit=False)
        user.set_password(form.cleaned_data['password'])
        user.is_staff = True
        user.save()
        
        # 创建关联的顾客档案
        customer = Customer.objects.create(
            name=form.cleaned_data['username'],
            phone_number=self.request.POST.get('phone_number'),
            email=form.cleaned_data['email']
        )
        
        # 添加预订和支出的查看权限
        reservation_content_type = ContentType.objects.get_for_model(Reservation)
        expense_content_type = ContentType.objects.get_for_model(Expense)
        
        view_reservation = Permission.objects.get(
            content_type=reservation_content_type,
            codename='view_reservation'
        )
        add_reservation = Permission.objects.get(
            content_type=reservation_content_type,
            codename='add_reservation'
        )
        change_reservation = Permission.objects.get(
            content_type=reservation_content_type,
            codename='change_reservation'
        )
        delete_reservation = Permission.objects.get(
            content_type=reservation_content_type,
            codename='delete_reservation'
        )
        view_expense = Permission.objects.get(
            content_type=expense_content_type,
            codename='view_expense'
        )
        
        user.user_permissions.add(
            view_reservation, 
            add_reservation,
            change_reservation,
            delete_reservation,
            view_expense
        )
        
        messages.success(self.request, '注册成功，请登录')
        return redirect('customer_login') 