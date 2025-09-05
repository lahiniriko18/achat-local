import {
  BarChart4,
  PieChart,
  ShoppingCart,
  Tags,
  Users,
  Warehouse,
} from "lucide-react";
import { useState } from "react";
import CardEffectif from "../components/CardEffectif";
import { AucunElement, Chargement } from "../components/ChargeData";
import BarChartComponent from "../components/chart/BarChartComponent";
import { LineChartComponent } from "../components/chart/LineChartComponent";
import { useLastElement, useStatistiqueAccueil } from "../hooks/useStatistique";
import { PieChartComponent } from "../components/chart/PieChartComponent";
import { totalMontantCommande } from "../utils/produitUtils";

function Statistique() {
  const { effectif, commandeSemaines, loading } = useStatistiqueAccueil();
  const { produitCommandes, lastCommande, loadingLastElement } =
    useLastElement();
  const [isBar, setIsBar] = useState(true);

  return (
    <div className="flex h-full flex-col p-3 overflow-auto">
      <h2 className="font-semibold  text-2xl">Statistique</h2>
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
          className="h-96 max-h-96 custom-border rounded-md p-3 flex flex-col justify-start
          custom-border-b"
        >
          <h2 className="text-basemb-3 pb-3 mb-2 custom-border-b">
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
          <div
            className="flex justify-between mb-2 pb-3 custom-border-b"
          >
            <h2 className="text-base">
              {isBar ? "Diagramme de l'effectif" : "Camembert de l'effectif"}
            </h2>
            <div
              onClick={() => setIsBar((prev) => !prev)}
              className="cursor-pointer hover:scale-105"
            >
              {isBar ? <BarChart4 /> : <PieChart />}
            </div>
          </div>
          <div className="flex-1 text-sm -ml-7 flex justify-center items-center">
            {isBar ? (
              <BarChartComponent data={effectif} />
            ) : (
              <PieChartComponent data={effectif} />
            )}
          </div>
        </div>
      </div>
      <div className="grid grid-cols-1 mt-4 md:grid-cols-2 gap-3">
        <div
          className="rounded-md p-3 flex flex-col justify-start custom-border"
        >
          <h2
            className="text-base mb-3 pb-3 custom-border-b"
          >
            {lastCommande.length == 3 ? "3 derniers" : "Derniers"} commandes
            effectuées
          </h2>
          {loadingLastElement ? (
            <div className="flex flex-1 justify-center items-center ">
              <Chargement />
            </div>
          ) : lastCommande.length == 0 ? (
            <div className="flex flex-1 justify-center items-center">
              <AucunElement text="Aucun produit" />
            </div>
          ) : (
            <div className="flex flex-1 overflow-x-auto overflow-y-hidden">
              <div className="rounded-lg w-full">
                <table className="w-full bg-font-light dark:bg-font-dark shadow-md rounded">
                  <thead
                    className="text-base leading-normal custom-border-b"
                  >
                    <tr>
                      <th className="py-2 px-6 text-left">Numéro</th>
                      <th className="py-2 px-6 text-left">Client</th>
                      <th className="py-2 px-6 text-left">Montant à payer</th>
                    </tr>
                  </thead>
                  <tbody className="text-base ">
                    {lastCommande.map((commande, index) => (
                      <tr
                        key={index}
                        className="custom-border-b"
                      >
                        <td className="py-2 px-6">{commande.numCommande}</td>
                        <td className="py-2 px-6">{commande.client.nom}</td>
                        <td className="py-2 px-6">
                          {totalMontantCommande(commande.produits)}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
        <div
          className="rounded-md p-3 flex flex-col justify-start custom-border"
        >
          <h2
            className="text-base mb-3 pb-3 custom-border-b"
          >
            3 produits le plus commandées
          </h2>
          {loadingLastElement ? (
            <div className="flex flex-1 justify-center items-center ">
              <Chargement />
            </div>
          ) : produitCommandes.length == 0 ? (
            <div className="flex flex-1 justify-center items-center">
              <AucunElement text="Aucun produit" />
            </div>
          ) : (
            <div className="flex flex-1 overflow-x-auto overflow-y-hidden">
              <div className="rounded-lg w-full">
                <table className="w-full bg-font-light dark:bg-font-dark shadow-md rounded">
                  <thead
                    className="text-base leading-normal custom-border-b"
                  >
                    <tr>
                      <th className="py-2 px-6 text-left">Numéro</th>
                      <th className="py-2 px-6 text-left">Libellé</th>
                      <th className="py-2 px-6 text-left">Quantité</th>
                      <th className="py-2 px-6 text-left">Prix unitaire</th>
                    </tr>
                  </thead>
                  <tbody className="text-base ">
                    {produitCommandes.map((p, index) => (
                      <tr
                        key={index}
                        className="custom-border-b"
                      >
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
