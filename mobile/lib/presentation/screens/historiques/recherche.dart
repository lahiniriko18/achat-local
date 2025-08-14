import 'package:flutter/material.dart';

class Recherche extends StatelessWidget {
  final Widget listes;
  final Function(String) rechercher;

  Recherche({super.key, required this.listes, required this.rechercher});

  final TextEditingController valeurControlleur = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 180,
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: TextFormField(
                            controller: valeurControlleur,
                            decoration: InputDecoration(
                              hint: Text(
                                "Rechercher",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white24),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onChanged: (String value) => rechercher(value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: listes),
        ],
      ),
    );
  }
}
