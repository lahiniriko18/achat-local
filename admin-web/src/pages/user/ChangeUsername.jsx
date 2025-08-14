import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { MoveLeft } from "lucide-react";
import InputComponent from "../../components/InputComponent";
import { changeUsername } from "../../services/UtilisateurService";
import { useUser } from "../../store/UserContext";

function ChangeUsername() {
  const [formData, setFormData] = useState({
    username: "",
    validationCode: "",
  });
  const [errors, setErrors] = useState({});
  const navigate = useNavigate();
  const { setUser } = useUser();

  const handleSubmit = async (e) => {
    e.preventDefault();
    let newErrors = {};
    if (formData.username.trim().length < 3) {
      newErrors.username = "3 caractères minimum";
    }
    setErrors(newErrors);
    if (Object.keys(newErrors).length == 0) {
      try {
        const data = await changeUsername(formData.username);
        setUser(data);
        navigate("/profile");
      } catch (err) {
        console.error(err.error);
      }
    }
  };

  return (
    <div className="flex h-full justify-center items-center px-4">
      <form
        onSubmit={handleSubmit}
        className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 bg-white shadow-md rounded-lg p-6 space-y-4"
      >
        <div className="relative flex flex-col justify-center items-center">
          <Link to="..">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            Réinitialiser le mot de passe
          </h2>
          <div
            className="border rounded-md p-1 text-sm text-gray-500 
          flex flex-col w-full"
          >
            <p className="font-sans text-center ">
              Votre code validation a été envoyé par votre email. Vérifier le
              puis saisir pour réinitialiser votre mot de passe
            </p>
            <p className="w-full text-center pt-2 font-sans">
              Vous n'avez pas reçu le code ?
              <span className="text-blue-500 cursor-pointer pl-2">
                Renvoyer
              </span>
            </p>
          </div>
        </div>
        <InputComponent
          label="Code de validation"
          type="text"
          name="validationCode"
          value={formData.validationCode}
          setFormData={setFormData}
          required
          placeholder="Code à 6 chiffre"
          erreur={errors.validationCode}
        />
        <InputComponent
          label="Nouvelle nom d'utilisateur"
          type="text"
          name="username"
          value={formData.username}
          setFormData={setFormData}
          required
          placeholder="Nouvelle nom d'utilisateur"
          erreur={errors.username}
        />
        <div className="flex items-center flex-col text-center mt-4">
          <button
            type="submit"
            className="bg-primaire-1 hover:bg-primaire-2 sm:w-1/2 text-white font-semibold 
            px-6 py-2 rounded-md transition duration-200"
          >
            Enregistrer
          </button>
        </div>
      </form>
    </div>
  );
}

export default ChangeUsername;
