import { Link, useNavigate } from "react-router-dom";
import { addClient } from "../../services/ClientService";
import { dictToFormData } from "../../utils/traitement";
import { addCommande } from "../../services/CommandeService";
import { totalMontantCommande } from "../../utils/produitUtils";

function VerificationCommande({ produitSelected, client }) {
  const navigate = useNavigate();
  const listProduits = produitSelected.map((p) => {
    return `${p.produit.libelleProduit} (${p.quantiteCommande} ${p.produit.uniteMesure})`;
  });

  const validerCommande = async () => {
    try {
      let dataCommande = new FormData();
      const dataClient = dictToFormData(client);
      const c = await addClient(dataClient);
      produitSelected.forEach((p) => {
        dataCommande.append(
          "produits",
          JSON.stringify({
            numProduit: p.produit.numProduit,
            quantiteCommande: p.quantiteCommande,
          })
        );
      });
      dataCommande.append("numClient", c.numClient);
      await addCommande(dataCommande);
      navigate("/commande", {
        state: { successMessage: "Commande effectué avec succès!" },
      });
    } catch (e) {
      console.error("Erreur :" + e);
    }
  };

  return (
    <div className="flex h-full justify-center items-center px-3">
      <div className="w-full overflow-auto lg:w-1/2 md:w-2/3 custom-bg shadow rounded-lg p-6 space-y-4">
        <div className="flex flex-col w-full h-full">
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            Vérification
          </h2>
          <div className="flex flex-1">
            <div className="flex flex-col gap-2">
              <div className="flex gap-3">
                <b className="text-nowrap">Produits :</b>
                <span>{listProduits.join(", ")}</span>
              </div>
              <div className="flex gap-3">
                <b>Client :</b>
                <span>{client.nom}</span>
              </div>
              <div className="flex gap-3">
                <b>Montant à payer :</b>
                <span>{totalMontantCommande(produitSelected)} Ar</span>
              </div>
            </div>
          </div>
          <div className="w-full min-h-10 mt-8">
            <div className="flex flex-col sm:flex-row justify-end gap-2">
              <Link to="../client">
                <button className="h-10 w-full sm:w-auto text-theme-light bg-gray-500 transition-all duration-300 hover:bg-gray-600 flex justify-center items-center">
                  Précedent
                </button>
              </Link>
              <Link to="..">
                <button
                  onClick={() => validerCommande()}
                  className="bg-primaire-1 h-10 text-theme-light w-full transition-all duration-300 hover:bg-primaire-2 flex justify-center items-center"
                >
                  Valider
                </button>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default VerificationCommande;
