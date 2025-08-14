class Categorie {
  int numCategorie;
  String nomCategorie;
  String? imageCategorie;
  String descCategorie;

  Categorie({
    required this.numCategorie,
    required this.nomCategorie,
    required this.imageCategorie,
    required this.descCategorie,
  });

  factory Categorie.fromJson(Map<String, dynamic> categorie) {
    return Categorie(
      numCategorie: categorie['numCategorie'],
      nomCategorie: categorie['nomCategorie'],
      imageCategorie: categorie['imageCategorie'],
      descCategorie: categorie['descCategorie'],
    );
  }
  String toSearchableString() {
    return '''
      $nomCategorie
      $descCategorie
    '''
        .toLowerCase();
  }
}
