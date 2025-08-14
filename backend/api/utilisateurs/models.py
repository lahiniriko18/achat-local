from django.db import models
from django.contrib.auth.models import AbstractUser

class Utilisateur(AbstractUser):
    contact = models.CharField(max_length=17, null=True, blank=True)
    image = models.ImageField(upload_to='images/utilisateurs/', null=True, blank=True)
    adresse = models.CharField(max_length=100, null=True, blank=True)
    first_name = models.CharField(max_length=50, null=True, blank=True)
    last_name = models.CharField(max_length=50, null=True, blank=True)

    def clean(self):
        return super().clean()
    class Meta:
        db_table='utilisateur'

    def __str__(self):
        return self.username