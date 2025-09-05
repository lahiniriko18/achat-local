import {
  ChevronLeft,
  ChevronRight,
  Info,
  PlusCircleIcon,
  SquarePen,
  Trash2,
} from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { AucunElement, Chargement } from "../../components/ChargeData";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import SuccessToast from "../../components/Notification";
import TextSelectionComponent from "../../components/TextSelectionComponent";
import useCheckSelection from "../../hooks/useCheckSelection";
import useClients from "../../hooks/useClients";
import useConfirmation from "../../hooks/useConfirmation";
import { toast } from "react-toastify";
import {
  deleteClient,
  deleteMultipleClient,
} from "../../services/ClientService";
import { useSearch } from "../../store/SearchContext";

function Client() {
  const { clients, loading, fetchClients } = useClients();
  const {
    checkedIds,
    allChecked,
    nbChecked,
    handleCheck,
    handleCheckAll,
    setCheckedIds,
  } = useCheckSelection(clients, "numClient");
  const [selectedId, setSelectedId] = useState(null);
  const { searchTerm } = useSearch();
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(6);
  const location = useLocation();
  const navigate = useNavigate();
  const { showConfirmation, setShowConfirmation, hideModal, confirmation } =
    useConfirmation();
  const filteredData = clients.filter(
    (item) =>
      item.numClient
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      item.nom.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.contact.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.adresse.toLowerCase().includes(searchTerm.toLowerCase())
  );
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredData.slice(indexOfFirstItem, indexOfLastItem);
  const handleDeleteClient = async () => {
    try {
      await deleteClient(selectedId);
      setShowConfirmation(false);
      setSelectedId(null);
      fetchClients();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
    }
  };
  const handleDeleteMultipleClient = async () => {
    try {
      const formData = new FormData();
      checkedIds.forEach((id) => {
        formData.append("numClients", id);
      });
      await deleteMultipleClient(formData);
      setShowConfirmation(false);
      setSelectedId(null);
      setCheckedIds([]);
      fetchClients();
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      toast.success("Suppression avec succès", {
        className: "custom-toast",
      });
    }
  };
  const handleModifier = (client) => {
    navigate(`/client/modifier/${client.numClient}`, {
      state: { client },
    });
  };
  const handleDetails = (client) => {
    navigate(`/client/details/${client.numClient}`, {
      state: { client, clients },
    });
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
    <div className="flex flex-col h-full p-3 overflow-auto">
      <h2 className="font-semibold  text-2xl">Client</h2>
      <div className="flex-1 flex flex-col py-2 px-2">
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
              className="outline-none custom-bg custom-border rounded px-2 py-1 text-sm"
            >
              {[5, 6, 10, 25, 50, 100].map((n) => (
                <option key={n} value={n}>
                  {n}
                </option>
              ))}
              <option value={clients.length}>Tous</option>
            </select>
          </div>
          <Link to="/Client/ajouter">
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
        ) : filteredData.length == 0 ? (
          <div className="flex-1 flex justify-center items-center">
            <AucunElement text="Aucun Client" />
          </div>
        ) : (
          <div className="flex w-full flex-1 flex-col">
            <div className="flex flex-1 rounded-md">
              <div className="rounded-md w-full overflow-auto">
                <table className="w-full shadow-md rounded">
                  <thead className="text-base leading-normal custom-border-b">
                    <tr>
                      <th className="px-6 text-left">
                        <input
                          type="checkbox"
                          onChange={() => handleCheckAll()}
                          checked={allChecked}
                          className="form-checkbox w-5 h-5 rounded text-primaire cursor-pointer bg-white focus:ring-0"
                        />
                      </th>
                      <th className="py-3 px-6 text-left">Numéro</th>
                      <th className="py-3 px-6 text-left">Nom</th>
                      <th className="py-3 px-6 text-left">Contact</th>
                      <th className="py-3 px-6 text-left">Adresse</th>
                      <th className="py-3 px-6 text-center">Actions</th>
                    </tr>
                  </thead>
                  <tbody className=" text-base ">
                    {currentItems.map((client, index) => (
                      <tr
                        key={index}
                        className={`custom-border-b custom-hover
                        ${
                          checkedIds.includes(client.numClient)
                            ? "custom-bg-low"
                            : ""
                        }`}
                      >
                        <td className="py-3 px-6">
                          <input
                            onChange={() => handleCheck(client.numClient)}
                            checked={checkedIds.includes(client.numClient)}
                            type="checkbox"
                            className="form-checkbox text-primaire w-5 h-5 rounded focus:ring-0 cursor-pointer"
                          />
                        </td>
                        <td className="py-3 px-6">{client.numClient}</td>
                        <td className="py-3 px-6">{client.nom}</td>
                        <td className="py-3 px-6">{client.contact}</td>
                        <td className="py-3 px-6">{client.adresse}</td>
                        <td className="py-3 px-6">
                          <div className="flex justify-center space-x-4">
                            <Trash2
                              onClick={() => {
                                confirmation();
                                setSelectedId(client.numClient);
                              }}
                              className="w-5 h-5 text-red-500 cursor-pointer transition-all hover:scale-105"
                            />
                            <SquarePen
                              onClick={() => handleModifier(client)}
                              className="w-5 h-5 cursor-pointer transition-all hover:scale-105"
                            />
                            <Info
                              onClick={() => handleDetails(client)}
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
                Page {currentPage} sur {totalPages}
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
              ? handleDeleteMultipleClient
              : handleDeleteClient
          }
          text={
            checkedIds.includes(selectedId)
              ? "Etes-vous sûre de supprimmer tous ces clients sélectionnés"
              : "Etes-vous sûre de supprimmer cet client?"
          }
        />
      )}
    </div>
  );
}
export default Client;
