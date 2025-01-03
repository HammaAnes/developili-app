from rest_framework import serializers
from log_in.models import Questionnaire, Questionresponsemapping, User


# Serializer for Questionnaire Model
class QuestionnaireSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questionnaire
        fields = ['id', 'question', 'question_type', 'options', 'allow_other']  # Include 'allow_other' field
        read_only_fields = ['id', 'question', 'question_type', 'options', 'allow_other']


# Serializer for QuestionResponseMapping Model
class QuestionResponseMappingSerializer(serializers.ModelSerializer):
    user_id = serializers.PrimaryKeyRelatedField(source='user', queryset=User.objects.all())
    question_id = serializers.PrimaryKeyRelatedField(source='question', queryset=Questionnaire.objects.all())
    other_response = serializers.CharField(required=False, allow_blank=True)  # New field for 'Other' option input

    class Meta:
        model = Questionresponsemapping
        fields = ['id', 'user_id', 'question_id', 'response','created_at', 'other_response']  # Include 'other_response' field

    def validate(self, data):
        # Check if the client has already answered this question
        if Questionresponsemapping.objects.filter(user=data['user'], question=data['question']).exists():
            raise serializers.ValidationError("This question has already been answered by the client.")
        
        question = data['question']
        
        # Handle the 'Other' option for multiple_choice questions
        if question.question_type == 'multiple_choice' and question.allow_other:
            if data['response'] == 'Other' and not data.get('other_response'):
                raise serializers.ValidationError("Please provide a response for 'Other'.")
            
            # If 'Other' is selected, set the response to the custom input (from 'other_response')
            if data['response'] == 'Other' and 'other_response' in data:
                data['response'] = data['other_response']
        
        return data
