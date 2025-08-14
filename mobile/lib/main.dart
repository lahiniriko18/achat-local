import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Config(),
      child: const Application(),
    )
  );
}
