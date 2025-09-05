import {
  ChevronLeft,
  ChevronRight,
  Info,
  PlusCircleIcon,
  Trash2,
} from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { toast } from "react-toastify";
import { AucunElement, Chargement } from "../../components/ChargeData";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import TextSelectionComponent from "../../components/TextSelectionComponent";
import useCheckSelection from "../../hooks/useCheckSelection";
import useCommandes from "../../hooks/useCommandes";
import {
  deleteCommande,
  deleteMultipleCommande,
} from "../../services/CommandeService";
import { totalMontantCommande } from "../../utils/produitUtils";

function Commande() {
  const { commandes, loading, fetchCommandes } = useCommandes();
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
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
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
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
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
      toast.success(location.state.successMessage, {
        className: "custom-toast",
      });
      window.history.replaceState({}, document.title, window.location.pathname);
    }
  }, [location]);
  return (
    <div className="flex h-full p-3 flex-col overflow-auto">
      <h2 className="font-semibold  text-2xl">Commande</h2>
      <div className="flex-1 flex flex-col mt-3 py-2 px-2">
        <div className="flex justify-between items-center">
          <div className="flex gap-2 items-center">
            <label
              htmlFor=""
              className="font-medium text-base ms-0  hidden sm:block"
            >
              Lignes :
            </label>
            <select
              value={itemsPerPage}
              onChange={(e) => setItemsPerPage(e.target.value)}
              className="custom-border custom-bg outline-none rounded px-2 py-1 text-sm"
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
              className="bg-primaire-2 text-theme-light rounded-md
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
                <table className="w-full  shadow-md rounded">
                  <thead className="text-base leading-normal border-b">
                    <tr>
                      <th className="px-6 text-left">
                        <input
                          type="checkbox"
                          onChange={() => handleCheckAll()}
                          checked={allChecked}
                          className="form-checkbox w-5 h-5 rounded text-primaire cursor-pointer focus:ring-0"
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
                  <tbody className=" text-base ">
                    {currentItems.map((commande, index) => (
                      <tr
                        key={index}
                        className={`custom-border-b custom-hover
                        ${
                          checkedIds.includes(commande.numCommande)
                            ? "custom-bg-low"
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
                className="px-2 py-2 custom-bg-low
                 rounded-full border-0 transition-all cursor-pointer hover:scale-105"
                disabled={currentPage === 1}
              >
                <ChevronLeft />
              </button>
              <span className=" text-base">
                Page {currentPage} par {totalPages}
              </span>
              <button
                onClick={() =>
                  setCurrentPage((prev) => Math.min(prev + 1, totalPages))
                }
                className="px-2 py-2 custom-bg-low cursor-pointer rounded-full 
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
    </div>
  );
}
export default Commande;
