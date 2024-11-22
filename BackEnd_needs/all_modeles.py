from django.db import models
from django.contrib.auth.models import AbstractUser

# Custom User Model
class User(AbstractUser):
    ROLE_CHOICES = [
        ('client', 'Client'),
        ('developer', 'Developer'),
    ]
    role = models.CharField(max_length=20, choices=ROLE_CHOICES)
    email = models.EmailField(unique=True)

    def __str__(self):
        return self.username

# Client Profile Model
class ClientProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, related_name='client_profile')
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.user.username

# Developer Profile Model
class DeveloperProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, related_name='developer_profile')
    skills = models.TextField(blank=True, null=True)
    availability = models.TextField(blank=True, null=True)
    rating = models.FloatField(default=0, validators=[models.Min(0), models.Max(5)])

    def __str__(self):
        return self.user.username

# Project Model
class Project(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]
    client = models.ForeignKey(User, on_delete=models.CASCADE, related_name='projects')
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

# Questionnaire Model
class Questionnaire(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='questionnaires')
    question = models.CharField(max_length=255)
    answer = models.TextField()

    def __str__(self):
        return self.question

# Proposal Model
class Proposal(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('rejected', 'Rejected'),
    ]
    developer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='proposals')
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='proposals')
    proposal_text = models.TextField()
    proposed_price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Proposal by {self.developer.username} for {self.project.title}"

# Contract Model
class Contract(models.Model):
    DELIVERABLE_CHOICES = [
        ('application', 'Application'),
        ('source_code', 'Source Code'),
        ('admin_rights', 'Admin Rights'),
    ]
    MAINTENANCE_CHOICES = [
        ('none', 'None'),
        ('occasional', 'Occasional'),
        ('continuous', 'Continuous'),
    ]
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='contracts')
    developer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='contracts')
    final_price = models.DecimalField(max_digits=10, decimal_places=2)
    deadline = models.DateField()
    deliverables = models.CharField(max_length=20, choices=DELIVERABLE_CHOICES)
    maintenance_option = models.CharField(max_length=20, choices=MAINTENANCE_CHOICES)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Contract for {self.project.title}"

# Message Model
class Message(models.Model):
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Message from {self.sender.username} to {self.receiver.username}"

# Review Model
class Review(models.Model):
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reviews_given')
    reviewed_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reviews_received')
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='reviews')
    rating = models.FloatField(validators=[models.Min(1), models.Max(5)])
    comment = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Review for {self.reviewed_user.username} by {self.reviewer.username}"

# Notification Model
class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notification for {self.user.username}"

# Calendar Model
class Calendar(models.Model):
    developer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='calendar')
    unavailable_start = models.DateField()
    unavailable_end = models.DateField()

    def __str__(self):
        return f"Calendar of {self.developer.username}"

# Project Requirements Model
class ProjectRequirement(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='requirements')
    requirement = models.TextField()

    def __str__(self):
        return self.requirement

# Project Preferences Model
class ProjectPreference(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='preferences')
    preference = models.TextField()

    def __str__(self):
        return self.preference
