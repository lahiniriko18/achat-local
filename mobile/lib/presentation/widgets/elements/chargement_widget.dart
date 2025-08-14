import 'package:flutter/material.dart';

class Chargement extends StatelessWidget {

  const Chargement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 70),
              child: LinearProgressIndicator(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50),
                minHeight: 5,
              ),
            ),
          ],
        )
    );
  }
}