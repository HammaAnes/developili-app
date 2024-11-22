from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import MinValueValidator, MaxValueValidator

# Custom User Model
class User(AbstractUser):
    ROLE_CHOICES = [
        ('client', 'Client'),
        ('developer', 'Developer'),
    ]
    role = models.CharField(
        max_length=20,
        choices=ROLE_CHOICES,
        blank=True,  # Allow blank initially
    )
    email = models.EmailField(unique=True)

    USERNAME_FIELD = 'email'  # Use email for authentication
    REQUIRED_FIELDS = ['username']  # Ensure username remains required

    def __str__(self):
        return self.username


# Client Profile Model
class ClientProfile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='client_profile'
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
        related_name='developer_profile'
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
