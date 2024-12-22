from django.db import models
from django.contrib.auth.models import AbstractUser


# User Model (Extending AbstractUser for authentication)
class User(AbstractUser):
    ROLES = [
        ('client', 'Client'),
        ('developer', 'Developer'),
    ]
    role = models.CharField(max_length=10, choices=ROLES, default='client')


# Client Profile Model
class ClientProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='client_profile')
    description = models.TextField(null=True, blank=True)


# Developer Profile Model
class DeveloperProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='developer_profile')
    skills = models.TextField(null=True, blank=True)
    availability = models.TextField(null=True, blank=True)
    rating = models.FloatField(default=0, validators=[models.Min(0), models.Max(5)])


# Questionnaire Model
class Questionnaire(models.Model):
    QUESTION_TYPES = [
        ('multiple_choice', 'Multiple Choice'),
        ('text', 'Text'),
        ('rating', 'Rating'),
        ('boolean', 'Boolean'),
    ]
    question = models.TextField()
    question_type = models.CharField(max_length=20, choices=QUESTION_TYPES, default='text')
    options = models.JSONField(null=True, blank=True)  # Store multiple-choice options as JSON

    def __str__(self):
        return self.question


# Question Response Mapping Model
class QuestionResponseMapping(models.Model):
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='responses')
    question = models.ForeignKey(Questionnaire, on_delete=models.CASCADE, related_name='responses')
    response = models.TextField()

    def __str__(self):
        return f"Response from {self.client.user.username} to {self.question}"


# Project Model
class Project(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='projects')
    title = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


# Preferences Model
class ProjectPreferences(models.Model):
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='preferences')
    preference_category = models.CharField(max_length=50)
    preference_value = models.TextField()

    def __str__(self):
        return f"Preference for {self.client.user.username}"


# Proposals Model
class Proposal(models.Model):
    developer = models.ForeignKey(DeveloperProfile, on_delete=models.CASCADE, related_name='proposals')
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='proposals')
    proposal_text = models.TextField()
    proposed_price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=[
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('rejected', 'Rejected'),
    ], default='pending')
    created_at = models.DateTimeField(auto_now_add=True)


# Contract Model
class Contract(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='contracts')
    developer = models.ForeignKey(DeveloperProfile, on_delete=models.CASCADE, related_name='contracts')
    final_price = models.DecimalField(max_digits=10, decimal_places=2)
    deadline = models.DateField()
    deliverables = models.JSONField()  # E.g., ["application", "source_code"]
    maintenance_option = models.CharField(max_length=20, choices=[
        ('none', 'None'),
        ('occasional', 'Occasional'),
        ('continuous', 'Continuous'),
    ])
    created_at = models.DateTimeField(auto_now_add=True)


# Message Model
class Message(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)


# Review Model
class Review(models.Model):
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='given_reviews')
    reviewed_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_reviews')
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='reviews')
    rating = models.FloatField(validators=[models.Min(1), models.Max(5)])
    comment = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)


# Notification Model
class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)


# Calendar Model (Developer Availability)
class Calendar(models.Model):
    developer = models.ForeignKey(DeveloperProfile, on_delete=models.CASCADE, related_name='calendar')
    unavailable_start = models.DateField()
    unavailable_end = models.DateField()


# Project Requirements Model
class ProjectRequirements(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='requirements')
    requirement = models.TextField()


# Communication Preferences (optional)
class CommunicationPreferences(models.Model):
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='communication_preferences')
    preferred_method = models.CharField(max_length=20, choices=[
        ('email', 'Email'),
        ('phone_calls', 'Phone Calls'),
        ('video_meetings', 'Video Meetings'),
        ('messaging_apps', 'Messaging Apps'),
    ])
    expected_response_time = models.CharField(max_length=20, choices=[
        ('few_hours', 'Few Hours'),
        ('end_of_day', 'End of Business Day'),
        ('24_48_hours', '24-48 Hours'),
        ('flexible', 'Flexible'),
    ])
