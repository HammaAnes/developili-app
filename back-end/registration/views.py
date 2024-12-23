from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .serialization import UserSerializer, ClientProfileSerializer, DeveloperProfileSerializer


@api_view(['POST'])
def registration_views(request):
    """Register a new user."""
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        if user.role == 'client' :
            serializerClient = ClientProfileSerializer(data={'user': user.id})
            if serializerClient.is_valid():
                serializerClient.save()
            else:
                print(serializerClient.errors) 
            
        else:
            serializerDev = DeveloperProfileSerializer(data={'user': user.id})            
            if serializerDev.is_valid():
                serializerDev.save()
            else:
                print(serializerDev.errors) 
            
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
