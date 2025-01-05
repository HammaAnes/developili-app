from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from log_in.models import Questionresponsemapping, Developerprofile
from .serialization import QuestionResponseMappingSerializer, PreviousProjectDevSerializer, DeveloperProfileSerialization

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
                    'user_id': answer.user.id,
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
        Questionresponsemapping.objects.filter(user_id=data['user'], question=data['question']).delete()

        return Response({
            'success': True,
            'message': 'deleted line properly',
        }, status=status.HTTP_200_OK)


@api_view(['POST'])
def DevPreviousProject(request):
    serializer = PreviousProjectDevSerializer(data=request.data)

    if serializer.is_valid():
        
        answer = serializer.save()
        return Response({
            'success': True,
            'message': 'Answer saved',
            'answer': {
                'dev_id': answer.developer_id,
                'project_name': answer.project_name,
            },
        }, status=status.HTTP_201_CREATED)

    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def AddSkillDev(request):
    serializer = DeveloperProfileSerialization(data=request.data)

    if serializer.is_valid():
        # Get the developer profile
        dev = serializer.validated_data['developer']
        
        # Update the developer profile with the new skills
        dev.skills = serializer.validated_data['skills']
        dev.save()

        return Response({
            'success': True,
            'message': 'Skills updated successfully',
            'developer': {
                'id': dev.id,
                'skills': dev.skills,
            },
        }, status=status.HTTP_201_CREATED)

    # Return validation errors
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

