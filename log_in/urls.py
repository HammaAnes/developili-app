from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_views, name='login_views'),
    path('social_login/', views.social_login, name='social_login'),
    
]