import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';

class MenuItemWidget extends StatelessWidget {
  final Icon icone;
  final String titre;
  final String menuSelection;
  final Function()? action;

  MenuItemWidget({
    super.key,
    required this.icone,
    required this.titre,
    required this.menuSelection,
    this.action
    });

  @override
  Widget build(BuildContext context) {
    final selectione = menuSelection == titre;
    final config = Provider.of<Config>(context);
    return ListTile(
      leading: icone,
      selected: selectione,
      selectedColor: Theme.of(context).primaryColor,
      title: Text(
        titre,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: selectione ? Theme.of(context).primaryColor : (config.isDark ? Colors.white : Colors.black)
        ),
      ),
      onTap: action,
    );
  }
}