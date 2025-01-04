from rest_framework import serializers
from log_in.models import User

class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()  # Validate email format
    password = serializers.CharField(write_only=True)
    
    def validate(self, data):
        email = data.get('email')
        password = data.get('password')

        try:
            # Check if the user exists with the given email
            user = User.objects.get(email=email)
            
            # Use check_password to verify the password
            if not user.check_password(password):
                raise serializers.ValidationError({'password': 'Incorrect password.'})
            
        except User.DoesNotExist:
            raise serializers.ValidationError({'email': 'No account found with this email.'})
        
        # Optionally, you can attach the user instance to validated data
        data['user'] = user
        return data
