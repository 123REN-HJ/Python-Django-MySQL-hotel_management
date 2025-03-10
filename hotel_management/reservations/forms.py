from django import forms
from .models import Reservation

class BookingForm(forms.Form):
    check_in_date = forms.DateField(label='入住日期', 
                                  widget=forms.DateInput(attrs={'type': 'date'}))
    check_out_date = forms.DateField(label='退房日期', 
                                   widget=forms.DateInput(attrs={'type': 'date'}))
    room = forms.IntegerField(widget=forms.Select(), label='房间')
    customer_name = forms.CharField(max_length=100, label='姓名')
    phone_number = forms.CharField(max_length=20, label='手机号码')
    id_card = forms.CharField(max_length=18, label='身份证号')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        from rooms.models import Room
        # 获取可用房间作为选项
        rooms = Room.objects.filter(status='available')
        room_choices = [(room.id, f"{room.room_number} - {room.get_room_type_display()} (￥{room.price}/晚)") 
                       for room in rooms]
        self.fields['room'].widget = forms.Select(choices=room_choices)

    def clean(self):
        cleaned_data = super().clean()
        check_in_date = cleaned_data.get('check_in_date')
        check_out_date = cleaned_data.get('check_out_date')

        if check_in_date and check_out_date:
            if check_in_date >= check_out_date:
                raise forms.ValidationError('退房日期必须晚于入住日期')

        return cleaned_data 