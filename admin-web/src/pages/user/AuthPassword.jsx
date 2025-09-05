import { useState } from "react";
import InputComponent from "../../components/InputComponent";
import { MoveLeft } from "lucide-react";
import { Link, useNavigate, useParams } from "react-router-dom";
import {
  verifyPassword,
  validationCode,
} from "../../services/UtilisateurService";

function AuthPassword() {
  const [formData, setFormData] = useState({
    password: "",
  });
  const [errors, setErrors] = useState("");
  const navigate = useNavigate();
  const { action } = useParams();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await verifyPassword(formData.password);
      const dataCode = await validationCode();
      localStorage.setItem("code", dataCode.code);
      console.log(
        localStorage.getItem("code"),
        dataCode.code,
        dataCode.message
      );
      navigate(`/profile/${action}`);
    } catch (err) {
      setErrors(err.error);
    }
  };

  return (
    <div className="flex h-full justify-center items-center px-4">
      <form
        onSubmit={handleSubmit}
        className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 custom-bg shadow-md rounded-lg p-6 space-y-4"
      >
        <div className="relative flex justify-center">
          <Link to="/profile">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            Mot de passe
          </h2>
        </div>
        <input type="hidden" />
        <InputComponent
          label="Mot de passe"
          type="password"
          name="password"
          value={formData.password}
          setFormData={setFormData}
          required
          placeholder="Votre mot de passe"
          erreur={errors}
        />
        <div className="text-center pt-3">
          <button
            type="submit"
            className="bg-primaire-1 hover:bg-primaire-2 sm:w-1/2 text-theme-light font-semibold px-6 py-2 rounded-md transition duration-200"
          >
            Suivant
          </button> 
        </div>
      </form>
    </div>
  );
}

export default AuthPassword;
