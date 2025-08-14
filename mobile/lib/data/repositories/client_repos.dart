import '../api/client_api.dart';
import '../models/client.dart';

class ClientRepos {
  Future<List<Client>> tousClients() {
    return ClientAPI().listeClients();
  }

  Future<Client> ajouterClient(Map<String, dynamic> donne) {
    return ClientAPI().ajoutClient(donne);
  }

  Future<Client> modifierClient(Map<String, dynamic> donne, int numClient) {
    return ClientAPI().modifClient(donne, numClient);
  }

  Future<Client> uneClient(String numClient) {
    return ClientAPI().uneClient(numClient);
  }

  Future<void> supprimerClient(int numClient) {
    return ClientAPI().suppressionClient(numClient);
  }
}
