from django import forms
from .models import OrderReview

class OrderReviewForm(forms.ModelForm):
    class Meta:
        model = OrderReview
        fields = ['rating', 'comment']
        widgets = {
            'rating': forms.Select(
                attrs={
                    'class': 'form-select',
                    'aria-label': '请选择评分'
                }
            ),
            'comment': forms.Textarea(
                attrs={
                    'class': 'form-control',
                    'rows': 4,
                    'placeholder': '请分享您的入住体验...'
                }
            ),
        }
        labels = {
            'rating': '评分',
            'comment': '评价内容',
        }
        help_texts = {
            'rating': '请为本次入住体验打分',
            'comment': '请详细描述您的入住体验，您的反馈对我们很重要',
        } 