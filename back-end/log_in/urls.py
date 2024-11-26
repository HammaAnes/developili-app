from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_views, name='login_views'),
    path('add/', views.add, name='add'),
]