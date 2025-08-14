import { useState, useEffect } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import Modal from "../../components/Modal";
import Confirmation from "../../components/Confirmation";
import SuccessToast from "../../components/Notification";
import useCategories from "../../hooks/useCategories";
import useCheckSelection from "../../hooks/useCheckSelection";
import TextSelectionComponent from "../../components/TextSelectionComponent";
import {
  deleteCategorie,
  deleteMultipleCategorie,
} from "../../services/CategorieService";
import { AucunElement, Chargement } from "../../components/ChargeData";
import {
  Trash2,
  SquarePen,
  Info,
  ChevronLeft,
  ChevronRight,
  PlusCircleIcon,
} from "lucide-react";
import { useSearch } from "../../store/SearchContext";

function Categorie() {
  const { categories, loading, error, fetchCategories } = useCategories();
  const {
    checkedIds,
    allChecked,
    nbChecked,
    handleCheck,
    handleCheckAll,
    setCheckedIds,
  } = useCheckSelection(categories, "numCategorie");

  const [selectedId, setSelectedId] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(6);
  const { searchTerm } = useSearch();
  const location = useLocation();
  const navigate = useNavigate();
  const [showToast, setShowToast] = useState(false);
  const [toastMessage, setToastMessage] = useState("");
  const [showConfirmation, setShowConfirmation] = useState(false);
  const filteredData = categories.filter(
    (item) =>
      item.numCategorie
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      item.nomCategorie.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.descCategorie.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);
  const handleDeleteCategorie = async () => {
    try {
      await deleteCategorie(selectedId);
      setShowConfirmation(false);
      setSelectedId(null);
      fetchCategories();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      setShowToast(true);
      setToastMessage("Suppression avec succès");
    }
  };
  const handleDeleteMultipleCategorie = async () => {
    try {
      const formData = new FormData();
      checkedIds.forEach((id) => {
        formData.append("numCategories", id);
      });
      await deleteMultipleCategorie(formData);
      setShowConfirmation(false);
      setSelectedId(null);
      setCheckedIds([]);
      fetchCategories();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      setShowToast(true);
      setToastMessage("Suppression avec succès");
    }
  };
  const handleModifier = (categorie) => {
    navigate(`/categorie/modifier/${categorie.numCategorie}`, {
      state: { categorie },
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
      setToastMessage(location.state.successMessage);
      setShowToast(true);
      window.history.replaceState({}, document.title);
    }
  }, [location.state]);
  return (
    <div className="flex h-full flex-col p-3 overflow-auto">
      <h2 className="font-semibold font-sans text-2xl">Catégorie</h2>
      <div className="flex-1 flex flex-col py-2 px-2">
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
              <option value={categories.length}>Tous</option>
            </select>
          </div>
          <Link to="/categorie/ajouter">
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
        ) : categories.length == 0 ? (
          <div className="flex-1 flex justify-center items-center">
            <AucunElement text="Aucun Categorie" />
          </div>
        ) : (
          <div className="flex w-full flex-1 flex-col">
            <div className="flex flex-1 rounded-md">
              <div className="rounded-md w-full overflow-auto">
                <table className="min-w-full bg-white shadow-md rounded">
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
                      <th className="py-3 px-6 text-left">Image</th>
                      <th className="py-3 px-6 text-left">Nom du catégorie</th>
                      <th className="py-3 px-6 text-left">
                        Nombre des produits
                      </th>
                      <th className="py-3 px-6 text-left">Description</th>
                      <th className="py-3 px-6 text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="text-gray-700 text-base font-sans">
                    {currentItems.map((categorie, index) => (
                      <tr
                        key={index}
                        className={`border-b hover:bg-gray-50 
                        ${
                          checkedIds.includes(categorie.numCategorie)
                            ? "bg-gray-50"
                            : ""
                        }`}
                      >
                        <td className="py-2 px-6">
                          <input
                            onChange={() => handleCheck(categorie.numCategorie)}
                            checked={checkedIds.includes(
                              categorie.numCategorie
                            )}
                            type="checkbox"
                            className="form-checkbox text-primaire w-5 h-5 rounded focus:ring-0 cursor-pointer"
                          />
                        </td>
                        <td className="py-2 px-6">{categorie.numCategorie}</td>
                        <td className="py-2 px-6 text-center">
                          <img
                            className="w-10 h-10 rounded-full"
                            src={categorie.imageCategorie}
                            alt=""
                          />
                        </td>
                        <td className="py-2 px-6">{categorie.nomCategorie}</td>
                        <td className="py-2 px-6">
                          {categorie.produits.length}
                        </td>
                        <td className="py-2 px-6">{categorie.descCategorie}</td>
                        <td className="py-2 px-6">
                          <div className="flex justify-center space-x-4">
                            <Trash2
                              onClick={() =>
                                confirmation(categorie.numCategorie)
                              }
                              className="w-5 h-5 text-red-500 cursor-pointer transition-all hover:scale-105"
                            />
                            <SquarePen
                              onClick={() => handleModifier(categorie)}
                              className="w-5 h-5 cursor-pointer transition-all hover:scale-105"
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
              ? handleDeleteMultipleCategorie
              : handleDeleteCategorie
          }
          text={
            checkedIds.includes(selectedId)
              ? "Etes-vous sûre de supprimmer tous ces catégories sélectionnés"
              : "Etes-vous sûre de supprimmer cet catégorie?"
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
export default Categorie;
