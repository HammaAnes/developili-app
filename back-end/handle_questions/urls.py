from django.urls import path
from . import views

urlpatterns = [
    path('', views.HandleQuestion, name='HandleQuestion'),
    path('add/', views.add, name="add"),
]