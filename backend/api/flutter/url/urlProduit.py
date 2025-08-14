from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from ..views.viewsProduit import ProduitView,ProduitDetailView,ProduitCommandeView,DeleteMultipleProduitView

urlpatterns = [
    path('', ProduitView.as_view()),
    path('<int:numProduit>', ProduitDetailView.as_view()),
    path('ajouter/', ProduitView.as_view()),
    path('modifier/<int:numProduit>', ProduitView.as_view()),
    path('supprimer/<int:numProduit>', ProduitView.as_view()),
    path('supprimer/multiple/', DeleteMultipleProduitView.as_view()),
    path('produit-commande/<int:limite>', ProduitCommandeView.as_view()),
    path('produit-commande/', ProduitCommandeView.as_view()),
    path('verifier-produit/', ProduitDetailView.as_view()),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)