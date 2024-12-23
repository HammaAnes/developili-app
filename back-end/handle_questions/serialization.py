from rest_framework import serializers
from .models import Questionnaire, QuestionResponseMapping, ClientProfile


# Serializer for Questionnaire Model
class QuestionnaireSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questionnaire
        fields = ['id', 'question', 'question_type', 'options']  # Include all relevant fields
        read_only_fields = ['id', 'question', 'question_type', 'options']  # Make fields read-only


# Serializer for QuestionResponseMapping Model
class QuestionResponseMappingSerializer(serializers.ModelSerializer):
    client_id = serializers.PrimaryKeyRelatedField(source='client', queryset=ClientProfile.objects.all())
    question_id = serializers.PrimaryKeyRelatedField(source='question', queryset=Questionnaire.objects.all())
    
    class Meta:
        model = QuestionResponseMapping
        fields = ['id', 'client_id', 'question_id', 'response']  # Include all relevant fields

    def validate(self, data):
        # Check if the client has already answered this question
        if QuestionResponseMapping.objects.filter(client=data['client'], question=data['question']).exists():
            QuestionResponseMapping.objects.filter(client=data['client'], question=data['question']).delete()
            raise serializers.ValidationError("This question has already been answered by the client.")
        return data

