from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,permissions
from ..serializer.serializerCategorie import CategorieSerializer
from ..serializer.serializerProduit import ProduitSerializer
from ..models import Categorie

class CategorieView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request):
        categories = Categorie.objects.all().order_by('-numCategorie')
        serializer = CategorieSerializer(categories, many=True, context={'request':request})
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def post(self, request):
        serializer = CategorieSerializer(data=request.data)
        if serializer.is_valid():
            categorie = serializer.save()
            return Response(CategorieSerializer(categorie, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, numCategorie):
        categorie =  Categorie.objects.filter(pk=numCategorie).first()
        if categorie:
            serializer = CategorieSerializer(categorie, data=request.data, context={'request':request})
            if serializer.is_valid():
                serializer.save()
                return Response(CategorieSerializer(categorie, context={'request':request}).data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        return Response({"erreur":"Categorie introuvable !"}, status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, numCategorie):
        categorie =  Categorie.objects.filter(pk=numCategorie).first()
        if categorie:
            categorie.delete()
            return Response({"message":"Suppression avec succès !"}, status=status.HTTP_200_OK)
        return Response({"erreur":"Categorie introuvable !"}, status=status.HTTP_404_NOT_FOUND)


class CategorieDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, numCategorie):
        categorie = Categorie.objects.filter(pk=numCategorie).first()
        if categorie:
            return Response(CategorieSerializer(categorie, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response({"erreur":"Catégorie introuvable !"}, status=status.HTTP_404_NOT_FOUND)
    
    
class CategorieProduitDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, numCategorie):
        categorie = Categorie.objects.filter(pk=numCategorie).first()
        if categorie:
            produits = categorie.produits.all().order_by('-numProduit')
            return Response(ProduitSerializer(produits, many=True, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response({"erreur":"Categorie introuvable !"}, status=status.HTTP_404_NOT_FOUND)

class DeleteMultipleCategorieView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def post(self, request):
        numCategories=request.data.getlist('numCategories')
        categories =  Categorie.objects.filter(pk__in=numCategories)
        if categories:
            categories.delete()
            return Response({"message":"Suppression avec succès !"}, status=status.HTTP_200_OK)
        return Response({"erreur":"Categorie introuvable !"}, status=status.HTTP_404_NOT_FOUND)  