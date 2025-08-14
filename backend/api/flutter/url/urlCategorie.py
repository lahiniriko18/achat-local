from django.urls import path
from ..views.viewsCategorie import CategorieView,CategorieDetailView,CategorieProduitDetailView,DeleteMultipleCategorieView

urlpatterns = [
    path('', CategorieView.as_view()),
    path('<int:numCategorie>', CategorieDetailView.as_view()),
    path('ajouter/', CategorieView.as_view()),
    path('modifier/<int:numCategorie>', CategorieView.as_view()),
    path('supprimer/<int:numCategorie>', CategorieView.as_view()),
    path('supprimer/multiple/', DeleteMultipleCategorieView.as_view()),
    path('produit/<int:numCategorie>', CategorieProduitDetailView.as_view()),
]