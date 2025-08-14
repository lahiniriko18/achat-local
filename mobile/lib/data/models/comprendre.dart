
class Comprendre {
  int numComprendre;
  int numProduit;
  int numCommande;

  Comprendre({
    required this.numComprendre,
    required this.numProduit,
    required this.numCommande
  });

  factory Comprendre.fromJson(Map<String, dynamic> comprendre) {
    return Comprendre(
      numComprendre: comprendre['numComprendre'], 
      numProduit: comprendre['numProduit'], 
      numCommande: comprendre['numCommande']
      );
  }
}