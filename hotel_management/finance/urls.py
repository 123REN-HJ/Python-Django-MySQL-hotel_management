from django.urls import path
from . import views

app_name = 'finance'

urlpatterns = [
    path('income/', views.income_list, name='income_list'),
    path('expenses/', views.expense_list, name='expense_list'),
    path('orders/', views.order_list, name='order_list'),
    path('orders/<int:reservation_id>/review/', views.add_review, name='add_review'),
    path('api/finance/pay-order/<int:reservation_id>/', views.pay_order, name='pay_order'),
] 