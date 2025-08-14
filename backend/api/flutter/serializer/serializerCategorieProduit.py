from rest_framework import serializers
from ..models import Produit,Categorie

class CategorieProduitSerializer(serializers.ModelSerializer):
    class Meta:
        model=Categorie
        fields=["numCategorie","nomCategorie","imageCategorie","descCategorie"]
        
class ProduitCategorieSerializer(serializers.ModelSerializer):
    images = serializers.SerializerMethodField(read_only=True)
    qrCode = serializers.ImageField(
        allow_null = True,
        required = False,
        read_only=True
    )
    class Meta: 
        model=Produit
        fields=[
            "numProduit",
            "numClassement",
            "numCategorie",
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
        return [
            request.build_absolute_uri(image.nomImage.url)
            for image in obj.images.all() if image.nomImage
        ]