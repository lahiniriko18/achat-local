import { MoveLeft } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { Chargement } from "../../components/ChargeData";
import { LineChartCategorie } from "../../components/chart/LineChartComponent";
import { PieChartProduitCategorie } from "../../components/chart/PieChartComponent";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import { useDetailCategorie } from "../../hooks/useCategories";
import useConfirmation from "../../hooks/useConfirmation";
import { deleteCategorie } from "../../services/CategorieService";

function DetailCategorie() {
  const { categorie, effectifProduit, plusCommande, numCategorie, loading } =
    useDetailCategorie();
  const { showConfirmation, setShowConfirmation, hideModal, confirmation } =
    useConfirmation();
  const navigate = useNavigate();

  const handleDeleteCategorie = async () => {
    try {
      await deleteCategorie(numCategorie);
      setShowConfirmation(false);
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      navigate("/categorie", {
        state: {
          successMessage: "Categorie supprimé avec succès",
        },
      });
    }
  };
  const handleModifier = () => {
    navigate(`/categorie/modifier/${numCategorie}`, {
      state: { categorie },
    });
  };
  return (
    <div className="flex flex-col h-full w-full p-4 overflow-auto">
      {loading ? (
        <div className="flex-1 flex justify-center items-center">
          <Chargement />
        </div>
      ) : (
        <div className="w-full max-h-full overflow-aut">
          <div className="relative group flex justify-center pb-4 items-center">
            <MoveLeft
              onClick={() => navigate("..")}
              className="absolute text-primaire-2 left-0 cursor-pointer 
              my-scale"
            />
            <h2 className="text-xl font-bold text-center ml-3 sm:ml-0">
              Détails du catégorie {categorie.nomCategorie}
            </h2>
          </div>
          <div className="fex flex-col">
            <div className="w-full flex flex-col gap-3 md:flex-row">
              <div className="flex flex-1">
                <div className="flex flex-col w-max gap-2">
                  <div className="flex gap-2">
                    <b>Identifiant :</b>
                    <span>{categorie.numCategorie}</span>
                  </div>
                  <div className="flex gap-2">
                    <b>Nom du catégorie :</b>
                    <span>{categorie.nomCategorie}</span>
                  </div>
                  <div className="flex gap-2">
                    <b>Nombre des produits :</b>
                    <span>
                      {categorie.produits ? categorie.produits.length : 0}
                    </span>
                  </div>
                  <div className="flex gap-2">
                    <b>Description :</b>
                    <span>{categorie.descCategorie}</span>
                  </div>
                </div>
              </div>
              <div className="flex flex-col flex-1 relative justify-center items-center">
                <img
                  src={categorie.imageCategorie}
                  className="w-48 h-48 object-cover rounded-full shadow-md"
                  alt="imageCategorie"
                />
              </div>
            </div>
            <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3 pb-3">
              <div className="h-96 max-h-96 custom-border flex-1 rounded-md p-3 flex flex-col justify-start">
                <h2 className="text-base custom-border-b mb-2 pb-3">
                  {plusCommande.length == 5 ? "5 produits" : "Produits"} le plus
                  commandés
                </h2>
                <div className="flex-1 text-sm -ml-7">
                  <LineChartCategorie data={plusCommande} />
                </div>
              </div>
              <div className="relative custom-border p-3 flex flex-col borde flex-1 h-auto rounded-md">
                <h2 className="text-base custom-border-b mb-2 pb-3">
                  Camembert de quantité des produits
                </h2>
                <div className="flex-1 w-full flex justify-center">
                  <PieChartProduitCategorie data={effectifProduit} />
                </div>
              </div>
            </div>
            <div className="pb-2">
              <div className="flex justify-center sm:justify-start gap-3">
                <button
                  onClick={() => handleModifier()}
                  className="text-theme-light text-center bg-gray-600 transition-all duration-300
                hover:bg-gray-700"
                >
                  Modifier
                </button>
                <button
                  onClick={() => confirmation()}
                  className="text-theme-light text-center bg-red-500 transition-all duration-300
                hover:bg-red-600"
                >
                  Supprimer
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
      {showConfirmation && <Modal action={hideModal} />}
      {showConfirmation && (
        <Confirmation
          closeAction={hideModal}
          confirmAction={handleDeleteCategorie}
          text="Etes-vous sûre de supprimmer cet categorie?"
        />
      )}
    </div>
  );
}

export default DetailCategorie;
