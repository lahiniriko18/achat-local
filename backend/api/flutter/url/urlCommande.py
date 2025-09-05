from django.urls import path
from ..views.commandes.viewsCommande import (
    CommandeView,
    CommandeDetailView,
    DeleteMultipleCommandeView,
)
from ..views.commandes.viewsCommandeStat import (
    EvolutionCommandeView,
    DernierCommandeView,
)

urlpatterns = [
    path("", CommandeView.as_view()),
    path("<int:numCommande>", CommandeDetailView.as_view()),
    path("ajouter/", CommandeView.as_view()),
    path("modifier/<int:numCommande>", CommandeView.as_view()),
    path("supprimer/<int:numCommande>", CommandeView.as_view()),
    path("supprimer/multiple/", DeleteMultipleCommandeView.as_view()),
    path("dernier-commande/<int:limite>", DernierCommandeView.as_view()),
    path("commande-semaine/", EvolutionCommandeView.as_view()),
    path("dernier-commande/<int:limite>", DernierCommandeView.as_view()),
]
