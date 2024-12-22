from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from log_in.models import User
from .serialization import UserSerializer


@api_view(['POST'])
def registration_views(request):
    """Register a new user."""
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        return Response({
            'success': True,
            'message': 'User registered successfully.',
            'user': {
                'username': user.username,
                'email': user.email,
                'role': user.role,
            }
        }, status=status.HTTP_201_CREATED)

    return Response({
        'success': False,
        'errors': serializer.errors,
    }, status=status.HTTP_400_BAD_REQUEST)
