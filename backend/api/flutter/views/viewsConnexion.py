from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView


class ConnexionView(APIView):
    def post(self, request):
        donnee = request.data
        print(donnee)

        return Response({"message": "Mety"}, status=status.HTTP_200_OK)
