from rest_framework import serializers
from ..models import Commande, Client
from ..serializer.serializerProduit import ProduitSerializer
from ..serializer.serializerClient import ClientSerializer
from datetime import date, timedelta


class CommandeSerializer(serializers.ModelSerializer):

    numClient = serializers.PrimaryKeyRelatedField(
        queryset=Client.objects.all(),
        error_messages={
            "does_not_exist": "Ce client spécifié n'existe pas !",
            "incorrect_type": "Le format de l'ID du client est invalide !",
        },
    )
    client = ClientSerializer(source="numClient", read_only=True)
    produits = serializers.SerializerMethodField(read_only=True)
    periode = serializers.SerializerMethodField()

    class Meta:
        model = Commande
        fields = [
            "numCommande",
            "numClient",
            "dateCommande",
            "reference",
            "periode",
            "client",
            "produits",
        ]

    def get_produits(self, obj):
        comprendres = obj.comprendres.all()
        request = self.context.get("request")
        produits = []
        for comprendre in comprendres:
            d = {
                "produit": ProduitSerializer(
                    comprendre.numProduit, context={"request": request}
                ).data,
                "quantiteCommande": comprendre.quantiteCommande,
            }
            produits.append(d)
        return produits

    def get_periode(self, obj):
        dateCommande = obj.dateCommande.date()
        now = date.today()
        diff = now - dateCommande

        lundi = now - timedelta(now.weekday())
        dimanche = lundi + timedelta(days=6)

        print(lundi)
        print(lundi - timedelta(days=7))

        if diff.days == 0:
            return "Aujourd'hui"
        if diff.days == 1:
            return "Hier"
        if lundi <= dateCommande <= dimanche:
            return "Cette semaine"
        if lundi - timedelta(days=7) <= dateCommande <= dimanche - timedelta(days=7):
            return "Semaine dernier"
        if now.month == dateCommande.month and now.year == dateCommande.year:
            return "Cette mois-ci"
        if now.month == dateCommande.month + 1 and now.year == dateCommande.year:
            return "Mois dernier"
        if now.year == dateCommande.year:
            return "Cette année"
        if now.year == dateCommande.year + 1:
            return "Année dernier"
        return "Plus ancien"

    def validate(self, data):
        return data

    def create(self, validated_data):
        return Commande.objects.create(**validated_data)
