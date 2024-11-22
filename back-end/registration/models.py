from django.db import models
from log_in.models import User  # Reference the consolidated User model
from django.core.validators import MinValueValidator, MaxValueValidator

# Client Profile Model
class ClientProfile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='register_client_profile'
    )
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Client: {self.user.username}"

    class Meta:
        verbose_name = "Client Profile"
        verbose_name_plural = "Client Profiles"


# Developer Profile Model
class DeveloperProfile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='register_developer_profile'
    )
    skills = models.TextField(blank=True, null=True)
    availability = models.TextField(blank=True, null=True)
    rating = models.FloatField(
        default=0,
        validators=[
            MinValueValidator(0),
            MaxValueValidator(5),
        ]
    )

    def __str__(self):
        return f"Developer: {self.user.username}"

    class Meta:
        verbose_name = "Developer Profile"
        verbose_name_plural = "Developer Profiles"
