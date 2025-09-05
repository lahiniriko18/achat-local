import { useState } from "react";
import {
  cleanFormData,
  validationEmail,
  validationPassword,
} from "../../utils/validation";
import InputComponent from "../../components/InputComponent";
import signUpLogo from "../../assets/sign-up.svg";
import { signUp } from "../../services/UtilisateurService";

function Sign() {
  const [formSign, setFormSign] = useState({
    nom: "",
    email: "",
    password: "",
    confirmPassword: "",
  });
  const [erreurs, setErreurs] = useState({});

  const handleSubmit = async (e) => {
    e.preventDefault();

    let nouveauErreurs = {};

    if (formSign.nom.trim().length < 3) {
      nouveauErreurs.nom = "3 caractères minimum !";
    }
    if (!validationEmail(formSign.email.trim())) {
      nouveauErreurs.email = "Email invalide !";
    }
    if (!validationPassword(formSign.password)) {
      nouveauErreurs.password = "Mot de passe invalide !";
    }
    if (!validationPassword(formSign.confirmPassword)) {
      nouveauErreurs.confirmPassword = "Mot de passe invalide !";
    } else if (
      formSign.password &&
      formSign.confirmPassword &&
      formSign.password !== formSign.confirmPassword
    ) {
      nouveauErreurs.confirmPassword =
        "Les mots de passe ne correspondent pas !";
    }

    setErreurs(nouveauErreurs);

    if (Object.keys(nouveauErreurs).length == 0) {
      try {
        const dataSign = cleanFormData(formSign, [], ["password"]);
        await signUp(dataSign);
        console.log(dataSign);
      } catch (error) {
        console.error(error);
        throw error;
      } finally {
        console.log("Mety leka");
      }
    }
  };

  return (
    <div className="h-screen w-screen flex items-center justify-center">
      <div className="flex flex-col gap-3 custom-bg p-8 rounded-xl shadow w-full m-3 lg:m-0 lg:w-2/3 text-center">
        <div className="w-full flex">
          <div className="flex-1">
            <div>
              <h1 className="font sans text-3xl text-primaire-2 font-semibold -mt-4">
                INSCRIPTION
              </h1>
            </div>
            <div className="items-center justify-center">
              <form
                onSubmit={handleSubmit}
                className="w-full flex flex-col gap-3 text-start"
              >
                <InputComponent
                  label="Nom :"
                  type="text"
                  name="nom"
                  value={formSign.nom}
                  setFormData={setFormSign}
                  placeholder="Votre nom"
                  erreur={erreurs.nom}
                  required
                />
                <InputComponent
                  label="Email :"
                  type="text"
                  name="email"
                  value={formSign.email}
                  setFormData={setFormSign}
                  placeholder="Votre email"
                  erreur={erreurs.email}
                  required
                />
                <InputComponent
                  label="Mot de passe :"
                  type="password"
                  name="password"
                  value={formSign.password}
                  setFormData={setFormSign}
                  placeholder="Votre mot de passe"
                  erreur={erreurs.password}
                  required
                />
                <InputComponent
                  label="Confirmer le mot de passe :"
                  type="password"
                  name="confirmPassword"
                  value={formSign.confirmPassword}
                  setFormData={setFormSign}
                  placeholder="Confirmer le mot de passe"
                  erreur={erreurs.confirmPassword}
                  required
                />
                <div className="flex flex-col justify-center">
                  <button
                    type="submit"
                    className="text-center w-full rounded-full bg-primaire-1 transition-all duration-500 hover:bg-primaire-2 
                    shadow-md text-theme-light  text-base font-semibold"
                  >
                    S'inscrire
                  </button>
                  <span className=" pt-2 text-center">
                    Avez-vous une compte ?{" "}
                    <a
                      href="/login"
                      className="text-sans text-base font-normal"
                    >
                      se connnecter
                    </a>
                  </span>
                </div>
              </form>
            </div>
          </div>
          <div className="flex-1 hidden md:flex justify-center items-center">
            <img src={signUpLogo} alt="" className="p-3" />
          </div>
        </div>
      </div>
    </div>
  );
}

export default Sign;
