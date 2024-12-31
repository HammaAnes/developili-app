from rest_framework.decorators import api_view, renderer_classes
from rest_framework.response import Response
from rest_framework.renderers import JSONRenderer
from rest_framework import status
from django.contrib.auth import authenticate
from django.http import JsonResponse
from allauth.socialaccount.models import SocialAccount
from rest_framework.authtoken.models import Token
from .serialization import LoginSerializer
from .models import User
import requests


@api_view(['POST'])
@renderer_classes([JSONRenderer])
def login_views(request):
    serializer = LoginSerializer(data=request.data)
    
    if serializer.is_valid():
        email = serializer.validated_data.get('email')
        password = serializer.validated_data.get('password')

        user = authenticate(request, email=email, password=password)

        if user is not None and user.is_active:
            # Create or get the token for the user
            token, _ = Token.objects.get_or_create(user=user)

            return Response({
                'success': 'Successfully logged in',
                'token': token.key,  # Return token to Flutter
                'user': {
                    'username': user.username,
                    'email': user.email,
                    'role': user.role,
                }
            }, status=status.HTTP_202_ACCEPTED)
    
       
        return Response({'error': 'Invalid credentials'}, status=status.HTTP_400_BAD_REQUEST)
    else:
        print(serializer.errors)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def social_login(request):
    provider = request.data.get('provider')  # "google" or "apple"
    access_token = request.data.get('access_token')

    if provider not in ["google", "apple"]:
        return Response({'error': 'Invalid provider'}, status=status.HTTP_400_BAD_REQUEST)

    # Validate token with the provider
    user_data = validate_social_token(provider, access_token)
    if not user_data:
        return Response({'error': 'Invalid token'}, status=status.HTTP_400_BAD_REQUEST)

    # Check if the user already exists
    try:
        social_account = SocialAccount.objects.get(uid=user_data['id'], provider=provider)
        user = social_account.user
    except SocialAccount.DoesNotExist:
        # Create a new user
        user = User.objects.create_user(
            username=user_data['name'],
            email=user_data['email']
        )
        # Link the user to the social account
        SocialAccount.objects.create(user=user, uid=user_data['id'], provider=provider)

    # Generate token for the user
    token, _ = Token.objects.get_or_create(user=user)
    return Response({'token': token.key, 'user': {'email': user.email}}, status=status.HTTP_200_OK)

def validate_social_token(provider, token):
    try:
        if provider == "google":
            url = f"https://www.googleapis.com/oauth2/v3/tokeninfo?id_token={token}"
            response = requests.get(url)
            if response.status_code == 200:
                return response.json()
        elif provider == "apple":
            # Simplified Apple validation placeholder
            return {"id": "apple_user_id", "email": "apple_user_email@example.com"}
    except requests.RequestException:
        return None  # Handle token validation errors gracefully

    return None



def add(request):
    user = User.objects.create(
        email="a@gmail.com",
        username="TryLogIn"
    )
    user.set_password("12345678")
    user.save()

    return JsonResponse({'message': 'Developer user created successfully!'}, status=201)


