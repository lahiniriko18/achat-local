from rest_framework import serializers
from ..models import Categorie
from .serializerCategorieProduit import ProduitCategorieSerializer

class CategorieSerializer(serializers.ModelSerializer):

    produits=serializers.SerializerMethodField(read_only=True)
    class Meta:
        model=Categorie
        fields=["numCategorie","nomCategorie","imageCategorie","descCategorie","produits"]
        extra_kwargs = {
            'imageCategorie': {'required': False, 'allow_null': True}
        }

    def validate(self, data):
        if 'imageCategorie' in data:
            image = data['imageCategorie']
            if isinstance(image, str):
                data.pop('imageCategorie')
        return data
    
    def create(self, validated_data):
        return Categorie.objects.create(**validated_data)
    
    def get_produits(self, obj):
        produits=obj.produits.all()
        request = self.context.get('request')
        return ProduitCategorieSerializer(produits,many=True, context={"request":request}).data