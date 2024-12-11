import os
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-=momx#9gkva^a8q4q+ucn-fdr%mz=1!3$_*s-o^m_8&hl2l6vf"

DEBUG = True  # Set to False in production

ALLOWED_HOSTS = ['*']

# Port handling (handled by gunicorn)
PORT = os.environ.get('PORT', '8000')

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "log_in.apps.LogInConfig",
    "registration.apps.RegistrationConfig",
    "handle_questions.apps.HandleQuestionsConfig",
    "rest_framework",
    "rest_framework.authtoken",
    "allauth",  # Adding allauth to installed apps
    "allauth.account",  # Adding allauth account app
    "allauth.socialaccount",  # Adding allauth social account app
    "corsheaders",
    # Add social providers if needed, e.g., 'allauth.socialaccount.providers.google',
]

# Configure authentication backends
AUTHENTICATION_BACKENDS = [
    "django.contrib.auth.backends.ModelBackend",  # Default authentication backend
    "allauth.account.auth_backends.AuthenticationBackend",  # allauth authentication backend
]

# Define the custom user model
AUTH_USER_MODEL = 'log_in.User'

# Configure django-allauth
SITE_ID = 1  # Add this setting, it's required by allauth
ACCOUNT_EMAIL_REQUIRED = True  # Require email for authentication
ACCOUNT_USERNAME_REQUIRED = False  # Don't require username
ACCOUNT_AUTHENTICATION_METHOD = "email"  # Authenticate using email
ACCOUNT_EMAIL_VERIFICATION = "optional"  # Optional email verification
ACCOUNT_SIGNUP_EMAIL_ENTERED = True  # If you want to allow users to directly sign up with an email
ACCOUNT_CONFIRM_EMAIL_ON_GET = True  # Confirm the email when it's visited
LOGIN_REDIRECT_URL = '/'  # Redirect URL after login

# Middleware configuration
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "allauth.account.middleware.AccountMiddleware",
    "corsheaders.middleware.CorsMiddleware",
]

# URL configuration
ROOT_URLCONF = "developili.urls"

# Templates configuration
TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

WSGI_APPLICATION = "developili.wsgi.application"

# Database configuration
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",  # Default database engine
        "NAME": BASE_DIR / "db.sqlite3",  # Database location
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# Internationalization settings
LANGUAGE_CODE = "en-us"
TIME_ZONE = "UTC"
USE_I18N = True
USE_TZ = True

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# Static files (CSS, JavaScript, images)
STATIC_URL = "static/"

# Media files
MEDIA_URL = '/media/'  # Add if you are using media files (like profile pictures)

# CORS settings (if you're using APIs across domains)   
CORS_ALLOW_ALL_ORIGINS = True  # You can configure this to allow specific domains

# Add Django Allauth-related settings
SOCIALACCOUNT_EMAIL_VERIFICATION = "mandatory"
SOCIALACCOUNT_EMAIL_REQUIRED = True

# Security settings (change these for production)
SECURE_SSL_REDIRECT = False  # Set to True in production if using HTTPS
CSRF_COOKIE_SECURE = False  # Set to True in production for security
SESSION_COOKIE_SECURE = False  # Set to True in production for security
