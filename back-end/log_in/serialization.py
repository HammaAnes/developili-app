from rest_framework import serializers
from .models import User

class LoginSerializer(serializers.Serializer):  # Note: Not ModelSerializer
    email = serializers.EmailField()  # Validate email format
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        email = data.get('email')
        password = data.get('password')

        if not User.objects.filter(email=email).exists():
            raise serializers.ValidationError({'email': 'No account found with this email.'})
        return data
