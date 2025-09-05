import { ShoppingCart, Tags, Users, Warehouse } from "lucide-react";
import BarChartComponent from "../components/chart/BarChartComponent";
import CardEffectif from "../components/CardEffectif";
import { LineChartComponent } from "../components/chart/LineChartComponent";
import { useStatistiqueAccueil } from "../hooks/useStatistique";

function Accueil() {
  const { effectif, commandeSemaines, loading } = useStatistiqueAccueil();
  return (
    <div className="flex flex-col h-full p-3 overflow-auto">
      <h2 className="font-semibold  text-2xl">Accueil</h2>
      <div className="grid grid-cols-1 mt-3 md:grid-cols-2 lg:grid-cols-4 gap-3">
        <CardEffectif
          icon={<Warehouse size={25} />}
          text="Total produits"
          effectif={loading ? "0" : effectif.produit}
        />
        <CardEffectif
          icon={<Users size={25} />}
          text="Total clients"
          effectif={loading ? "0" : effectif.client}
        />
        <CardEffectif
          icon={<ShoppingCart size={25} />}
          text="Total commande"
          effectif={loading ? "0" : effectif.commande}
        />
        <CardEffectif
          icon={<Tags size={25} />}
          text="Total catégorie"
          effectif={loading ? "0" : effectif.categorie}
        />
      </div>
      <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3">
        <div
          className="h-96 max-h-96 rounded-md p-3 flex flex-col justify-start
        custom-border"
        >
          <h2 className="text-base mb-3 pb-3  custom-border-b">
            Evolution du commande hébdomadaire
          </h2>
          <div className="flex-1 text-sm -ml-7">
            <LineChartComponent data={commandeSemaines} />
          </div>
        </div>
        <div
          className="h-96 max-h-96 rounded-md p-3 flex flex-col justify-start
        custom-border"
        >
          <div className="flex justify-between mb-3 pb-3 custom-border-b">
            <h2 className="text-base ">Diagramme de l'effectif</h2>
          </div>
          <div className="flex-1 text-sm -ml-7">
            <BarChartComponent data={effectif} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default Accueil;
