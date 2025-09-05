from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from ..models import Categorie, Client, Commande, Produit


class EffectifView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        effectifs = {
            "produit": Produit.objects.all().count(),
            "client": Client.objects.all().count(),
            "categorie": Categorie.objects.all().count(),
            "commande": Commande.objects.all().count(),
        }
        return Response(effectifs, status=status.HTTP_200_OK)
