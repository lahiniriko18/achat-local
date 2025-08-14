import { useState, useEffect } from "react";
import { Users, ShoppingCart, Warehouse, Tags } from "lucide-react";
import CardEffectif from "../components/CardEffectif";
import LineChartComponent from "../components/LineChartComponent";
import BarChartComponent from "../components/BarChartComponent";
import { getEffectif } from "../services/StatistiqueService";

function Accueil() {
  const [effectif, setEffectif] = useState({});
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    getEffectif()
      .then((data) => setEffectif(data))
      .catch((error) => console.error(error))
      .finally(() => setIsLoading(false))
  }, []);
  return (
    <div className="flex flex-col h-full p-3 overflow-auto">
      <h2 className="font-semibold font-sans text-2xl">Accueil</h2>
      <div className="grid grid-cols-1 mt-3 md:grid-cols-2 lg:grid-cols-4 gap-3">
        <CardEffectif
          icon={<Warehouse size={25} />}
          text="Total produits"
          effectif={isLoading ? "0" : effectif.produit}
        />
        <CardEffectif
          icon={<Users size={25} />}
          text="Total clients"
          effectif={isLoading ? "0" : effectif.client}
        />
        <CardEffectif
          icon={<ShoppingCart size={25} />}
          text="Total commande"
          effectif={isLoading ? "0" : effectif.commande}
        />
        <CardEffectif
          icon={<Tags size={25} />}
          text="Total catégorie"
          effectif={isLoading ? "0" : effectif.categorie}
        />
      </div>
      <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3">
        <div className="h-96 max-h-96 border rounded-md p-3 flex flex-col justify-start">
          <h2 className="text-base text-gray-500 font-sans">
            Evolution du commande
          </h2>
          <span className="text-2xl font-semibold font-sans mb-3">+17%</span>
          <div className="flex-1 text-sm -ml-7">
            <LineChartComponent />
          </div>
        </div>
        <div className="h-96 max-h-96 border rounded-md p-3 flex flex-col justify-start">
          <h2 className="text-base text-gray-500 font-sans pb-3">
            Diagramme de l'effectif
          </h2>
          <div className="flex-1 text-sm -ml-7">
            <BarChartComponent data={effectif} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default Accueil;
