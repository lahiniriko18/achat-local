import 'package:flutter/material.dart';
import 'package:premier_app/core/constants/menu_constant.dart';
import 'package:premier_app/services/service.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';

class BottomAppBarWidget extends StatelessWidget {
  final int indexCourant;

  BottomAppBarWidget({
    super.key,
    required this.indexCourant
  });

  final List<MenuItem> menus = MenutItems.menus;

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<Config>(context);
    return BottomAppBar(
        height: 70,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: menus.map((menu) {
            final isSelected = menu.index == indexCourant;
            return Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, menu.url);
                },
                splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      menu.icone,
                      color: isSelected ? Theme.of(context).primaryColor : config.couleurTexte,
                      size: 27,
                    ),
                    Text(
                      menu.titre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Theme.of(context).primaryColor : config.couleurTexte,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }
}