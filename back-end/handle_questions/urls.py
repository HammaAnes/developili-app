from django.urls import path
from . import views

urlpatterns = [
    path('', views.HandleQuestion, name='HandleQuestion'),
    path('BackButtonPressed/', views.BackButtonPressed, name="BackButtonPressed"),
]