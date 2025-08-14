import { useState, useEffect } from "react";
import { Link, useLocation } from "react-router-dom";
import Modal from "../../components/Modal";
import SuccessToast from "../../components/Notification";
import Confirmation from "../../components/Confirmation";
import { AucunElement, Chargement } from "../../components/ChargeData";
import { totalMontantCommande } from "../../utils/produitUtils";
import useCommandes from "../../hooks/useCommandes";
import useCheckSelection from "../../hooks/useCheckSelection";
import TextSelectionComponent from "../../components/TextSelectionComponent";
import {
  deleteCommande,
  deleteMultipleCommande,
} from "../../services/CommandeService";
import {
  Trash2,
  Info,
  ChevronLeft,
  ChevronRight,
  PlusCircleIcon,
} from "lucide-react";

function Commande() {
  const { commandes, loading, error, fetchCommandes } = useCommandes();
  const {
    checkedIds,
    allChecked,
    nbChecked,
    handleCheck,
    handleCheckAll,
    setCheckedIds,
  } = useCheckSelection(commandes, "numCommande");
  const [selectedId, setSelectedId] = useState(null);
  const [searchTerm, setSearchTerm] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(6);
  const location = useLocation();
  const [showToast, setShowToast] = useState(false);
  const [toastMessage, setToastMessage] = useState("");
  const [showConfirmation, setShowConfirmation] = useState(false);
  const filteredData = commandes.filter((item) =>
    item.dateCommande
      .toString()
      .toLowerCase()
      .includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);
  const handleDeleteCommande = async () => {
    try {
      await deleteCommande(selectedId);
      setShowConfirmation(false);
      setSelectedId(null);
      fetchCommandes();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      setShowToast(true);
      setToastMessage("Suppression avec succès");
    }
  };
  const handleDeleteMultipleCommande = async () => {
    try {
      const formData = new FormData();
      checkedIds.forEach((id) => {
        formData.append("numCommandes", id);
      });
      await deleteMultipleCommande(formData);
      setShowConfirmation(false);
      setSelectedId(null);
      setCheckedIds([]);
      fetchCommandes();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      setShowToast(true);
      setToastMessage("Suppression avec succès");
    }
  };
  const hideModal = () => {
    setShowConfirmation(false);
    setSelectedId(null);
  };
  const confirmation = (id) => {
    setSelectedId(id);
    setShowConfirmation(true);
  };
  useEffect(() => {
    if (location.state?.successMessage) {
      setToastMessage(location.state.successMessage);
      setShowToast(true);
      window.history.replaceState({}, document.title);
    }
  }, [location.state]);
  return (
    <div className="flex h-full p-3 flex-col overflow-auto">
      <h2 className="font-semibold font-sans text-2xl">Commande</h2>
      <div className="flex-1 flex flex-col mt-3 py-2 px-2">
        <div className="flex justify-between items-center">
          <div className="flex gap-2 items-center">
            <label
              htmlFor=""
              className="font-medium text-base ms-0 text-gray-700 hidden sm:block"
            >
              Lignes :
            </label>
            <select
              value={itemsPerPage}
              onChange={(e) => setItemsPerPage(e.target.value)}
              className="border outline-none rounded px-2 py-1 text-sm"
            >
              {[5, 6, 10, 25, 50, 100].map((n) => (
                <option key={n} value={n}>
                  {n}
                </option>
              ))}
              <option value={commandes.length}>Tous</option>
            </select>
          </div>
          <Link to="/commande/ajouter">
            <button
              className="bg-primaire-2 text-white rounded-md
           h-10 text-center flex gap-2 items-center mb-2"
            >
              <PlusCircleIcon />
              <span>Ajouter</span>
            </button>
          </Link>
        </div>

        {loading ? (
          <div className="flex-1 flex justify-center items-center">
            <Chargement />
          </div>
        ) : commandes.length == 0 ? (
          <div className="flex-1 flex justify-center items-center">
            <AucunElement text="Aucun commande" />
          </div>
        ) : (
          <div className="flex flex-1 flex-col">
            <div className="flex flex-1 rounded-md">
              <div className="rounded-md w-full overflow-auto">
                <table className="w-full bg-white shadow-md rounded">
                  <thead className="bg-gray-100 text-gray-600 font-sans text-base leading-normal border-b">
                    <tr>
                      <th className="px-6 text-left">
                        <input
                          type="checkbox"
                          onChange={() => handleCheckAll()}
                          checked={allChecked}
                          className="form-checkbox w-5 h-5 rounded text-primaire cursor-pointer bg-white border-gray-300 focus:ring-0"
                        />
                      </th>
                      <th className="py-3 px-6 text-left">Numéro</th>
                      <th className="py-3 px-6 text-left">Client</th>
                      <th className="py-3 px-6 text-left">Date</th>
                      <th className="py-3 px-6 text-left">
                        Nombre des produits
                      </th>
                      <th className="py-3 px-6 text-left">Montant total</th>
                      <th className="py-3 px-6 text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="text-gray-700 text-base font-sans">
                    {currentItems.map((commande, index) => (
                      <tr
                        key={index}
                        className={`border-b hover:bg-gray-50 
                        ${
                          checkedIds.includes(commande.numCommande)
                            ? "bg-gray-50"
                            : ""
                        }`}
                      >
                        <td className="py-3 px-6">
                          <input
                            onChange={() => handleCheck(commande.numCommande)}
                            checked={checkedIds.includes(commande.numCommande)}
                            type="checkbox"
                            className="form-checkbox text-primaire w-5 h-5 rounded focus:ring-0 cursor-pointer"
                          />
                        </td>
                        <td className="py-3 px-6">{commande.numCommande}</td>
                        <td className="py-3 px-6">{commande.client.nom}</td>
                        <td className="py-3 px-6">{commande.dateCommande}</td>
                        <td className="py-3 px-6">
                          {commande.produits.length}
                        </td>
                        <td className="py-3 px-6">
                          {totalMontantCommande(commande.produits)} Ar
                        </td>
                        <td className="py-3 px-6">
                          <div className="flex justify-center space-x-4">
                            <Trash2
                              onClick={() => confirmation(commande.numCommande)}
                              className="w-5 h-5 text-red-500 cursor-pointer transition-all hover:scale-105"
                            />
                            <Info className="w-5 h-5 text-primaire-2 cursor-pointer transition-all hover:scale-105" />
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
            <div className="flex relative justify-center items-center mt-2 gap-4">
              <TextSelectionComponent nbChecked={nbChecked} />
              <button
                onClick={() => setCurrentPage((prev) => Math.max(prev - 1, 1))}
                className="px-2 py-2 bg-gray-200
             hover:bg-gray-300 rounded-full border-0 transition-all cursor-pointer hover:scale-105"
                disabled={currentPage === 1}
              >
                <ChevronLeft />
              </button>
              <span className="font-sans text-base">
                Page {currentPage} par {totalPages}
              </span>
              <button
                onClick={() =>
                  setCurrentPage((prev) => Math.min(prev + 1, totalPages))
                }
                className="px-2 py-2 bg-gray-200 hover:bg-gray-300 cursor-pointer rounded-full 
            border-0 transition-all hover:scale-105"
                disabled={currentPage === totalPages}
              >
                <ChevronRight />
              </button>
            </div>
          </div>
        )}
      </div>

      {showConfirmation && <Modal action={hideModal} />}
      {showConfirmation && (
        <Confirmation
          closeAction={hideModal}
          confirmAction={
            checkedIds.includes(selectedId)
              ? handleDeleteMultipleCommande
              : handleDeleteCommande
          }
          text={
            checkedIds.includes(selectedId)
              ? "Etes-vous sûre de supprimmer tous ces commandes sélectionnés"
              : "Etes-vous sûre de supprimmer cet commande?"
          }
        />
      )}
      {showToast && (
        <SuccessToast
          message={toastMessage}
          onClose={() => setShowToast(false)}
        />
      )}
    </div>
  );
}
export default Commande;
