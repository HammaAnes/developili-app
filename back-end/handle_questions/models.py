from log_in.models import ClientProfile
from django.db import models
        
# Questionnaire Model
class Questionnaire(models.Model):
    QUESTION_TYPES = [
        ('multiple_choice', 'Multiple Choice'),
        ('text', 'Text'),
        ('rating', 'Rating'),
        ('boolean', 'Boolean'),
        ('color_picker', 'Color_picker'),
        ('layout_selector', 'Layout_selector')
    ]
    question = models.TextField()
    question_type = models.CharField(max_length=20, choices=QUESTION_TYPES, default='text')
    options = models.JSONField(null=True, blank=True)  # Store multiple-choice options as JSON
    allow_other = models.BooleanField(default=False)  # New field to indicate if 'Other' option is allowed

    def __str__(self):
        return self.question


# Question Response Mapping Model
class QuestionResponseMapping(models.Model):
    client = models.ForeignKey(ClientProfile, on_delete=models.CASCADE, related_name='responses')
    question = models.ForeignKey(Questionnaire, on_delete=models.CASCADE, related_name='responses')
    response = models.TextField()  # To store the selected option or other response
    other_response = models.TextField(null=True, blank=True)  # To store the custom text if 'Other' is selected

    def __str__(self):
        return f"Response from {self.client.user.username} to {self.question}"
