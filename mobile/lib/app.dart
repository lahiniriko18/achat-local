import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/presentation/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    return MaterialApp(
      theme: AppTheme.getTheme(config),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
