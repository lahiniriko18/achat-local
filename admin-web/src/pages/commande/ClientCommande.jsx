import { useState } from "react";
import { cleanFormData, validationPhone } from "../../utils/validation";
import InputComponent from "../../components/InputComponent";
import { Link } from "react-router-dom";

function ClientCommande({ client, setClient }) {
  const [erreurs, setErreurs] = useState({});

  const handleSubmit = async (e) => {
    e.preventDefault();
    let donneeClient = new FormData();
    let nouveauErreurs = {};
    if (!client.nom.trim()) {
      nouveauErreurs.nom = "required";
    } else if (client.nom.trim().length < 3) {
      nouveauErreurs.nom = "Au moins 3 caracères!";
    }
    if (client.contact.trim() && !validationPhone(client.contact.trim())) {
      nouveauErreurs.contact = "Contact invalide!";
    }
    setErreurs(nouveauErreurs);
    if (Object.keys(nouveauErreurs).length == 0) {
      donneeClient = cleanFormData(client);
      setClient(donneeClient);
    }
  };

  return (
    <div className="flex h-full justify-center items-center px-4">
      <form
        onSubmit={handleSubmit}
        className="w-full lg:w-1/2 md:w-2/3 bg-white shadow rounded-lg px-6 pt-6 space-y-4"
      >
        <div className="relative group flex justify-center">
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            Ajouter une client
          </h2>
        </div>
        <InputComponent
          label="Nom du client"
          type="text"
          name="nom"
          value={client.nom}
          setFormData={setClient}
          placeholder="Ex: Lahiniriko"
          erreur={erreurs.nom}
        />
        <InputComponent
          label="Contact"
          type="text"
          name="contact"
          value={client.contact}
          setFormData={setClient}
          placeholder="Ex: +261 34 00 000 00"
          erreur={erreurs.contact}
        />
        <InputComponent
          label="Adresse"
          type="text"
          name="adresse"
          value={client.adresse}
          setFormData={setClient}
          placeholder="Ex: Isada"
          erreur={erreurs.adresse}
        />
        <div className="w-full h-10 mb-2">
          <div className="flex justify-end gap-3 px-2 text-white font-sans">
            <Link to=".." className="text-white h-10">
              <button className="h-10 bg-gray-500 transition-all duration-300 hover:bg-gray-600 flex justify-center items-center">
                Précedent
              </button>
            </Link>
            <Link to="../verifier" className="text-white">
              <button className="bg-primaire-1 h-10 transition-all duration-300 hover:bg-primaire-2 flex justify-center items-center">
                Suivant
              </button>
            </Link>
          </div>
        </div>
      </form>
    </div>
  );
}

export default ClientCommande;
