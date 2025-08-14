from rest_framework import serializers
from ..models import Produit,Classement,Categorie
from .serializerCategorieProduit import CategorieProduitSerializer
from .serializerImage import ImageSerializer

class ProduitSerializer(serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)
    numClassement = serializers.PrimaryKeyRelatedField(
        queryset=Classement.objects.all(),
        allow_null = True,
        required =False,
        error_messages={
            'does_not_exist': "Ce classement spécifié n'existe pas !",
            'incorrect_type': "Le format de l'ID du classement est invalide !",
        },
    )
    numCategorie = serializers.PrimaryKeyRelatedField(
        queryset=Categorie.objects.all(),
        allow_null = True,
        required =False,
        error_messages={
            'does_not_exist': "Ce categorie spécifié n'existe pas !",
            'incorrect_type': "Le format de l'ID du categorie est invalide !",
        }
    )
    qrCode = serializers.ImageField(
        allow_null = True,
        required = False,
        read_only=True
    )
    categorie = CategorieProduitSerializer(source='numCategorie', read_only = True)
    class Meta: 
        model=Produit
        fields=[
            "numProduit",
            "numClassement",
            "numCategorie",
            "categorie",
            "libelleProduit",
            "quantite",
            "prixUnitaire",
            "uniteMesure",
            "description",
            "qrCode",
            "images"
        ]
    
    def get_images(self, obj):
        request = self.context.get('request')
        images=obj.images.all()
        return ImageSerializer(images, many=True, context={"request":request}).data
    def validate(self, data):
        donnee=data
        return donnee
    
    def create(self, validated_data):
        return Produit.objects.create(**validated_data)