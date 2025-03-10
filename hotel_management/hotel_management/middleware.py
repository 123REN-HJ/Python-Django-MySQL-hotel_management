from django.utils.deprecation import MiddlewareMixin

class DynamicMenuMiddleware(MiddlewareMixin):
    def process_request(self, request):
        if request.user.is_authenticated and not request.user.is_superuser:
            # 普通顾客菜单配置
            request.simpleui_config = {
                'system_keep': False,
                'menu_display': ['我的预订', '我的账务'],
                'dynamic': True,
                'menus': [
                    {
                        'name': '我的预订',
                        'icon': 'fas fa-calendar-alt',
                        'models': [
                            {
                                'name': '预订列表',
                                'icon': 'fas fa-list',
                                'url': '/reservations/reservation/'
                            }
                        ]
                    },
                    {
                        'name': '我的账务',
                        'icon': 'fas fa-file-invoice-dollar',
                        'models': [
                            {
                                'name': '订单记录',
                                'icon': 'fas fa-receipt',
                                'url': '/finance/orders/'
                            },
                            {
                                'name': '消费明细',
                                'icon': 'fas fa-money-bill-wave',
                                'url': '/finance/expenses/'
                            }
                        ]
                    }
                ]
            } 