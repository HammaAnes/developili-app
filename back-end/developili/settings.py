import os
from pathlib import Path
from datetime import timedelta

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
SECRET_KEY = "django-insecure-=momx#9gkva^a8q4q+ucn-fdr%mz=1!3$_*s-o^m_8&hl2l6vf"

DEBUG = True  # Keep True in development; Set to False in production

ALLOWED_HOSTS = ['*']  # Allow all hosts for development

# Port handling
PORT = os.environ.get('PORT', '8000')

# Installed apps
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
    "allauth",
    "allauth.account",
    "allauth.socialaccount",
    "corsheaders",
]

# Custom user model
AUTH_USER_MODEL = 'log_in.User'

# django-allauth configurations
SITE_ID = 1
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_USERNAME_REQUIRED = False
ACCOUNT_AUTHENTICATION_METHOD = "email"
ACCOUNT_EMAIL_VERIFICATION = "optional"
LOGIN_REDIRECT_URL = "/"

# Middleware
MIDDLEWARE = [
    "corsheaders.middleware.CorsMiddleware",  # Ensure this is at the top
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
    "allauth.account.middleware.AccountMiddleware", 
    
]

# URL configuration
ROOT_URLCONF = "developili.urls"

# Templates
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

# Database
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
        "OPTIONS": {
            'timeout': 30,
        }
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {"NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"},
    {"NAME": "django.contrib.auth.password_validation.MinimumLengthValidator"},
    {"NAME": "django.contrib.auth.password_validation.CommonPasswordValidator"},
    {"NAME": "django.contrib.auth.password_validation.NumericPasswordValidator"},
]

# Internationalization
LANGUAGE_CODE = "en-us"
TIME_ZONE = "UTC"
USE_I18N = True
USE_TZ = True

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"

# Static files (CSS, JavaScript, images)
STATIC_URL = "static/"

# Media files
MEDIA_URL = '/media/'

# CORS settings (for APIs)
CORS_ALLOW_ALL_ORIGINS = True  # For development; restrict in production
CORS_ALLOW_CREDENTIALS = True  # Allow cookies and authentication tokens
CORS_ALLOW_HEADERS = [
    "Content-Type",
    "Authorization",
    "X-CSRFToken",
]

# REST Framework Configuration
# REST_FRAMEWORK = {
#     "DEFAULT_AUTHENTICATION_CLASSES": (
#         "rest_framework_simplejwt.authentication.JWTAuthentication",  # Use JWT for authentication
#         "rest_framework.authentication.SessionAuthentication",  # Optional
#     ),
#     "DEFAULT_PERMISSION_CLASSES": (
#         "rest_framework.permissions.IsAuthenticated",  # Default: restrict access
#     ),
# }

# # Simple JWT Configuration
# SIMPLE_JWT = {
#     "ACCESS_TOKEN_LIFETIME": timedelta(minutes=60),  # Token expires after 1 hour
#     "REFRESH_TOKEN_LIFETIME": timedelta(days=7),  # Refresh token expires after 7 days
#     "ROTATE_REFRESH_TOKENS": True,  # Generate a new refresh token on use
#     "BLACKLIST_AFTER_ROTATION": True,  # Blacklist old refresh tokens
#     "AUTH_HEADER_TYPES": ("Bearer",),  # Authorization: Bearer <token>
#     "ALGORITHM": "HS256",
#     "SIGNING_KEY": SECRET_KEY,  # Use the same key as Django
#     "VERIFYING_KEY": None,
#     "AUDIENCE": None,
#     "ISSUER": None,
#     "USER_ID_FIELD": "id",
#     "USER_ID_CLAIM": "user_id",
#     "AUTH_TOKEN_CLASSES": ("rest_framework_simplejwt.tokens.AccessToken",),
#     "TOKEN_TYPE_CLAIM": "token_type",
# }


# CSRF settings
CSRF_TRUSTED_ORIGINS = [
    "http://127.0.0.1:65071",
    "http://localhost:65071",
]
CSRF_COOKIE_HTTPONLY = False  # Allow access to CSRF cookies via JavaScript in development

# Security settings (change in production)
SECURE_SSL_REDIRECT = False
CSRF_COOKIE_SECURE = False
SESSION_COOKIE_SECURE = False
