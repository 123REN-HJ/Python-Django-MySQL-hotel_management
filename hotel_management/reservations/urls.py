from django.urls import path
from . import views

app_name = 'reservations'

urlpatterns = [
    path('reservation/<int:reservation_id>/<str:action>/', 
         views.update_reservation_status, 
         name='update_reservation_status'),
    path('', views.reservation_list, name='list'),
    path('<int:reservation_id>/', views.reservation_detail, name='detail'),
    path('<int:reservation_id>/cancel/', views.cancel_reservation, name='cancel'),
] 