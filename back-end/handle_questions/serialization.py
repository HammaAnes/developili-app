from rest_framework import serializers
from .models import Questionnaire, QuestionResponseMapping, ClientProfile


# Serializer for Questionnaire Model
class QuestionnaireSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questionnaire
        fields = ['id', 'question', 'question_type', 'options', 'allow_other']  # Include 'allow_other' field
        read_only_fields = ['id', 'question', 'question_type', 'options', 'allow_other']


# Serializer for QuestionResponseMapping Model
class QuestionResponseMappingSerializer(serializers.ModelSerializer):
    client_id = serializers.PrimaryKeyRelatedField(source='client', queryset=ClientProfile.objects.all())
    question_id = serializers.PrimaryKeyRelatedField(source='question', queryset=Questionnaire.objects.all())
    other_response = serializers.CharField(required=False, allow_blank=True)  # New field for 'Other' option input

    class Meta:
        model = QuestionResponseMapping
        fields = ['id', 'client_id', 'question_id', 'response', 'other_response']  # Include 'other_response' field

    def validate(self, data):
        # Check if the client has already answered this question
        if QuestionResponseMapping.objects.filter(client=data['client'], question=data['question']).exists():
            QuestionResponseMapping.objects.filter(client=data['client'], question=data['question']).delete()
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
