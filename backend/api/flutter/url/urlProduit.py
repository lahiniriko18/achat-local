from django.conf import settings
from django.conf.urls.static import static
from django.urls import path

from ..views.produits.viewsProduit import DeleteMultipleProduitView, ProduitView
from ..views.produits.viewsProduitStat import ProduitDetailView, ProduitPlusCommandeView

urlpatterns = [
    path("", ProduitView.as_view()),
    path("<int:numProduit>", ProduitDetailView.as_view()),
    path("ajouter/", ProduitView.as_view()),
    path("modifier/<int:numProduit>", ProduitView.as_view()),
    path("supprimer/<int:numProduit>", ProduitView.as_view()),
    path("supprimer/multiple/", DeleteMultipleProduitView.as_view()),
    path("produit-commande/<int:limite>", ProduitPlusCommandeView.as_view()),
    path("produit-commande/", ProduitPlusCommandeView.as_view()),
    path("verifier-produit/", ProduitDetailView.as_view()),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
