from datetime import datetime, timedelta

from django.db.models import Count
from django.db.models.functions import TruncDate
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView

from ...models import Commande
from ...serializer.serializerCommande import CommandeSerializer


class EvolutionCommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        today = datetime.now().date()
        print(today)
        lundi = today - timedelta(days=today.weekday())
        commandeSemaines = (
            Commande.objects.filter(
                dateCommande__date__range=[lundi, lundi + timedelta(days=6)]
            )
            .annotate(jour=TruncDate("dateCommande"))
            .values("jour")
            .annotate(nombre=Count("pk"))
            .order_by("jour")
        )
        jourNombres = {c["jour"]: c["nombre"] for c in commandeSemaines}
        jours = [
            "Lundi",
            "Mardi",
            "Mercredi",
            "Jeudi",
            "Vendredi",
            "Samedi",
            "Dimanche",
        ]
        donnees = []
        for i in range(7):
            jour = lundi + timedelta(days=i)
            donnees.append({"jour": jours[i], "nombre": jourNombres.get(jour, 0)})
        return Response(donnees)


class DernierCommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, limite):
        commande = Commande.objects.all().order_by("-numCommande")[:limite]
        if commande or limite > 1:
            serialzer = CommandeSerializer(
                commande if limite>1 else commande[0],
                context={"request": request},
                many=True if limite > 1 else None,
            )
            return Response(serialzer.data, status=status.HTTP_200_OK)
        return Response({}, status=status.HTTP_200_OK)
