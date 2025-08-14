
class ImageProduit {
  int numImage;
  int numProduit;
  String nomImage;

  ImageProduit({
    required this.numImage,
    required this.numProduit,
    required this.nomImage
  });

  factory ImageProduit.fromJson(Map<String, dynamic> image) {
    return ImageProduit(
      numImage: image['numImage'], 
      numProduit: image['numProduit'], 
      nomImage: image['nomImage']
      );
  }
}