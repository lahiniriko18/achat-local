from django.urls import path
from ..views.viewsClient import ClientView,ClientDetailView,DeleteMultipleClientView

urlpatterns = [
    path('', ClientView.as_view()),
    path('<int:numClient>', ClientDetailView.as_view()),
    path('ajouter/', ClientView.as_view()),
    path('modifier/<int:numClient>', ClientView.as_view()),
    path('supprimer/<int:numClient>', ClientView.as_view()),
    path('supprimer/multiple/', DeleteMultipleClientView.as_view()),
]