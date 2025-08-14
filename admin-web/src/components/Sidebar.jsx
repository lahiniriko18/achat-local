import { createContext, useContext, useState } from "react";
import { ChevronFirst, ChevronLast } from "lucide-react";
import logo from "../assets/logoipsum-380.svg";
import defaultUser from "../assets/user.png";
import { useNavigate } from "react-router-dom";
import { useUser } from "../store/UserContext";

const SidebarContext = createContext();

export default function Sidebar({ children }) {
  const [isOpen, setIsOpen] = useState(true);
  const { user } = useUser();
  const [itemOpen, setItemOpen] = useState(
    localStorage.getItem("itemOpen") ?? "Dashboard"
  );
  const toggleSidebar = (value) => {
    localStorage.setItem("itemOpen", value);
    setItemOpen(localStorage.getItem("itemOpen"));
  };
  const navigate = useNavigate();

  return (
    <aside className="h-screen max-w-60">
      <nav className="h-full flex flex-col bg-white border-r shadow-sm">
        <div className="p-4 pb-2 flex justify-between items-center">
          <img
            src={logo}
            alt=""
            className={`overflow-hidden transition-all
            ${isOpen ? "w-32" : "w-0"}
            `}
          />
          <button
            onClick={() => setIsOpen((curr) => !curr)}
            className="ml-2 p-1.5 rounded-lg bg-gray-50 hover:bg-gray-100"
          >
            {isOpen ? <ChevronFirst /> : <ChevronLast />}
          </button>
        </div>

        <SidebarContext.Provider value={{ isOpen, itemOpen, toggleSidebar }}>
          <ul className="flex-1 px-3">{children}</ul>
        </SidebarContext.Provider>

        <div
          onClick={() => navigate("/profile")}
          className="border-t flex p-3 cursor-pointer"
        >
          <img
            src={user.image ?? defaultUser}
            className="w-12 h-10 object-cover rounded-full"
            alt="User"
          />
          <div
            className={`flex justify-between items-center overflow-hidden transition-all
            ${isOpen ? "w-52 ml-3" : "w-0"}`}
          >
            <div className="leading-4">
              <h4 className="font-semibold font-sans">{user.username}</h4>
              <span className="text-xs text-gray-600">{user.email}</span>
            </div>
          </div>
        </div>
      </nav>
    </aside>
  );
}

export function SidebarItem({ icon, texte }) {
  const { isOpen, itemOpen, toggleSidebar } = useContext(SidebarContext);
  return (
    <li
      onClick={() => toggleSidebar(texte)}
      className={`relative group flex items-center
        px-3 py-2 my-1 font-medium rounded-md 
        cursor-pointer transition-colors duration-100 font-sans
        ${
          itemOpen == texte
            ? "bg-primaire-2 text-white"
            : "hover:bg-primaire-2 text-gray-600 hover:text-white"
        }
        `}
    >
      {icon}
      <span
        className={`overflow-hidden transition-all ${
          isOpen ? "w-52 ml-3" : "w-0"
        }`}
      >
        {texte}
      </span>
    </li>
  );
}
