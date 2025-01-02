from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from log_in.models import Questionresponsemapping
from .serialization import QuestionResponseMappingSerializer

@api_view(['POST'])
# @permission_classes([IsAuthenticated])  # Enforce authentication
def HandleQuestion(request):
        # Save the answer with the user's client_id
        serializer = QuestionResponseMappingSerializer(data=request.data)
        if serializer.is_valid():
            answer = serializer.save()  # Pass user_id as client_id
            return Response({
                'success': True,
                'message': 'answer saved',
                'answer': {
                    'client_id': answer.client.id,
                    'question_id': answer.question.id,
                    'response': answer.response
                },
            }, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

@api_view(['POST'])
# @permission_classes([IsAuthenticated])
def BackButtonPressed(request):
        # Delete the answer for this client and question
        data = request.data
        Questionresponsemapping.objects.filter(client_id=data['client'], question=data['question']).delete()

        return Response({
            'success': True,
            'message': 'deleted line properly',
        }, status=status.HTTP_200_OK)

