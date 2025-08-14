from django.apps import AppConfig


class FlutterConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'api.flutter'
    label = 'flutter'

    def ready(self):
        import api.flutter.signals
