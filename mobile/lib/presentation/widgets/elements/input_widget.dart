import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premier_app/configuration/config.dart';
import 'package:premier_app/core/utils/app_utils.dart';

class InputWidget extends StatefulWidget {

  final String nomInput;
  final TextEditingController inputControlleur;
  final String? Function(String?)? validation;
  final bool? cache;
  final bool isOutline;
  final String? prefixe;
  final TextInputType? type;
  final int? maxLigne;
  final String? valeur;

  InputWidget ({
    super.key,
    required this.nomInput,
    required this.inputControlleur,
    this.validation,
    this.cache,
    required this.isOutline,
    this.prefixe,
    this.type,
    this.maxLigne,
    this.valeur
  });

  @override
  State<InputWidget> createState() => InputWidgetState();
}

class InputWidgetState extends State<InputWidget> {

  late bool cache;
  Couleur couleurInstance = Couleur();
  late TextEditingController inputControlleur;

  @override
  void initState() {
    super.initState();
    cache = widget.cache ?? false;
    inputControlleur = widget.inputControlleur;
    inputControlleur = TextEditingController(text: widget.valeur);
  }

  @override
  Widget build(BuildContext context) {
    final config=Provider.of<Config>(context);
    Color couleurTexte = config.couleurTexte;
    return TextFormField(
        controller: widget.inputControlleur,
        obscureText: cache,
        style: Theme.of(context).textTheme.bodyMedium,
        cursorColor: couleurTexte,
        keyboardType: widget.type,
        maxLines: widget.maxLigne ?? 1,
        decoration: InputDecoration(
            label: Text(
              widget.nomInput,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: couleurTexte
              ),
            ),
            enabledBorder: widget.isOutline ? OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ) : UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: widget.isOutline ? OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ) : UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            suffixIcon: widget.cache != null ? IconButton(
              icon: Icon(
                  cache ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  cache = !cache;
                });
              },
            ): null,
            prefixText: widget.prefixe ?? null
        ),
        validator: (val) {
          if (widget.validation != null){
            return widget.validation!(val);
          }
          else{
            return null;
          }
        }
    );
  }
}