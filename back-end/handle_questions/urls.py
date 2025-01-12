from django.urls import path
from . import views

urlpatterns = [
    path('', views.HandleQuestion, name='HandleQuestion'),
    path('BackButtonPressed/', views.BackButtonPressed, name="BackButtonPressed"),
    path('DevPreviousProject/', views.DevPreviousProject, name="DevPreviousProject"),
    path('AddSkillDev/', views.AddSkillDev, name="AddSkillDev")
]