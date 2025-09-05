import { MoveLeft } from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { getClientById } from "../../services/ClientService";
import { deleteClient } from "../../services/ClientService";
import Confirmation from "../../components/Confirmation";
import Modal from "../../components/Modal";
import useConfirmation from "../../hooks/useConfirmation";

function DetailClient() {
  const { numClient } = useParams();
  const [client, setClient] = useState({});
  const navigate = useNavigate();
  const { showConfirmation, setShowConfirmation, hideModal, confirmation } =
    useConfirmation();

  const chargeClient = async () => {
    try {
      const c = await getClientById(numClient);
      setClient(c);
    } catch (e) {
      console.error("Erreur :" + e);
    }
  };
  const handleModifier = () => {
    navigate(`/client/modifier/${client.numClient}`, {
      state: { client },
    });
  };
  const handleDeleteClient = async () => {
    try {
      await deleteClient(client.numClient);
      setShowConfirmation(false);
    } catch (error) {
      alert("Erreur de la suppression " + error);
    } finally {
      navigate("/client", {
        state: { successMessage: "Client supprimé avec succès!" },
      });
    }
  };
  useEffect(() => {
    if (location.state?.client) {
      setClient(location.state.client);
    } else {
      chargeClient();
    }
  }, [numClient]);

  return (
    <div className="flex h-full justify-center items-center px-4">
      <div className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 custom-bg shadow-md rounded-lg p-6 space-y-4">
        <div className="relative group flex justify-center">
          <Link to="/client">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-2 ml-3 sm:ml-0">
            Détails du client {client.nom}
          </h2>
        </div>
        <div className="relative flex flex-col w-full justify-center items-center">
          <div className="flex flex-col gap-3">
            <div className="flex gap-2">
              <b className="text-nowrap">Identifiant :</b>
              <span>{client.numClient}</span>
            </div>
            <div className="flex gap-2">
              <b className="text-nowrap">Nom :</b>
              <span>{client.nom}</span>
            </div>
            <div className="flex gap-2">
              <b className="text-nowrap">Contact :</b>
              <span>{client.contact}</span>
            </div>
            <div className="flex gap-2">
              <b className="text-nowrap">Adresse :</b>
              <span>{client.adresse}</span>
            </div>
          </div>
        </div>
        <div className="w-full flex justify-center">
          <div className="flex w-full flex-col sm:flex-row justify-center text-theme-light gap-2 mt-4">
            <button
              onClick={() => handleModifier()}
              className="bg-gray-500 h-10 transition-all duration-300 border-0 hover:bg-gray-600 flex justify-center items-center"
            >
              Modifier
            </button>
            <button
              onClick={() => confirmation()}
              className="h-10 bg-red-500 hover:bg-red-600 border-0 transition-all duration-300 flex justify-center items-center"
            >
              Supprimer
            </button>
          </div>
        </div>
      </div>
      {showConfirmation && <Modal action={hideModal} />}
      {showConfirmation && (
        <Confirmation
          closeAction={hideModal}
          confirmAction={handleDeleteClient}
          text="Etes-vous sûre de supprimmer cet produit?"
        />
      )}
    </div>
  );
}

export default DetailClient;
