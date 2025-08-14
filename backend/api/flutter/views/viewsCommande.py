from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status,permissions
import json
from ..serializer.serializerCommande import CommandeSerializer
from ..serializer.serializerComprendre import ComprendreSerializer
from ..models import Commande

class CommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request):
        commandes = Commande.objects.all().order_by('-numCommande')
        serializer = CommandeSerializer(commandes, many=True, context={'request':request})
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def post(self, request):
        donnee = request.data
        donneProduits = donnee.getlist('produits', [])
        donneCommande = {
            "reference":donnee.get('reference'),
            "numClient":donnee.get('numClient')
        }
        serializer = CommandeSerializer(data=donneCommande)
        if serializer.is_valid():
            commande = serializer.save()
            for dp in donneProduits:
                dp=json.loads(dp)
                donneComprendre = {
                    "numCommande":commande.numCommande,
                    "numProduit":dp['numProduit'],
                    "quantiteCommande": dp['quantiteCommande']
                }
                serializerComprendre = ComprendreSerializer(data = donneComprendre)
                if serializerComprendre.is_valid():
                    comprendre = serializerComprendre.save()
            return Response(CommandeSerializer(commande, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, numCommande):
        commande =  Commande.objects.filter(pk=numCommande).first()
        if commande:
            serializer = CommandeSerializer(commande, data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(CommandeSerializer(commande, context={'request':request}).data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        return Response({"erreur":"Commande introuvable !"}, status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, numCommande):
        commande =  Commande.objects.filter(pk=numCommande).first()
        if commande:
            commande.delete()
            return Response({"message":"Suppression avec succès !"}, status=status.HTTP_200_OK)
        return Response({"erreur":"Commande introuvable !"}, status=status.HTTP_404_NOT_FOUND)

class CommandeDetailView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, numCommande):
        commande = Commande.objects.filter(pk=numCommande).first()
        if commande:
            return Response(CommandeSerializer(commande, context={'request':request}).data, status=status.HTTP_200_OK)
        return Response({}, status=status.HTTP_200_OK)

class DernierCommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, limite):
        commande = Commande.objects.filter().order_by('-numCommande')[:limite]
        if commande or limite>1:
            return Response(CommandeSerializer(commande, context={'request':request}, many=True if limite>1 else None).data, status=status.HTTP_200_OK)
        return Response({}, status=status.HTTP_200_OK)


class DeleteMultipleCommandeView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def post(self, request):
        numCommandes=request.data.getlist('numCommandes')
        commandes =  Commande.objects.filter(pk__in=numCommandes)
        if commandes:
            commandes.delete()
            return Response({"message":"Suppression avec succès !"}, status=status.HTTP_200_OK)
        return Response({"erreur":"Commande introuvable !"}, status=status.HTTP_404_NOT_FOUND)  