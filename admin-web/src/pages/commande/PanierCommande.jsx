import { MoveLeft, Trash2, SquarePen } from "lucide-react";
import { AucunElement } from "../../components/ChargeData";
import { Link } from "react-router-dom";
import { useState } from "react";
import Modal from "../../components/Modal";
import Confirmation from "../../components/Confirmation";
import { totalMontantCommande } from "../../utils/produitUtils";

function PanierCommande({
  produitSelected,
  setProduitSelected,
}) {
  const [selectedId, setSelectedId] = useState(null);
  const [checkedIds, setCheckedIds] = useState([]);
  const [showConfirmation, setShowConfirmation] = useState(false);

  const allChecked = produitSelected.every((p) =>
    checkedIds.includes(p.produit.numProduit)
  );

  const handleCheck = (id) => {
    setCheckedIds((prev) =>
      prev.includes(id) ? prev.filter((i) => i !== id) : [...prev, id]
    );
  };

  const handleCheckAll = () => {
    const currentIds = produitSelected.map((p) => p.produit.numProduit);
    if (allChecked) {
      setCheckedIds((prev) => prev.filter((id) => !currentIds.includes(id)));
    } else {
      currentIds.forEach((id) => {
        if (!checkedIds.includes(id)) {
          setCheckedIds((prev) => [...prev, id]);
        }
      });
    }
  };

  const handleDeleteProduit = () => {
    if (selectedId) {
      if (checkedIds.includes(selectedId)) {
        const produits = produitSelected.filter(
          (p) => !checkedIds.includes(p.produit.numProduit)
        );
        setProduitSelected(produits);
      } else {
        const produits = produitSelected.filter(
          (p) => p.produit.numProduit != selectedId
        );
        setProduitSelected(produits);
      }
    } else {
      setProduitSelected([]);
    }
    setShowConfirmation(false);
  };

  const confirmation = (id) => {
    setSelectedId(id);
    setShowConfirmation(true);
  };

  const hideModal = () => {
    setShowConfirmation(false);
    setSelectedId(null);
  };

  return (
    <div className="flex h-full p-3 overflow-auto">
      <div className="flex p-3 h-full rounded-md w-full flex-col custom-bg shadow">
        <div className="relative flex justify-center">
          <Link to="..">
            <MoveLeft className="absolute left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="font-semibold  text-2xl">Panier</h2>
        </div>
        <div className="flex-1 flex flex-col mt-2">
          {produitSelected.length == 0 ? (
            <div className="flex-1 flex justify-center items-center">
              <AucunElement text="Aucun produit sélectionné" />
            </div>
          ) : (
            <div className="flex w-full flex-1 flex-col">
              <div className="flex flex-col h-full rounded-md">
                <div className="rounded-md w-full flex-1 overflow-auto">
                  <table className="w-full shadow-md rounded">
                    <thead className="text-base leading-normal custom-border-b">
                      <tr>
                        <th className="px-6 text-left">
                          <input
                            type="checkbox"
                            onChange={() => handleCheckAll()}
                            checked={allChecked}
                            className="form-checkbox w-5 h-5 rounded text-primaire cursor-pointer bg-white border-gray-300 focus:ring-0"
                          />
                        </th>
                        <th className="py-3 px-6 text-left">Produit</th>
                        <th className="py-3 px-6 text-left">Quantité</th>
                        <th className="py-3 px-6 text-left">Montant à payer</th>
                        <th className="py-3 px-6 text-center">Actions</th>
                      </tr>
                    </thead>
                    <tbody className="text-base ">
                      {produitSelected.map((p, index) => (
                        <tr
                          key={index}
                          className={`custom-border-b custom-hover 
                        ${
                          checkedIds.includes(p.produit.numProduit)
                            ? "custom-bg-low"
                            : ""
                        }`}
                        >
                          <td className="py-3 px-6">
                            <input
                              onChange={() => handleCheck(p.produit.numProduit)}
                              checked={checkedIds.includes(
                                p.produit.numProduit
                              )}
                              type="checkbox"
                              className="form-checkbox text-primaire w-5 h-5 rounded focus:ring-0 cursor-pointer"
                            />
                          </td>
                          <td className="py-3 px-6">
                            {p.produit.libelleProduit}
                          </td>
                          <td className="py-3 px-6">
                            {p.quantiteCommande} {p.produit.uniteMesure}
                          </td>
                          <td className="py-3 px-6">
                            {p.produit.prixUnitaire * p.quantiteCommande} Ar
                          </td>
                          <td className="py-3 px-6">
                            <div className="flex justify-center space-x-4">
                              <Trash2
                                onClick={() =>
                                  confirmation(p.produit.numProduit)
                                }
                                className="w-5 h-5 text-red-500 cursor-pointer transition-all hover:scale-105"
                              />
                            </div>
                          </td>
                        </tr>
                      ))}
                      <tr className="border-t-2 border-theme-light dark:border-theme-dark font-semibold">
                        <td colSpan={3} className="py-3 px-6">
                          Total montant à payer
                        </td>
                        <td colSpan={2} className="py-3 px-6">
                          {totalMontantCommande(produitSelected)} Ar
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div className="w-full min-h-10 mt-2">
                  <div className="flex flex-col sm:flex-row justify-end gap-2 text-theme-light ">
                    <button
                      onClick={() => setShowConfirmation(true)}
                      className="h-10 w-full sm:w-auto bg-gray-500 transition-all duration-300 hover:bg-gray-600 flex justify-center items-center"
                    >
                      Vider mon panier
                    </button>
                    <Link to="../client" className="text-theme-light">
                      <button className="bg-primaire-1 w-full h-10 transition-all duration-300 hover:bg-primaire-2 flex justify-center items-center">
                        Suivant
                      </button>
                    </Link>
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
      {showConfirmation && <Modal action={hideModal} />}
      {showConfirmation && (
        <Confirmation
          closeAction={hideModal}
          confirmAction={handleDeleteProduit}
          text={
            selectedId != null
              ? checkedIds.includes(selectedId)
                ? "Etes-vous sûre de supprimmer tous ces produits sélectionnés"
                : "Etes-vous sûre de supprimmer cet produit?"
              : "Etes-vous sûre de vider ce panier"
          }
        />
      )}
    </div>
  );
}

export default PanierCommande;
