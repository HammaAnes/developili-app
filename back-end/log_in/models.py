from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):

    ROLE_CHOICES = [
        ('client', 'Client'),
        ('developer', 'Developer'),
        ('admin', 'Admin'),
    ]

    username = models.CharField(unique=True, max_length=150)
    email = models.CharField(unique=True, max_length=254)
    password = models.CharField(max_length=128)
    first_name = models.CharField(max_length=30, blank=True, null=True)
    last_name = models.CharField(max_length=30, blank=True, null=True)
    role = models.TextField(blank=True, null=True, choices=ROLE_CHOICES)    
    date_joined = models.DateTimeField(blank=True, null=True)
    is_active = models.BooleanField(blank=True, null=True)


    USERNAME_FIELD = 'email'  
    REQUIRED_FIELDS = ['username']

    class Meta:
        managed = False
        db_table = 'User'

class Applicationfeatures(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    feature_type = models.TextField()
    feature_description = models.TextField()
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'applicationfeatures'


class Budgetoverview(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    budget_allocated = models.DecimalField(max_digits=10, decimal_places=2)
    budget_spent = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'budgetoverview'


class Calendar(models.Model):
    developer = models.ForeignKey('Developerprofile', models.DO_NOTHING)
    unavailable_start = models.DateField()
    unavailable_end = models.DateField()

    class Meta:
        managed = False
        db_table = 'calendar'


class Chat(models.Model):
    sender = models.ForeignKey(User, models.DO_NOTHING)
    receiver = models.ForeignKey(User, models.DO_NOTHING, related_name='chat_receiver_set')
    message = models.TextField()
    message_type = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    is_read = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'chat'


class Clientprofile(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    description = models.TextField(blank=True, null=True)
    profile_picture = models.TextField(blank=True, null=True)
    preferences = models.JSONField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'clientprofile'


class Collaborationnotes(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    communication_style = models.TextField()
    preferred_approach = models.TextField(blank=True, null=True)
    recurring_meetings = models.BooleanField(blank=True, null=True)
    additional_notes = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'collaborationnotes'


class Communicationpreferences(models.Model):
    client = models.ForeignKey(Clientprofile, models.DO_NOTHING)
    preferred_method = models.TextField()
    expected_response_time = models.TextField()
    detailed_notes = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'communicationpreferences'


class Developerpreferences(models.Model):
    client = models.ForeignKey(Clientprofile, models.DO_NOTHING)
    preferred_developers = models.JSONField(blank=True, null=True)
    interview_required = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'developerpreferences'


class Developerprofile(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    skills = models.TextField(blank=True, null=True)
    availability = models.TextField(blank=True, null=True)
    rating = models.FloatField(blank=True, null=True)
    profile_picture = models.TextField(blank=True, null=True)
    accomplishments = models.JSONField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'developerprofile'


class Developerrating(models.Model):
    developer = models.ForeignKey(Developerprofile, models.DO_NOTHING)
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    rating = models.FloatField()
    comment = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'developerrating'


class Feedback(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    feedback_text = models.TextField()
    feedback_type = models.TextField()
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'feedback'


class Notifications(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    message = models.TextField()
    is_read = models.BooleanField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'notifications'


class Payments(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    client = models.ForeignKey(Clientprofile, models.DO_NOTHING)
    developer = models.ForeignKey(Developerprofile, models.DO_NOTHING)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.TextField(blank=True, null=True)
    payment_date = models.DateTimeField(blank=True, null=True)
    payment_method = models.TextField()

    class Meta:
        managed = False
        db_table = 'payments'


class Profileprojects(models.Model):
    developer = models.ForeignKey(Developerprofile, models.DO_NOTHING)
    project_name = models.TextField()
    specialization = models.TextField()
    technologies = models.JSONField(blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'profileprojects'


class Projectbudget(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    budget_range = models.TextField()
    budget_value = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'projectbudget'


class Projectdesign(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    color_palette = models.JSONField(blank=True, null=True)
    layout_preferences = models.TextField(blank=True, null=True)
    additional_notes = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'projectdesign'


class Projectobjectives(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    objective_type = models.TextField()
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'projectobjectives'


class Projectreferences(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    reference_link = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'projectreferences'


class Projects(models.Model):
    client = models.ForeignKey(Clientprofile, models.DO_NOTHING)
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    status = models.TextField(blank=True, null=True)
    technologies = models.JSONField(blank=True, null=True)
    team_members = models.JSONField(blank=True, null=True)
    duration = models.TextField(blank=True, null=True)
    users = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'projects'


class Questionnaire(models.Model):
    question = models.TextField()
    question_type = models.TextField(blank=True, null=True)
    options = models.JSONField(blank=True, null=True)
    step = models.IntegerField()
    category = models.TextField(blank=True, null=True)
    allow_other = models.BooleanField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'questionnaire'


class Questionresponsemapping(models.Model):
    client = models.ForeignKey(Clientprofile, models.DO_NOTHING)
    question = models.ForeignKey(Questionnaire, models.DO_NOTHING)
    response = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    other_response = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'questionresponsemapping'


class Quickactions(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    action_type = models.TextField()
    action_name = models.TextField()
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'quickactions'


class Rechargecodes(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    code = models.TextField()
    status = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    used_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rechargecodes'


class Registrationdetails(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    developer = models.BooleanField(blank=True, null=True)
    registration_source = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'registrationdetails'


class Sidebarpreferences(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    active_tab = models.TextField(blank=True, null=True)
    customization = models.JSONField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'sidebarpreferences'


class Transactions(models.Model):
    wallet = models.ForeignKey('Wallet', models.DO_NOTHING)
    transaction_type = models.TextField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField(blank=True, null=True)
    transaction_date = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'transactions'


class Wallet(models.Model):
    user = models.ForeignKey(User, models.DO_NOTHING)
    balance = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    last_recharge = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'wallet'