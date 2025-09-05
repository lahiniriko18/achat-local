import { ChevronLeft, ChevronRight, Download, MoveLeft } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { Chargement } from "../../components/ChargeData";
import { LineChartProduit } from "../../components/chart/LineChartComponent";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import useConfirmation from "../../hooks/useConfirmation";
import { useDetailProduit } from "../../hooks/useProduits";
import { deleteProduit } from "../../services/ProduitService";

function DetailProduit() {
  const {
    produit,
    loading,
    indexCurrentImage,
    nextImage,
    prevImage,
    setIndexCurrentImage,
  } = useDetailProduit();
  const { showConfirmation, setShowConfirmation, hideModal, confirmation } =
    useConfirmation();
  const navigate = useNavigate();

  const handleDeleteProduit = async () => {
    try {
      await deleteProduit(produit.numProduit);
      setShowConfirmation(false);
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      navigate("/produit", {
        state: {
          successMessage: "Produit supprimé avec succès",
        },
      });
    }
  };
  const telecharger = () => {
    fetch(produit.qrCode)
      .then((res) => res.blob())
      .then((blob) => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = `qr_code_produit_${produit.numProduit}.png`;
        document.body.appendChild(a);
        a.click();
        a.remove();
      });
  };
  const handleModifier = () => {
    navigate(`/produit/modifier/${produit.numProduit}`, {
      state: { produit },
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
            <h2 className="text-xl font-bold  text-center ml-3 sm:ml-0">
              Détails du produit {produit.libelleProduit}
            </h2>
          </div>
          <div className="fex flex-col">
            <div className="w-full flex flex-col gap-3 md:flex-row">
              <div className="flex flex-1 ">
                <div className="flex flex-col w-max gap-2 font-body">
                  <div className="flex gap-2">
                    <b>Identifiant :</b>
                    <span>{produit.numProduit}</span>
                  </div>
                  <div className="flex gap-2">
                    <b>Libellé :</b>
                    <span>{produit.libelleProduit}</span>
                  </div>
                  <div className="flex gap-2">
                    <b>Quantité disponible :</b>
                    <span>
                      {produit.quantite} {produit.uniteMesure}
                    </span>
                  </div>
                  <div className="flex gap-2">
                    <b>Prix unitaire :</b>
                    <span>{produit.prixUnitaire} Ar</span>
                  </div>
                  <div className="flex gap-2">
                    <b>Catégorie :</b>
                    <span>{produit.categorie?.nomCategorie}</span>
                  </div>
                </div>
              </div>
              <div className="flex flex-col flex-1 relative justify-center items-center">
                <img
                  src={
                    produit.images
                      ? produit.images[indexCurrentImage].nomImage
                      : null
                  }
                  className="w-48 h-48 object-cover rounded-full shadow-md"
                  alt="imageProduit"
                />
                <div className="flex w-full justify-between sm:justify-center gap-3 mt-2">
                  <div
                    className="w-10 h-10 p-1 rounded-full transition-all duration-300
                 custom-bg-low flex justify-center items-center"
                  >
                    <ChevronLeft
                      onClick={() => prevImage()}
                      className=" cursor-pointer
              transition-all duration-300 hover:scale-105"
                    />
                  </div>
                  <div className="sm:flex gap-2 hidden">
                    {produit.images?.map((p, index) => (
                      <div
                        onClick={() => setIndexCurrentImage(index)}
                        className={`${
                          index == indexCurrentImage
                            ? "bg-gray-300"
                            : "bg-gray-100"
                        } w-10 h-10 p-1 rounded-full transition-all duration-300
                 custom-bg-low flex justify-center items-center cursor-pointer`}
                      >
                        <span className="">{index + 1}</span>
                      </div>
                    ))}
                  </div>
                  <div
                    className="p-1 w-10 h-10 rounded-full transition-all duration-300
                 custom-bg-low flex justify-center items-center"
                  >
                    <ChevronRight
                      onClick={() => nextImage()}
                      className=" cursor-pointer
              transition-all duration-300 hover:scale-105"
                    />
                  </div>
                </div>
              </div>
            </div>
            <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3 pb-3">
              <div className="h-96 max-h-96 custom-border flex-1 rounded-md p-3 flex flex-col justify-start">
                <h2 className="text-base custom-border-b pb-3 mb-2">
                  Nombre de commande effectué dans cette semaine
                </h2>
                <div className="flex-1 text-sm -ml-7">
                  <LineChartProduit />
                </div>
              </div>
              <div className="relative custom-border p-3 flex flex-col flex-1 h-auto rounded-md">
                <Download
                  onClick={() => telecharger()}
                  className="absolute top-5 right-5 cursor-pointer text-primaire-2
                my-scale"
                />
                <h2 className="text-base custom-border-b pb-3 mb-2">
                  QR code du produit
                </h2>
                <div className="flex-1 w-full flex justify-center">
                  <img src={produit.qrCode} alt="" />
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
          confirmAction={handleDeleteProduit}
          text="Etes-vous sûre de supprimmer cet produit?"
        />
      )}
    </div>
  );
}

export default DetailProduit;
