import React from "react";
import { useState,useEffect } from "react";
import { MoveLeft } from "lucide-react";
import { Link, useNavigate, useParams, useLocation } from "react-router-dom";
import InputComponent from "../../components/InputComponent";
import { validationPhone } from "../../utils/validation";
import { addClient, updateClient,getClientById } from "../../services/ClientService";
import { cleanFormData } from "../../utils/validation";

function FormulaireClient() {
  const [formData, setFormData] = useState({
    numClient: "",
    nom: "",
    contact: "",
    adresse: "",
  });
  const [erreurs, setErreurs] = useState({});
  const { numClient } = useParams();
  const navigate = useNavigate();
  const location = useLocation();
  const isEdit = !!numClient;

  const handleSubmit = async (e) => {
    e.preventDefault();
    let donneeClient = new FormData();
    let nouveauErreurs = {};
    if (!formData.nom.trim()) {
      nouveauErreurs.nom = "required";
    } else if (formData.nom.trim().length < 3) {
      nouveauErreurs.nom = "Au moins 3 caracères!";
    }
    if (formData.contact.trim() && !validationPhone(formData.contact.trim())) {
      nouveauErreurs.contact = "Contact invalide!";
    }
    setErreurs(nouveauErreurs);
    if (Object.keys(nouveauErreurs).length == 0) {
      donneeClient = cleanFormData(formData);
      try {
        isEdit
          ? await updateClient(donneeClient, numClient)
          : await addClient(donneeClient);
        navigate("/client", {
          state: {
            successMessage: isEdit
              ? "Client modifié avec succès !"
              : "Client ajoutée avec succès !",
          },
        });
      } catch (erreur) {
        console.error(erreur);
      }
    }
  };
  useEffect(() => {
    if (isEdit) {
      if (location.state?.client) {
        setFormData(location.state.client);
      } else {
        getClientById(numClient)
          .then((data) => setFormData(data))
          .catch((error) => console.error(error));
      }
    }
  }, [numClient, location.state]);
  return (
    <div className="flex h-full justify-center items-center px-4">
      <form
        onSubmit={handleSubmit}
        className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 bg-white shadow-md rounded-lg p-6 space-y-4"
      >
        <div className="relative group flex justify-center">
          <Link to="/client">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            {isEdit ? "Modifier une client" : "Ajouter une nouvelle client"}
          </h2>
        </div>
        <InputComponent
          label="Nom du client"
          type="text"
          name="nom"
          value={formData.nom}
          setFormData={setFormData}
          placeholder="Ex: Lahiniriko"
          erreur={erreurs.nom}
        />
        <InputComponent
          label="Contact"
          type="text"
          name="contact"
          value={formData.contact}
          setFormData={setFormData}
          placeholder="Ex: +261 34 00 000 00"
          erreur={erreurs.contact}
        />
        <InputComponent
          label="Adresse"
          type="text"
          name="adresse"
          value={formData.adresse}
          setFormData={setFormData}
          placeholder="Ex: Isada"
          erreur={erreurs.adresse}
        />
        <div className="text-center">
          <button
            type="submit"
            className="bg-primaire-1 hover:bg-primaire-2 sm:w-1/2 text-white font-semibold px-6 py-2 rounded-md transition duration-200"
          >
            Enregistrer
          </button>
        </div>
      </form>
    </div>
  );
}

export default FormulaireClient;
