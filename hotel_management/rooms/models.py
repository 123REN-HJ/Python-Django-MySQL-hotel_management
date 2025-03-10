from django.db import models


class Room(models.Model):
    ROOM_TYPES = [
        ('standard', '标准间'),
        ('double', '双床房'),
        ('deluxe', '豪华间'),
        ('suite', '套房'),
        ('family', '家庭房'),
        ('business', '商务间'),
    ]
    
    STATUS_CHOICES = (
        ('available', '空闲'),
        ('occupied', '已入住'),
        ('reserved', '已预订'),
        ('maintenance', '维护中'),
    )

    room_number = models.CharField(max_length=10, unique=True, verbose_name='房间号')
    room_type = models.CharField(max_length=50, choices=ROOM_TYPES, verbose_name='房间类型')
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='价格')
    facilities = models.TextField(verbose_name='设施')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='available', verbose_name='状态')
    floor = models.IntegerField(verbose_name='楼层')
    capacity = models.IntegerField(verbose_name='容纳人数')
    description = models.TextField(blank=True, verbose_name='描述')

    pictures = models.ImageField(upload_to='pictures/', blank=True, null=True, help_text="房间主图",
                              verbose_name="房间主图")

    class Meta:
        verbose_name = '房间'
        verbose_name_plural = '房间管理'

    def __str__(self):
        return f"{self.room_number} - {self.get_room_type_display()}"
