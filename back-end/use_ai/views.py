from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from use_ai.ai_model.mymodel import find_top_developers, extract_features_from_text, map_experience_level
from log_in.models import Questionresponsemapping
import logging

import logging

@api_view(['POST'])
def topDeveloper(request):
    try:
        # Parse input data
        data = request.data
        user_id = data.get('user_id')
        
        # Fetch responses
        experience_response = Questionresponsemapping.objects.filter(
            user_id=user_id, question_id=12
        ).first()
        language_response = Questionresponsemapping.objects.filter(
            user_id=user_id, question_id=11
        ).first()

        # Validate inputs
        if not experience_response or not language_response:
            return Response(
                {"success": False, "error": "Both 'experience_level' and 'languages' are required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Extract response fields
        experience_level = experience_response.response  # Replace 'response' with actual field name
        languages = language_response.response  # Replace 'response' with actual field name
        preferred_range = Questionresponsemapping.objects.filter(question_id=23).all()
        # Debug log: Check values
        import logging

# Configure logging
        logging.basicConfig(level=logging.INFO)  # This will log messages of level INFO and above

        logging.info(f"Experience Level: {experience_level}")
        logging.info(f"Languages: {languages}")

        # Ensure `languages` is iterable if required
        if isinstance(languages, str):
            languages = languages.split(",")  # Example: Convert CSV string to a list

        # Debug log: After processing
        logging.info(f"Processed Languages: {languages}")

        try:
            languages_input, experience_input = extract_features_from_text(languages, experience_level, preferred_range)
        except ValueError as e:
            print("No specific languages provided or found. Finding the best developers for your experience level.")
            languages_input, experience_input = [], map_experience_level(experience_level)
        # Call AI model
        results = find_top_developers(languages_input, experience_input)

        # Debug log: Results
        logging.info(f"AI Model Results: {results}")
        print(results)

        return Response({"success": True, "data": results}, status=status.HTTP_200_OK)
    except Exception as e:
        logging.error(f"Error: {str(e)}")
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
