from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from .models import QuestionResponseMapping
from .serialization import QuestionResponseMappingSerializer

@api_view(['POST'])
@permission_classes([IsAuthenticated])  # Enforce authentication
def HandleQuestion(request):
    # Decode the token to extract user information
    jwt_auth = JWTAuthentication()
    try:
        # Decode the token from the Authorization header
        header = jwt_auth.get_header(request)
        if header is None:
            return Response({'error': 'Token not provided'}, status=status.HTTP_401_UNAUTHORIZED)

        raw_token = jwt_auth.get_raw_token(header)
        validated_token = jwt_auth.get_validated_token(raw_token)
        user_id = validated_token.get('user_id')  # Extract user_id from token payload

        # Save the answer with the user's client_id
        serializer = QuestionResponseMappingSerializer(data=request.data)
        if serializer.is_valid():
            answer = serializer.save(client_id=user_id)  # Pass user_id as client_id
            return Response({
                'success': True,
                'message': 'answer saved',
                'answer': {
                    'client_id': user_id,
                    'question_id': answer.question.id,
                    'response': answer.response
                },
            }, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def BackButtonPressed(request):
    # Decode the token to extract user information
    jwt_auth = JWTAuthentication()
    try:
        header = jwt_auth.get_header(request)
        if header is None:
            return Response({'error': 'Token not provided'}, status=status.HTTP_401_UNAUTHORIZED)

        raw_token = jwt_auth.get_raw_token(header)
        validated_token = jwt_auth.get_validated_token(raw_token)
        user_id = validated_token.get('user_id')  # Extract user_id from token payload

        # Delete the answer for this client and question
        data = request.data
        QuestionResponseMapping.objects.filter(client_id=user_id, question=data['question']).delete()

        return Response({
            'success': True,
            'message': 'deleted line properly',
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_401_UNAUTHORIZED)
