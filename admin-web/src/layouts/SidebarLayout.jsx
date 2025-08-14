import React from "react";
import Sidebar from "../components/Sidebar";
import { SidebarItem } from "../components/Sidebar";
import { Link } from "react-router-dom";
import {
  LayoutDashboard,
  Settings,
  ChartColumn,
  Users,
  ShoppingCart,
  Warehouse,
  Tags,
  History,
  Info,
} from "lucide-react";
function SidebarLayout() {
  return (
    <Sidebar>
      <Link to="/">
        <SidebarItem icon={<LayoutDashboard size={25} />} texte="Dashboard" />
      </Link>
      <Link to="/produit">
        <SidebarItem icon={<Warehouse size={25} />} texte="Produit" />
      </Link>
      <Link to="/client">
        <SidebarItem icon={<Users size={25} />} texte="Client" />
      </Link>
      <Link to="/categorie">
        <SidebarItem icon={<Tags size={25} />} texte="Catégorie" />
      </Link>
      <Link to="/commande">
        <SidebarItem icon={<ShoppingCart size={25} />} texte="Commande" />
      </Link>
      <SidebarItem icon={<History size={25} />} texte="Historique" />
      <Link to="/statistique">
        <SidebarItem icon={<ChartColumn size={25} />} texte="Statistique" />
      </Link>
      <SidebarItem icon={<Settings size={25} />} texte="Paramètre" />
      <SidebarItem icon={<Info size={25} />} texte="Apropos" />
    </Sidebar>
  );
}

export default SidebarLayout;
