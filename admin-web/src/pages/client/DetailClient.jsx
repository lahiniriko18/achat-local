import { Link, useParams } from "react-router-dom";
import { MoveLeft, ChevronLeft, ChevronRight } from "lucide-react";
import { useState, useEffect } from "react";
import { getClientById } from "../../services/ClientService";

function DetailClient() {
  const { numClient } = useParams();
  const [client, setClient] = useState({});

  const chargeClient = async () => {
    try {
      const c = await getClientById(numClient);
      setClient(c);
    } catch (e) {
      console.error("Erreur :" + e);
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
      <div className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 bg-white shadow-md rounded-lg p-6 space-y-4">
        <div className="relative group flex justify-center">
          <Link to="/client">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-2 ml-3 sm:ml-0">
            Détails du client {client.nom}
          </h2>
        </div>
        <div className="relative flex flex-col w-full justify-center items-center">
          <div className="flex flex-col gap-3 font-sans">
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
          <div className="relative sm:absolute flex w-full h-full justify-center items-center">
            <div className="flex w-full justify-evenly pt-3 sm:justify-between">
              <ChevronLeft
                size={35}
                className="text-gray-500 cursor-pointer transition-all duration-300 hover:scale-105"
              />
              <ChevronRight
                size={35}
                className="text-gray-500 cursor-pointer transition-all duration-300 hover:scale-105"
              />
            </div>
          </div>
        </div>
        <div className="w-full flex justify-center">
          <div className="flex w-full flex-col sm:flex-row justify-center text-white gap-2 mt-4">
            <button className="h-10 bg-red-500 hover:bg-red-600 border-0 transition-all duration-300 flex justify-center items-center">
              Supprimer
            </button>
            <button className="bg-gray-500 h-10 transition-all duration-300 border-0 hover:bg-gray-600 flex justify-center items-center">
              Modifier
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default DetailClient;
