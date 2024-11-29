from rest_framework.decorators import api_view, renderer_classes
from rest_framework.response import Response
from rest_framework.renderers import JSONRenderer
from django.http import JsonResponse
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .serialization import LoginSerializer

@api_view(['POST'])
@renderer_classes([JSONRenderer])
def login_views(request):
    serializer = LoginSerializer(data=request.data)
    
    if serializer.is_valid():
        email = serializer.validated_data.get('email')
        password = serializer.validated_data.get('password')

        user = authenticate(request, email=email, password=password)

        if user is not None:
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

def test_deployment(request):

    return JsonResponse({'Success': 'Deployment server on point'})