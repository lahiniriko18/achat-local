from django.db.models import Count
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from ...models import Produit
from ...serializer.serializerProduit import ProduitSerializer


class ProduitDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, numProduit):
        produit = Produit.objects.filter(pk=numProduit).first()
        if produit:
            return Response(
                ProduitSerializer(produit, context={"request": request}).data,
                status=status.HTTP_200_OK,
            )
        return Response(
            {"erreur": "Produit introuvable !"}, status=status.HTTP_404_NOT_FOUND
        )

    def post(self, request):
        data = request.data
        quantite = data.get("quantite")
        numProduit = data.get("numProduit")
        verif = Produit.objects.filter(
            numProduit=numProduit, quantite__gte=quantite
        ).exists()
        return Response({"valeur": verif}, status=status.HTTP_200_OK)


class ProduitPlusCommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, limite):
        produit = Produit.objects.annotate(
            totalCommandes=Count("comprendres")
        ).order_by("-totalCommandes")[:limite]
        if produit or limite > 1:
            return Response(
                ProduitSerializer(
                    produit,
                    context={"request": request},
                    many=True if limite > 1 else None,
                ).data,
                status=status.HTTP_200_OK,
            )
        return Response({}, status=status.HTTP_200_OK)

    def post(self, request):
        numProduits = request.data.get("numProduits")
        numProduits = list(map(int, numProduits))
        for numProduit in numProduits:
            produit = Produit.objects.filter(pk=numProduit).first()
            if produit:
                produit.quantite -= 1
                produit.save()
        return Response(
            {"message": "Produit modifier avec succès!"}, status=status.HTTP_200_OK
        )
