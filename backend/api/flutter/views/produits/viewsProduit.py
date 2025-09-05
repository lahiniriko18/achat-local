from django.db.models import Count
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from ...models import Image, Produit
from ...serializer.serializerImage import ImageSerializer
from ...serializer.serializerProduit import ProduitSerializer


class ProduitView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        produits = Produit.objects.all().order_by("-numProduit")
        serializer = ProduitSerializer(
            produits, many=True, context={"request": request}
        )
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        donnee = request.data
        images = request.FILES.getlist("images")
        serializer = ProduitSerializer(data=donnee)
        if serializer.is_valid():
            produit = serializer.save()
            produit.gererQrCode()
            if images:
                for image in images:
                    serializerImage = ImageSerializer(
                        data={"nomImage": image, "numProduit": produit.numProduit}
                    )
                    if serializerImage.is_valid():
                        serializerImage.save()
                    else:
                        return Response(
                            serializerImage.errors, status=status.HTTP_400_BAD_REQUEST
                        )
            return Response(
                ProduitSerializer(produit, context={"request": request}).data,
                status=status.HTTP_200_OK,
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, numProduit):
        donnee = request.data
        images = request.FILES.getlist("images")
        numImageDeleted = donnee.getlist("imageDeleted")
        produit = Produit.objects.filter(pk=numProduit).first()
        if produit:
            serializer = ProduitSerializer(
                produit, data=donnee, context={"request": request}
            )
            if serializer.is_valid():
                produit = serializer.save()
                imageDeleted = Image.objects.filter(pk__in=numImageDeleted)
                if imageDeleted:
                    imageDeleted.delete()
                if images:
                    for image in images:
                        serializerImage = ImageSerializer(
                            data={"nomImage": image, "numProduit": produit.numProduit}
                        )
                        if serializerImage.is_valid():
                            serializerImage.save()
                        else:
                            return Response(
                                serializerImage.errors,
                                status=status.HTTP_400_BAD_REQUEST,
                            )
                return Response(
                    ProduitSerializer(produit, context={"request": request}).data,
                    status=status.HTTP_200_OK,
                )
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        return Response(
            {"erreur": "Produit introuvable !"}, status=status.HTTP_404_NOT_FOUND
        )

    def delete(self, request, numProduit):
        produit = Produit.objects.filter(pk=numProduit).first()
        if produit:
            produit.delete()
            return Response(
                {"message": "Suppression avec succès !"}, status=status.HTTP_200_OK
            )
        return Response(
            {"erreur": "Produit introuvable !"}, status=status.HTTP_404_NOT_FOUND
        )

class DeleteMultipleProduitView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        numProduits = request.data.getlist("numProduits")
        produits = Produit.objects.filter(pk__in=numProduits)
        if produits:
            produits.delete()
            return Response(
                {"message": "Suppression avec succès !"}, status=status.HTTP_200_OK
            )
        return Response(
            {"erreur": "Produit introuvable !"}, status=status.HTTP_404_NOT_FOUND
        )
