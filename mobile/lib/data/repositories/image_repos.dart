import 'package:premier_app/data/models/image.dart';

import '../api/image_api.dart';

class ImageRepos {
  Future<ImageProduit> ajouterImage(Map<String, dynamic> donne) {
    return ImageAPI().ajoutImage(donne);
  }

  Future<ImageProduit> modifierImage(Map<String, dynamic> donne) {
    return ImageAPI().modifImage(donne);
  }
  Future<void> supprimerImage(int numImage) {
    return ImageAPI().suppressionImage(numImage);
  }
}
