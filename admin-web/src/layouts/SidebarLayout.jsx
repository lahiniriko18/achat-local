import Sidebar from "../components/Sidebar";
import { SidebarItem } from "../components/Sidebar";
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
      <SidebarItem
        icon={<LayoutDashboard size={25} />}
        texte="Dashboard"
        url="/"
      />
      <SidebarItem
        icon={<Warehouse size={25} />}
        texte="Produit"
        url="/produit"
      />
      <SidebarItem icon={<Users size={25} />} texte="Client" url="/client" />
      <SidebarItem
        icon={<Tags size={25} />}
        texte="Catégorie"
        url="/categorie"
      />
      <SidebarItem
        icon={<ShoppingCart size={25} />}
        texte="Commande"
        url="/commande"
      />
      <SidebarItem
        icon={<History size={25} />}
        texte="Historique"
        url="historique"
      />
      <SidebarItem
        icon={<ChartColumn size={25} />}
        texte="Statistique"
        url="/statistique"
      />
      <SidebarItem icon={<Settings size={25} />} texte="Paramètre" />
      <SidebarItem icon={<Info size={25} />} texte="Apropos" />
    </Sidebar>
  );
}

export default SidebarLayout;
