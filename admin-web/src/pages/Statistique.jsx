import { useState, useEffect } from "react";
import { AucunElement, Chargement } from "../components/ChargeData";
import {
  Users,
  ShoppingCart,
  Warehouse,
  Tags,
  PieChart,
  BarChart4,
} from "lucide-react";
import CardEffectif from "../components/CardEffectif";
import LineChartComponent from "../components/LineChartComponent";
import BarChartComponent from "../components/BarChartComponent";
import {
  getEffectif,
  getProduitPlusCommande,
} from "../services/StatistiqueService";

function Statistique() {
  const [effectif, setEffectif] = useState({});
  const [produitCommandes, setProduitCommandes] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isBar, setIsBar] = useState(true);

  const chargeStatistique = async () => {
    setIsLoading(true);
    try {
      const dataProduitCommande = await getProduitPlusCommande(3);
      const dataEffectif = await getEffectif();
      setProduitCommandes(dataProduitCommande);
      setEffectif(dataEffectif);
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    chargeStatistique();
  }, []);
  return (
    <div className="flex h-full flex-col p-3 overflow-auto">
      <h2 className="font-semibold font-sans text-2xl">Statistique</h2>
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
          <h2 className="text-base text-gray-500 mb-3 pb-3 font-sans border-b">
            Evolution du commande
          </h2>
          <span className="text-2xl font-semibold font-sans mb-3">+17%</span>
          <div className="flex-1 text-sm -ml-7">
            <LineChartComponent />
          </div>
        </div>
        <div className="h-96 max-h-96 border rounded-md p-3 flex flex-col justify-start">
          <div className="flex justify-between mb-3 pb-3 border-b">
            <h2 className="text-base text-gray-500 font-sans">
              Diagramme de l'effectif
            </h2>
            <div
              onClick={() => setIsBar((prev) => !prev)}
              className="cursor-pointer hover:scale-105 text-gray-500"
            >
              {isBar ? <BarChart4 /> : <PieChart />}
            </div>
          </div>
          <div className="flex-1 text-sm -ml-7">
            <BarChartComponent data={effectif} />
          </div>
        </div>
      </div>
      <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3">
        <div className="border rounded-md p-3 flex flex-col justify-start">
          <h2 className="text-base text-gray-500 mb-3 pb-3 font-sans border-b">
            3 derniers commandes
          </h2>
        </div>
        <div className="border rounded-md p-3 flex flex-col justify-start">
          <h2 className="text-base text-gray-500 font-sans mb-3 pb-3 border-b">
            3 produits le plus commandées
          </h2>
          {isLoading ? (
            <div className="flex flex-1 justify-center items-center ">
              <Chargement />
            </div>
          ) : produitCommandes.length == 0 ? (
            <div className="flex flex-1 justify-center items-center">
              <AucunElement text="Aucun produit" />
            </div>
          ) : (
            <div className="flex flex-1 overflow-x-auto overflow-y-hidden">
              <div className="rounded-lg">
                <table className="min-w-full bg-white shadow-md rounded">
                  <thead className="bg-gray-100 text-gray-600 font-sans text-base leading-normal border-b">
                    <tr>
                      <th className="py-2 px-6 text-left">Numéro</th>
                      <th className="py-2 px-6 text-left">Libellé</th>
                      <th className="py-2 px-6 text-left">Quantité</th>
                      <th className="py-2 px-6 text-left">Prix unitaire</th>
                    </tr>
                  </thead>
                  <tbody className="text-gray-700 text-base font-sans">
                    {produitCommandes.map((p, index) => (
                      <tr key={index} className="border-b hover:bg-gray-50">
                        <td className="py-2 px-6">{p.numProduit}</td>
                        <td className="py-2 px-6">{p.libelleProduit}</td>
                        <td className="py-2 px-6">
                          {p.quantite} {p.uniteMesure}
                        </td>
                        <td className="py-2 px-6">{p.prixUnitaire}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default Statistique;
