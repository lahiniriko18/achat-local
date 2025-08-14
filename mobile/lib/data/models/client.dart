class Client {
  final int numClient;
  final String nom;
  final String? contact;
  final String? adresse;

  Client({required this.numClient, required this.nom, required this.contact, required this.adresse});

  factory Client.fromJson(Map<String, dynamic> client) {
    return Client(
      numClient: client['numClient'],
      nom: client['nom'],
      contact: client['contact'],
      adresse: client['adresse']
    );
  }

  String toSearchableString() {
    return '''
      $nom
      $contact
      $adresse
    '''
        .toLowerCase();
  }
}
