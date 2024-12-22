from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from .models import Questionnaire, QuestionResponseMapping
from .serialization import QuestionnaireSerializer, QuestionResponseMappingSerializer

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def HandleQuestion(request):
    serializer = QuestionResponseMappingSerializer(data=request.data)

    if serializer.is_valid():
        answer = serializer.save()
        return Response({
            'success': True,
            'message': 'answer saved',
            'answer': {
                'client_id': answer.client.id,
                'question_id': answer.question.id,
                'response': answer.response
            },
        }, status=status.HTTP_201_CREATED)
    
    else:
        print(serializer.errors)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

