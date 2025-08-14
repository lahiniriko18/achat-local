import { useEffect, useState } from "react";
import { Moon, Sun, Bell, ChevronDown, Search } from "lucide-react";
import { logout } from "../services/UtilisateurService";
import { useNavigate, Link } from "react-router-dom";
import defaultUser from "../assets/user.png";
import { useUser } from "../store/UserContext";
import { useSearch } from "../store/SearchContext";

function Header() {
  const { user } = useUser();
  const { searchTerm, setSearchTerm } = useSearch();
  const [isDark, setIsDark] = useState(false);
  const [showMenu, setShowMenu] = useState(false);
  const navigate = useNavigate();
  const itemOpen = localStorage.getItem("itemOpen");
  const listMenus = ["Produit", "Client", "Catégorie", "Commande"];
  const [showSearch, setShowSearch] = useState(false);

  const handleLogout = async () => {
    await logout();
    navigate("/login");
  };

  useEffect(() => {
    setShowSearch(listMenus.includes(itemOpen));
  }, [itemOpen]);

  return (
    <div className="flex items-center min-h-16 h-16 px-2 bg-white shadow-sm border-b">
      <div className="flex w-full justify-between">
        {showSearch && (
          <div className="relative p-0.5 hidden sm:flex flex-1 text-gray-600 justify-start items-center">
            <Search className="absolute ml-2 text-gray-400" />
            <input
              type="search"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder="Rechercher"
              className="border rounded-md w-full h-full pl-10
            focus:outline-none focus:ring-1 focus:ring-primaire-2"
            />
          </div>
        )}
        <div className="flex flex-1 flex-row justify-end items-center gap-3">
          <div
            onClick={() => setIsDark((value) => !value)}
            className="w-9 h-9 cursor-pointer flex justify-center items-center"
          >
            {isDark ? <Sun size={25} /> : <Moon size={25} />}
          </div>
          <div className="w-9 h-9 relative cursor-pointer flex justify-center items-center">
            <Bell size={25} />
            <div className="absolute -top-1 -right-1 bg-red-500 text-white w-5 h-5 rounded-full flex items-center justify-center text-[10px] font-bold">
              55
            </div>
          </div>
          <div
            onClick={() => setShowMenu((value) => !value)}
            className="flex relative justify-center items-center cursor-pointer"
          >
            <div
              className="w-11 h-11 mr-3 text-white bg-primaire-2
           flex justify-center items-center rounded-full"
            >
              <img
                src={user.image ?? defaultUser}
                className="w-12 h-10 object-cover rounded-full"
                alt="User"
              />
            </div>
            <ChevronDown
              size={25}
              className="absolute bottom-0 -right-2 font-bold"
            />

            {showMenu && (
              <div className="absolute top-14 right-0 w-40 bg-white shadow-md rounded-md overflow-hidden border z-50 animate-fade-in">
                <ul className="text-sm text-gray-700">
                  <Link
                    to="/profile"
                    className="text-sm text-gray-700 font-normal"
                  >
                    <li className="px-4 py-2 hover:bg-gray-100 cursor-pointer">
                      Profile
                    </li>
                  </Link>
                  <li className="px-4 py-2 hover:bg-gray-100 cursor-pointer">
                    Paramètres
                  </li>
                  <li
                    onClick={() => handleLogout()}
                    className="px-4 py-2 hover:bg-gray-100 cursor-pointer"
                  >
                    Déconnexion
                  </li>
                </ul>
              </div>
            )}
          </div>
        </div>
      </div>
      {showMenu && (
        <div
          className="fixed inset-0 bg-transparent z-10"
          onClick={() => setShowMenu(false)}
        />
      )}
    </div>
  );
}

export default Header;
