from rest_framework import serializers
from log_in.models import Questionnaire, Questionresponsemapping, User, Previousprojectdev, Developerprofile


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

class PreviousProjectDevSerializer(serializers.ModelSerializer):
    user_id = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    project_name = serializers.CharField(max_length=255)

    class Meta:
        model = Previousprojectdev
        fields = ['id', 'user_id', 'project_name', 'dev_speciality']

    def validate(self, data):
        # Check if the user is a developer
    
        developer = Developerprofile.objects.filter(user=data['user_id']).first()
        if not developer:
            raise serializers.ValidationError("This user is not a developer")

        # Check for duplicate projects
        if Previousprojectdev.objects.filter(project_name=data['project_name'], developer=developer).exists():
            raise serializers.ValidationError("This project already exists for this developer")

        # Replace `user_id` with the actual developer object
        data['developer'] = developer
        data.pop('user_id')  # Remove user_id since it's not a field in the model
       
        return data

    def create(self, validated_data):
        # Create the instance with the mapped developer field
        return Previousprojectdev.objects.create(**validated_data)
    

class DeveloperProfileSerialization(serializers.Serializer):
    user = serializers.IntegerField()  # Expect user as an integer (user ID)
    skills = serializers.JSONField()  # Expect skills as a JSON field (list or dict)

    def validate(self, data):
        # Ensure the user has a developer profile
        developer = Developerprofile.objects.filter(user_id=data['user']).first()
        if not developer:
            raise serializers.ValidationError("This user does not have a developer profile.")
        
        # Add the developer profile to validated data for use in the view
        data['developer'] = developer
        return data
