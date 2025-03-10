from django.db import models

class DashboardMetric(models.Model):
    date = models.DateField(auto_now_add=True)
    occupancy_rate = models.FloatField(verbose_name='入住率')
    daily_revenue = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='日收入')
    satisfaction_score = models.FloatField(verbose_name='满意度评分')
    total_bookings = models.IntegerField(verbose_name='总预订数')
    
    class Meta:
        verbose_name = '运营指标'
        verbose_name_plural = '运营指标' 