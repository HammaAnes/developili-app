from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from use_ai.ai_model.mymodel import find_top_developers, extract_features_from_text, map_experience_level
from log_in.models import Questionresponsemapping
import logging

@api_view(['POST'])
def topDeveloper(request):
    try:
        # Parse input data
        data = request.data
        user_id = data.get('user_id')
        
        # Fetch responses

        language_response = Questionresponsemapping.objects.filter(
            user_id=user_id, question_id=11
        ).first()
        budget_response = Questionresponsemapping.objects.filter(
            user_id=user_id, question_id=12
        ).first()

        # Validate inputs
        if not budget_response or not language_response:
            return Response(
                {"success": False, "error": "Both 'experience_level' and 'languages' are required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Extract response fields
        languages = language_response.response  # Replace 'response' with actual field name
        budget= budget_response.response
        
        # Debug log: Check values

        try:
            languages_input, budget_input = extract_features_from_text(languages, budget)
        except ValueError as e:
            print("No specific languages provided or found. Finding the best developers for your experience level.")
            languages_input, budget_input = [], map_experience_level()
        # Call AI model
        results = find_top_developers(languages_input, budget_input)

        # Debug log: Results
        print(results)

        return Response({"success": True, "data": results}, status=status.HTTP_200_OK)
    except Exception as e:
        logging.error(f"Error: {str(e)}")
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
