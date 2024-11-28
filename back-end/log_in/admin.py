from django.contrib import admin
<<<<<<< HEAD

# Register your models here.
=======
from .models import User, ClientProfile, DeveloperProfile

# Register your models here.
admin.site.register(User)
admin.site.register(ClientProfile)
admin.site.register(DeveloperProfile)
>>>>>>> main
