from django.contrib import admin

# Register your models here.
from django.contrib import admin
from django.utils.html import format_html

from rooms.models import Room

admin.site.site_header = '酒店管理系统'
admin.site.site_title = '酒店管理系统后台'
admin.site.index_title = '欢迎来到酒店管理系统后台'


from django.contrib import admin
from django.utils.html import format_html


@admin.register(Room)
class RoomAdmin(admin.ModelAdmin):
    list_display = ['room_number', 'room_type', 'price', 'status', 'floor', 'capacity']
    list_filter = ['room_type', 'status', 'floor']
    search_fields = ['room_number', 'description']
    list_per_page = 10

    fieldsets = (
        ('基本信息', {
            'fields': ('room_number', 'room_type', 'price', 'status')
        }),
        ('详细信息', {
            'fields': ('floor', 'capacity', 'facilities', 'description', 'pictures')
        }),
    )

    def picture_image(self, obj):
        if obj.pictures:
            return format_html('<a href="{}" data-lightbox="room-{}" data-title="房间图片"><img src="{}" width="100" height="100" /></a>', 
                             obj.pictures.url, obj.id, obj.pictures.url)
        return None

    picture_image.short_description = '主图'
    picture_image.allow_tags = True

    class Media:
        js = ('https://cdn.jsdelivr.net/npm/lightbox2@2.11.3/dist/js/lightbox.min.js',)
        css = {
            'all': ('https://cdn.jsdelivr.net/npm/lightbox2@2.11.3/dist/css/lightbox.min.css',)
        }

