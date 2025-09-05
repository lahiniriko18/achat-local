from django.urls import path
from ..views.categories.viewsCategorie import (
    CategorieView,
    CategorieProduitDetailView,
    DeleteMultipleCategorieView,
)
from ..views.categories.viewsCategorieStat import (
    CategorieDetailView,
    EffectifProduitCategorieView,
    ProduitPlusCommandeCategorieView,
)

urlpatterns = [
    path("", CategorieView.as_view()),
    path("<int:numCategorie>", CategorieDetailView.as_view()),
    path("ajouter/", CategorieView.as_view()),
    path("modifier/<int:numCategorie>", CategorieView.as_view()),
    path("supprimer/<int:numCategorie>", CategorieView.as_view()),
    path("supprimer/multiple/", DeleteMultipleCategorieView.as_view()),
    path("produit/<int:numCategorie>", CategorieProduitDetailView.as_view()),
    path("effectif-produit/<int:numCategorie>", EffectifProduitCategorieView.as_view()),
    path(
        "plus-commande/<int:numCategorie>", ProduitPlusCommandeCategorieView.as_view()
    ),
]
