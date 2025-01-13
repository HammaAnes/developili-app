from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from log_in.models import Projects, Clientprofile, User

@api_view(['GET'])
def mainPageShow(request):
    projects = Projects.objects.all()  # Fetch all projects
    project_data = []
    
    for project in projects:
        client = Clientprofile.objects.get(id=project.client_id)  # Get the associated client
        user = User.objects.get(id=client.user_id)  # Get the associated user
        
        project_data.append({
            "user_first_name": user.first_name,
            "user_last_name": user.last_name,
            "title": project.title,
            "description": project.description,
            "technologies": project.technologies,
            "team_members":project.team_members,
            "users": project.users,
            "duration": project.duration,
        })
    
    return Response(project_data, status=status.HTTP_200_OK)

@api_view(['GET'])
def fetch_developers(request):
    data = request.data
    all_dev = []
    for dev in data:
        all_dev.append(dev)
