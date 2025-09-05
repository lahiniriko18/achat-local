import { useState } from "react";
import InputComponent from "../../components/InputComponent";
import { useNavigate } from "react-router-dom";
import { signIn } from "../../services/UtilisateurService";
import signInLogo from "../../assets/sign-in.svg";
import { useEffect } from "react";

function Login() {
  const [formLogin, setFormLogin] = useState({ username: "", mdp: "" });
  const [erreurs, setErreurs] = useState({});
  const navigate = useNavigate();

  const envoyerFormulaire = async (e) => {
    e.preventDefault();

    let nouveauErreurs = {};

    if (!formLogin.username)
      nouveauErreurs.username = "Cette champ est obligatoire !";
    if (!formLogin.mdp) nouveauErreurs.mdp = "Cette champ est obligatoire !";

    setErreurs(nouveauErreurs);
    if (Object.keys(nouveauErreurs).length == 0) {
      try {
        await signIn(formLogin.username, formLogin.mdp);
        navigate("/");
      } catch (err) {
        console.log(err);
        nouveauErreurs.mdp = err.error;
        setErreurs(nouveauErreurs);
      }
    }
  };

  useEffect(() => {
    localStorage.removeItem("itemOpen");
  }, []);

  return (
    <div className="custom-bg flex flex-col gap-2 p-8 rounded-xl shadow w-full m-3 lg:m-0 lg:w-2/3 text-center">
      <div className="flex w-full py-2">
        <div className="flex-1">
          <div className="mb-3">
            <h1 className=" text-3xl text-primaire-2 font-semibold -mt-4">
              CONNEXION
            </h1>
          </div>
          <div className="items-center justify-center">
            <form
              onSubmit={envoyerFormulaire}
              className="w-full flex flex-col gap-3 text-start"
            >
              <InputComponent
                label="Nom d'utilisteur :"
                type="text"
                name="username"
                value={formLogin.username}
                setFormData={setFormLogin}
                placeholder="Votre nom"
                erreur={erreurs.username}
              />
              <InputComponent
                label="Mot de passe :"
                type="password"
                name="mdp"
                value={formLogin.mdp}
                setFormData={setFormLogin}
                placeholder="Votre mot de passe"
                erreur={erreurs.mdp}
              />
              <div className="mt-2 flex flex-col w-full justify-center">
                <span className="text-end pb-2 cursor-pointer text-primaire-2">
                  Mot de passe oublié ?
                </span>
                <button
                  type="submit"
                  className="text-center w-full rounded-full bg-primaire-1 transition-all duration-500 hover:bg-primaire-2 
                  shadow-md text-theme-light  text-base font-semibold"
                >
                  Se connecter
                </button>
                <span className=" pt-2 text-center">
                  Vous n'avez pas une compte ?{" "}
                  <a href="/sign" className="text-sans text-base font-normal">
                    s'inscrire
                  </a>
                </span>
              </div>
            </form>
          </div>
        </div>
        <div className="flex-1 hidden md:flex justify-center items-center">
          <img src={signInLogo} alt="" className="p-3" />
        </div>
      </div>
    </div>
  );
}

export default Login;
