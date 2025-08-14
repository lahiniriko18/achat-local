import defaultUser from "../../assets/user.png";
import { User2, PhoneIcon, MapPin, Mail } from "lucide-react";
import { logout } from "../../services/UtilisateurService";
import { useNavigate, Link } from "react-router-dom";
import { useUser } from "../../store/UserContext";

function Profile() {
  const { user } = useUser();
  const navigate = useNavigate();

  const handleLogout = async () => {
    await logout();
    navigate("/login");
  };

  const handleModifier = () => {
    navigate("/profile/modifier");
  };

  const handleAuthPassword = (action) => {
    navigate(`/profile/auth-password/${action}`);
  };

  return (
    <div className="flex flex-col h-full w-full p-4 overflow-auto">
      <h2 className="font-bold text-gray-700 font-sans text-2xl">Profile</h2>
      <div className="mt-3 flex flex-col w-full">
        <div className="flex w-full gap-4 h-32 items-center">
          <div className="w-32 h-32">
            <img
              src={user.image ?? defaultUser}
              alt="user"
              className="w-full h-full object-cover rounded-full"
            />
          </div>
          <ul className="text-gray-700">
            <li className="text-2xl font-bold">{user.username}</li>
            <li className="font-semibold text-lg">{user.type ?? "Admin"}</li>
            <li>{user.adresse}</li>
          </ul>
        </div>
      </div>
      <div className="flex flex-col w-full mt-4">
        <h2 className="font-bold text-gray-700 font-sans text-xl">
          Informations personnelles
        </h2>
        <div className="flex w-full flex-col gap-2 py-3">
          <div className="flex justify-between items-center border-b-2 py-2 text-gray-700">
            <div className="flex flex-1 items-center gap-2 text-gray-600">
              <User2 size={20} className="mr-3 sm:mr-0" />
              <span className="hidden sm:flex">Nom complet</span>
            </div>
            <span className="flex-1 break-words overflow-hidden text-wrap">
              {user.first_name} {user.last_name}
            </span>
          </div>

          <div className="flex w-full justify-between items-center border-b-2 py-2 text-gray-700">
            <div className="flex flex-1 items-center gap-2 text-gray-600">
              <Mail size={20} className="mr-3 sm:mr-0" />
              <span className="hidden sm:flex">Email</span>
            </div>
            <span className="flex-1 break-words overflow-hidden text-wrap">
              {user.email}
            </span>
          </div>

          <div className="flex w-full justify-between items-center border-b-2 py-2 text-gray-700">
            <div className="flex flex-1 items-center gap-2 text-gray-600">
              <PhoneIcon size={20} className="mr-3 sm:mr-0" />
              <span className="hidden sm:flex">Contact</span>
            </div>
            <span className="flex-1 break-words overflow-hidden text-wrap">
              {user.contact}
            </span>
          </div>

          <div className="flex justify-between items-center border-b-2 py-2 text-gray-700">
            <div className="flex flex-1 items-center gap-2 text-gray-600">
              <MapPin size={20} className="mr-3 sm:mr-0" />
              <span className="hidden sm:flex">Adresse</span>
            </div>
            <span className="flex-1 break-words overflow-hidden text-wrap">
              {user.adresse}
            </span>
          </div>
        </div>
      </div>

      <div className="flex w-full flex-col mt-3">
        <h2 className="font-bold text-gray-700 font-sans text-xl">
          Mot de passe et sécurité
        </h2>
        <div className="flex flex-col w-full mt-3 gap-3">
          <div className="flex justify-between items-start sm:items-center font-sans">
            <div className="flex flex-col">
              <span className="text-gray-700">Mot de passe</span>
              <small
                onClick={() => handleAuthPassword("reset-password")}
                className="text-primaire-2 cursor-pointer"
              >
                Modifier votre mot de passe
              </small>
            </div>
            <button
              onClick={() => handleAuthPassword("reset-password")}
              className="bg-gray-500 transition-all duration-300 hover:bg-gray-600
             border-0 rounded-full hidden h-9 sm:flex items-center text-white text-sm font-sans font-normal"
            >
              Modifier
            </button>
          </div>
          <div className="flex justify-between  items-start sm:items-center font-sans">
            <div className="flex flex-col">
              <span className="text-gray-700">Nom du d'utilisateur</span>
              <small
                onClick={() => handleAuthPassword("change-username")}
                className="text-primaire-2 cursor-pointer"
              >
                Modifier votre nom d'utilisateur
              </small>
            </div>
            <button
              onClick={() => handleAuthPassword("change-username")}
              className="bg-gray-500 transition-all duration-300 hover:bg-gray-600
             border-0 rounded-full h-9 hidden sm:flex items-center text-white text-sm font-sans font-normal"
            >
              Modifier
            </button>
          </div>
        </div>
      </div>
      <div className="w-full flex flex-col sm:flex-row justify-start gap-2 mt-8">
        <button
          onClick={() => handleModifier()}
          className="bg-gray-500 transition-all duration-300 hover:bg-gray-600
             border-0 rounded-lg h-9 flex justify-center items-center text-white text-sm font-sans font-normal"
        >
          Modifier le profile
        </button>
        <button
          onClick={() => handleLogout()}
          className="bg-red-500 transition-all duration-300 hover:bg-red-600
             border-0 rounded-lg h-9 flex justify-center items-center text-white text-sm font-sans font-normal"
        >
          Déconnexion
        </button>
      </div>
    </div>
  );
}

export default Profile;
