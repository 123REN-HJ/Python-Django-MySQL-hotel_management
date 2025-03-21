"""
Django settings for hotel_management project.

Generated by 'django-admin startproject' using Django 4.2.17.

For more information on this file, see
https://docs.djangoproject.com/en/4.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/4.2/ref/settings/
"""
import os
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-%dhmv-tm%^_prz&mwv+3ge^v-uj4zcr5c9f86at5xkkf7i^uk9"

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    'simpleui',  # 将simpleui加入到INSTALLED_APPS里去，放在第一行
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",

    "rooms",
    "customers",
    "reservations",
    "finance",
    "employees",
    'analytics',  # 添加新的analytics应用
    'widget_tweaks',
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    'hotel_management.middleware.DynamicMenuMiddleware',
]

ROOT_URLCONF = "hotel_management.urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [os.path.join(BASE_DIR, 'templates')],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "hotel_management.wsgi.application"


# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

# DATABASES = {
#     "default": {
#         "ENGINE": "django.db.backends.sqlite3",
#         "NAME": BASE_DIR / "db.sqlite3",
#     }
# }
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'hotel_management',
        'USER': 'root',
        'PASSWORD': '123456',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

# 支持的语言列表
LANGUAGE_CODE = 'zh-hans'  # 设置语言为简体中文 [^54^]
TIME_ZONE = 'Asia/Shanghai'  # 设置时区为上海 [^54^]

# 启用国际化
USE_I18N = True
USE_L10N = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

# 静态文件配置
STATIC_URL = '/static/'
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"


# 去掉默认Logo或换成自己Logo链接
SIMPLEUI_LOGO = '/static/img/logo.png'

# 隐藏右侧SimpleUI广告链接和使用分析
SIMPLEUI_HOME_INFO = False
SIMPLEUI_ANALYSIS = False

# 设置默认主题，指向主题css文件名。你可以选择以下主题之一：
# 'admin.lte.css'  # Admin Lte风格
# 'element.css'    # Element-ui风格
# 'layui.css'      # layui风格
# 'purple.css'     # 紫色风格
SIMPLEUI_DEFAULT_THEME = 'admin.lte.css'

# 隐藏首页的快捷操作和最近动作
SIMPLEUI_HOME = True  # 隐藏默认的首页菜单
SIMPLEUI_HOME_QUICK = True
SIMPLEUI_HOME_ACTION = True

# SimpleUI菜单配置
SIMPLEUI_CONFIG = {
    'system_keep': False,
    'menu_display': ['酒店管理', '财务管理', '员工管理', '数据分析', '系统管理'],
    'dynamic': True,
    'menus': [
        {
            'app': 'rooms',
            'name': '酒店管理',
            'icon': 'fas fa-hotel',
            'models': [
                {
                    'name': '房间管理',
                    'icon': 'fas fa-bed',
                    'url': 'rooms/room/',
                    'permission': 'rooms.view_room'
                },
                {
                    'name': '顾客管理',
                    'icon': 'fas fa-users',
                    'url': 'customers/customer/',
                    'permission': 'customers.view_customer'
                },
                {
                    'name': '预定管理',
                    'icon': 'fas fa-calendar-check',
                    'url': 'reservations/reservation/',
                    'permission': 'reservations.view_reservation'
                }
            ]
        },
        {
            'app': 'finance',
            'name': '财务管理',
            'icon': 'fas fa-money-bill-alt',
            'models': [
                {
                    'name': '收入管理',
                    'icon': 'fas fa-donate',
                    'url': 'finance/income/',
                    'permission': 'finance.view_income'
                },
                {
                    'name': '支出管理',
                    'icon': 'fas fa-funnel-dollar',
                    'url': 'finance/expense/',
                    'permission': 'finance.view_expense'
                },
                {
                    'name': '订单管理',
                    'icon': 'fas fa-clipboard-list',
                    'url': 'finance/completed-orders/',
                    'blank': True
                },
            ]
        },
        {
            'app': 'employees',
            'name': '员工管理',
            'icon': 'fas fa-user-tie',
            'permission': 'employees.view_employee',
            'models': [
                {
                    'name': '员工管理',
                    'icon': 'fas fa-users-cog',
                    'url': 'employees/employee/',
                    'permission': 'employees.view_employee'
                }
            ]
        },
        {
            'app': 'analytics',
            'name': '数据分析',
            'icon': 'fas fa-chart-line',
            'permission': 'analytics.view_dashboardmetric',
            'models': [
                {
                    'name': '运营概览',
                    'icon': 'fas fa-tachometer-alt',
                    'url': '/analytics/dashboard/',
                    'permission': 'analytics.view_dashboardmetric'
                },
                {
                    'name': '满意度分析',
                    'icon': 'fas fa-chart-pie',
                    'url': 'finance/satisfaction-analysis/',
                    'blank': True
                },
            ]
        },
        {
            'app': 'auth',
            'name': '系统管理',
            'icon': 'fas fa-cogs',
            'permission': 'auth.view_user',
            'models': [
                {
                    'name': '管理员管理',
                    'icon': 'fas fa-user-shield',
                    'url': 'auth/user/',
                    'permission': 'auth.view_user'
                },
                {
                    'name': '分组管理',
                    'icon': 'fas fa-users-cog',
                    'url': 'auth/group/',
                    'permission': 'auth.view_group'
                }
            ]
        }
    ]
}

LOGIN_URL = 'admin_login'
LOGIN_REDIRECT_URL = 'admin:index'

# 添加自定义配置
SIMPLEUI_CUSTOMER_MENU_KEY = 'customer_menu'
