from rest_framework import serializers
from log_in.models import User
from log_in.models import Clientprofile, Developerprofile

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)  # Ensure password is not exposed
    role = serializers.ChoiceField(choices=User.ROLE_CHOICES)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'role']

    def validate_email(self, value):
        """Ensure email is unique."""
        if User.objects.filter(email=value).exists():
            raise serializers.ValidationError("A user with this email already exists.")
        return value

    def create(self, validated_data):
        """Override to hash the password."""
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.set_password(password)  # Hash the password
        user.save()
        return user
    
class ClientProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clientprofile
        fields = ['user', 'description']


class DeveloperProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Developerprofile
        fields = ['user', 'skills', 'availability', 'rating']