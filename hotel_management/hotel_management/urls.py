"""
URL configuration for hotel_management project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from django.views.generic import RedirectView
from django.contrib.auth.views import LogoutView
from .views import CustomLoginView, CustomerRegisterView

urlpatterns = [
    path('', RedirectView.as_view(url='/customer/login/', permanent=True)),
    path('customer/login/', CustomLoginView.as_view(template_name='custom_login.html'), 
         name='customer_login'),
    path('admin/login/', CustomLoginView.as_view(template_name='custom_login.html'), 
         name='admin_login'),
    path('customer/register/', CustomerRegisterView.as_view(), name='customer_register'),
    path('logout/', LogoutView.as_view(next_page='customer_login'), name='logout'),
    path('admin/logout/', LogoutView.as_view(next_page='admin_login'), name='admin_logout'),
    path('admin/', admin.site.urls),
    path('analytics/', include('analytics.urls')),
    path('reservations/', include('reservations.urls')),
    path('finance/', include('finance.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
