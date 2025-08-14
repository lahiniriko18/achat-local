from django.urls import path
from ..views.viewsCommande import CommandeView,CommandeDetailView,DernierCommandeView,DeleteMultipleCommandeView

urlpatterns = [
    path('', CommandeView.as_view()),
    path('<int:numCommande>', CommandeDetailView.as_view()),
    path('ajouter/', CommandeView.as_view()),
    path('modifier/<int:numCommande>', CommandeView.as_view()),
    path('supprimer/<int:numCommande>', CommandeView.as_view()),
    path('supprimer/multiple/', DeleteMultipleCommandeView.as_view()),
    path('dernier-commande/<int:limite>', DernierCommandeView.as_view()),
]