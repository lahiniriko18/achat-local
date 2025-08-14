from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,permissions
from ..serializer.serializerImage import ImageSerializer
from ..models import Image

class ImageView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request):
        images = Image.objects.all().order_by('-numImage')
        serializer = ImageSerializer(images, many=True, context={'request':request})
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def post(self, request):
        donnee=request.data
        if donnee.get('numProduit'):
            donnee['numProduit']=int(donnee['numProduit'])
        serializer = ImageSerializer(data=request.data)
        if serializer.is_valid():
            image = serializer.save()
            return Response(ImageSerializer(image, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request):
        donnee = request.data
        donnee['numProduit']=int(donnee['numProduit'])
        images =  Image.objects.filter(numProduit=donnee['numProduit'])
        if images:
            images.delete()
        serializer = ImageSerializer(data=donnee, context={'request':request})
        if serializer.is_valid():
            image = serializer.save()
            return Response(ImageSerializer(image, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, numImage):
        image =  Image.objects.filter(pk=numImage).first()
        if image:   
            image.delete()
            return Response({"message":"Suppression avec succès !"}, status=status.HTTP_200_OK)
        return Response({"erreur":"Image introuvable !"}, status=status.HTTP_404_NOT_FOUND)