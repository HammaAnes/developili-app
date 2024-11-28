from django.urls import path
from . import views

urlpatterns = [
<<<<<<< HEAD
    path('log_in/', views.log_in, name='log_in'),
=======
    path('', views.login_views, name='login_views'),
    path('add/', views.add, name='add'),
>>>>>>> main
]