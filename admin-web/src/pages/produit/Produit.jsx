import {
  ChevronLeft,
  ChevronRight,
  Info,
  PlusCircleIcon,
  SquarePen,
  Trash2,
} from "lucide-react";
import { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { toast } from "react-toastify";
import { AucunElement, Chargement } from "../../components/ChargeData";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import TextSelectionComponent from "../../components/TextSelectionComponent";
import useCheckSelection from "../../hooks/useCheckSelection";
import { useProduits } from "../../hooks/useProduits";
import {
  deleteMultipleProduit,
  deleteProduit,
} from "../../services/ProduitService";
import { useSearch } from "../../store/SearchContext";

function Produit() {
  const { produits, loading, fetchProduits } = useProduits();
  const {
    checkedIds,
    allChecked,
    nbChecked,
    handleCheck,
    handleCheckAll,
    setCheckedIds,
  } = useCheckSelection(produits, "numProduit");
  const [selectedId, setSelectedId] = useState(null);
  const { searchTerm } = useSearch();
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(6);
  const location = useLocation();
  const navigate = useNavigate();
  const [showConfirmation, setShowConfirmation] = useState(false);
  const filteredData = produits.filter(
    (item) =>
      item.libelleProduit.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.quantite
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      item.prixUnitaire
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      item.uniteMesure.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);
  const handleDeleteProduit = async () => {
    try {
      await deleteProduit(selectedId);
      setShowConfirmation(false);
      setSelectedId(null);
      fetchProduits();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
    }
  };
  const handleDeleteMultipleProduit = async () => {
    try {
      const formData = new FormData();
      checkedIds.forEach((id) => {
        formData.append("numProduits", id);
      });
      await deleteMultipleProduit(formData);
      setShowConfirmation(false);
      setSelectedId(null);
      setCheckedIds([]);
      fetchProduits();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
    }
  };
  const handleModifier = (produit) => {
    navigate(`/produit/modifier/${produit.numProduit}`, {
      state: { produit },
    });
  };
  const handleDetails = (produit) => {
    navigate(`/produit/details/${produit.numProduit}`, {
      state: { produit },
    });
  };
  const hideModal = () => {
    setShowConfirmation(false);
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
      <h2 className="font-semibold  text-2xl">Produit</h2>
      <div className="flex-1 flex flex-col py-2 px-2">
        <div className="flex justify-between items-center">
          <div className="flex gap-2 items-center">
            <label
              htmlFor=""
              className="font-medium text-base ms-0 hidden sm:block"
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
              <option value={produits.length}>Tous</option>
            </select>
          </div>
          <button
            onClick={() => navigate("/produit/ajouter")}
            className="bg-primaire-2 rounded-md text-theme-light
           h-10 text-center flex gap-2 items-center mb-2"
          >
            <PlusCircleIcon />
            <span>Ajouter</span>
          </button>
        </div>

        {loading ? (
          <div className="flex-1 flex justify-center items-center">
            <Chargement />
          </div>
        ) : filteredData.length == 0 ? (
          <div className="flex-1 flex justify-center items-center">
            <AucunElement text="Aucun produit" />
          </div>
        ) : (
          <div className="flex w-full flex-1 flex-col">
            <div className="flex flex-1 rounded-md">
              <div className="rounded-md w-full overflow-auto">
                <table className="w-full custom-bg shadow-md rounded">
                  <thead className="text-base leading-normal custom-border-b">
                    <tr>
                      <th className="px-6 text-left">
                        <input
                          type="checkbox"
                          onChange={() => handleCheckAll()}
                          checked={allChecked}
                          className="form-checkbox w-5 h-5 rounded text-primaire cursor-pointer custom-bg focus:ring-0"
                        />
                      </th>
                      <th className="py-3 px-6 text-left">Numéro</th>
                      <th className="py-3 px-6 text-left">Images</th>
                      <th className="py-3 px-6 text-left">Libellé</th>
                      <th className="py-3 px-6 text-left">Quantité</th>
                      <th className="py-3 px-6 text-left">Prix unitaire</th>
                      <th className="py-3 px-6 text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="text-base ">
                    {currentItems.map((produit, index) => (
                      <tr
                        key={index}
                        className={`custom-border-b custom-hover
                        ${
                          checkedIds.includes(produit.numProduit)
                            ? "custom-bg-low"
                            : ""
                        }`}
                      >
                        <td className="py-2 px-6">
                          <input
                            onChange={() => handleCheck(produit.numProduit)}
                            checked={checkedIds.includes(produit.numProduit)}
                            type="checkbox"
                            className="form-checkbox text-primaire w-5 h-5 rounded focus:ring-0 cursor-pointer"
                          />
                        </td>
                        <td className="py-2 px-6">{produit.numProduit}</td>
                        <td className="py-2 px-6">
                          <div className="relative w-10 h-10">
                            {produit.images && produit.images.length > 0 && (
                              <>
                                <img
                                  src={produit.images[0].nomImage}
                                  alt="Produit"
                                  className="absolute top-0 left-0 w-full h-full object-cover rounded-full shadow z-10"
                                />
                                {produit.images[1] && (
                                  <img
                                    src={produit.images[1].nomImage}
                                    alt="Produit secondaire"
                                    className="absolute -bottom-1 left-2 w-full h-full object-cover rounded-full z-0"
                                  />
                                )}
                              </>
                            )}
                          </div>
                        </td>
                        <td className="py-2 px-6">{produit.libelleProduit}</td>
                        <td className="py-2 px-6">
                          {produit.quantite} {produit.uniteMesure}
                        </td>
                        <td className="py-2 px-6">{produit.prixUnitaire}</td>
                        <td className="py-2 px-6">
                          <div className="flex justify-center space-x-4">
                            <Trash2
                              onClick={() => confirmation(produit.numProduit)}
                              className="w-5 h-5 text-red-500 cursor-pointer transition-all hover:scale-105"
                            />
                            <SquarePen
                              onClick={() => handleModifier(produit)}
                              className="w-5 h-5 cursor-pointer transition-all hover:scale-105"
                            />
                            <Info
                              onClick={() => handleDetails(produit)}
                              className="w-5 h-5 text-primaire-2 cursor-pointer transition-all hover:scale-105"
                            />
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
              ? handleDeleteMultipleProduit
              : handleDeleteProduit
          }
          text={
            checkedIds.includes(selectedId)
              ? "Etes-vous sûre de supprimmer tous ces produits sélectionnés"
              : "Etes-vous sûre de supprimmer cet produit?"
          }
        />
      )}
    </div>
  );
}
export default Produit;
