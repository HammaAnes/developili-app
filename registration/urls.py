from django.urls import path
from . import views

urlpatterns = [
    path('', views.registration_views, name='registration_views'),
]