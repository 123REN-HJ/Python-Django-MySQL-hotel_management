from django.urls import path
from .admin import DashboardView

app_name = 'analytics'

urlpatterns = [
    path('dashboard/', DashboardView.as_view(), name='dashboard'),
] 