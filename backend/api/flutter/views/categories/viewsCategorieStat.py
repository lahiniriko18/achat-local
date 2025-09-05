from django.db.models import Count
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
import json
from ...models import Categorie, Produit
from ...serializer.serializerCategorie import CategorieSerializer


class CategorieDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, numCategorie):
        categorie = Categorie.objects.filter(pk=numCategorie).first()
        if categorie:
            return Response(
                CategorieSerializer(categorie, context={"request": request}).data,
                status=status.HTTP_200_OK,
            )
        return Response(
            {"erreur": "Catégorie introuvable !"}, status=status.HTTP_404_NOT_FOUND
        )


class EffectifProduitCategorieView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, numCategorie):
        produits = Produit.objects.filter(numCategorie=numCategorie)
        donnees = []
        for produit in produits:
            donnees.append(
                {
                    "libelleProduit": produit.libelleProduit,
                    "quantite": produit.quantite,
                    "uniteMesure": produit.uniteMesure,
                }
            )
        return Response(donnees)


class ProduitPlusCommandeCategorieView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, numCategorie):
        produits = (
            Produit.objects.annotate(totalCommandes=Count("comprendres"))
            .filter(numCategorie=numCategorie)
            .order_by("-totalCommandes")[:5]
        ).values("libelleProduit", "totalCommandes")
        donnees = [
            {
                "libelleProduit": p["libelleProduit"],
                "totalCommandes": p["totalCommandes"],
            }
            for p in produits
        ]
        return Response(donnees)
