import { ChevronDown, ChevronUp, MoveUp, SlidersVertical } from "lucide-react";
import { useState } from "react";
import { AucunElement, Chargement } from "../components/ChargeData";
import useCommandes from "../hooks/useCommandes";
import { totalMontantCommande } from "../utils/produitUtils";
import { useSearch } from "../store/SearchContext";

function Historique() {
  const { commandes, loading } = useCommandes();
  const [visibleDetails, setVisibleDetails] = useState({});
  const [activeFilter, setActiveFilter] = useState(0);
  const [typeSort, setTypeSort] = useState({});
  const [showFilter, setShowFilter] = useState(false);
  const [typeFilter, setTypeFilter] = useState("Tous");
  const { searchTerm } = useSearch();

  const sortCommande = () => {
    if (activeFilter == 0) {
      return commandes.sort((a, b) =>
        typeSort[0]
          ? b.numCommande - a.numCommande
          : a.numCommande - b.numCommande
      );
    } else if (activeFilter == 1) {
      return commandes.sort((a, b) =>
        typeSort[1]
          ? new Date(b.dateCommande) - new Date(a.dateCommande)
          : new Date(a.dateCommande) - new Date(b.dateCommande)
      );
    } else if (activeFilter == 2) {
      return commandes.sort((a, b) =>
        typeSort[2]
          ? totalMontantCommande(b.produits) - totalMontantCommande(a.produits)
          : totalMontantCommande(a.produits) - totalMontantCommande(b.produits)
      );
    } else {
      return commandes.sort((a, b) =>
        typeSort[3]
          ? b.produits.length - a.produits.length
          : a.produits.length - b.produits.length
      );
    }
  };
  const commandeSort = sortCommande();
  const commandeFilter = commandeSort.filter((item) =>
    typeFilter != "Tous"
      ? item.periode == typeFilter
      : item.periode
  );
  const commandeSearch = commandeFilter.filter(
    (item) =>
      item.numCommande.toString().includes(searchTerm.toLowerCase()) ||
      item.client.nom.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.dateCommande
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase()) ||
      totalMontantCommande(item.produits)
        .toString()
        .toLowerCase()
        .includes(searchTerm.toLowerCase())
  );
  const listFilter = ["Numéro", "Date", "Total", "Nombre des produits"];
  const listGroupe = [
    "Tous",
    "Aujourd'hui",
    "Hier",
    "Cette semaine",
    "Semaine dernier",
    "Cette mois",
    "Mois dernier",
    "Cette année",
    "Année dernier",
    "Plus ancien",
  ];

  const toggleFilter = (index) => {
    setTypeSort((prev) => ({
      ...prev,
      [index]: !prev[index],
    }));
    setShowFilter(false);
  };

  const toggleDetails = (numCommande) => {
    setVisibleDetails((prev) => ({
      ...prev,
      [numCommande]: !prev[numCommande],
    }));
  };

  const getPeriode = (index) => {
    if (index == 0) {
      return commandeSearch[index].periode;
    }
    if (commandeSearch[index].periode != commandeSearch[index - 1].periode) {
      return commandeSearch[index].periode;
    }
    return;
  };

  return (
    <div className="flex h-full p-3 flex-col overflow-auto">
      <div className="flex flex-col sm:flex-row gap-2 justify-between mb-2 relative">
        <h2 className="font-semibold mb-2 text-2xl">Historique</h2>
        <div className="flex gap-2 items-center opacity-70">
          <select
            onChange={(e) => setTypeFilter(e.target.value)}
            name=""
            id=""
            className="custom-bg w-full custom-border outline-none p-2 rounded"
          >
            {listGroupe.map((value, index) => (
              <option key={index} value={value}>
                {value}
              </option>
            ))}
          </select>
          <SlidersVertical
            onClick={() => setShowFilter(true)}
            className="cursor-pointer my-scale"
          />
        </div>
        {showFilter && (
          <div className="absolute top-10 right-0 w-60 shadow rounded-md overflow-hidden z-50 custom-bg">
            <ul className="text-sm py-2">
              {listFilter.map((value, index) => (
                <li
                  key={index}
                  onClick={() => {
                    toggleFilter(index);
                    setActiveFilter(index);
                  }}
                  className={`px-4 py-2 cursor-pointer custom-hover flex justify-between ${
                    activeFilter == index ? "text-primaire-2" : ""
                  }`}
                >
                  <span>{value}</span>
                  {activeFilter == index && (
                    <MoveUp
                      className={`absolute right-3 ${
                        typeSort[index] ? "rotate-180" : ""
                      }`}
                    />
                  )}
                </li>
              ))}
            </ul>
          </div>
        )}
      </div>
      <div className="custom-bg h-full w-full">
        {loading ? (
          <div className="flex h-full w-full justify-center items-center">
            <Chargement />
          </div>
        ) : commandeSearch.length == 0 ? (
          <div className="flex h-full w-full justify-center items-center">
            <AucunElement text="Aucun commande" />
          </div>
        ) : (
          <div className="h-full">
            {commandeSearch.map((commande, index) => (
              <div>
                {getPeriode(index) && (
                  <small className="opacity-70">{commande.periode}</small>
                )}
                <div key={index} className="flex p-3 mb-3 rounded shadow-md">
                  <div className="flex w-full flex-col">
                    <div className="flex flex-col sm:flex-row justify-between items-start gap-3">
                      <div className="w-full custom-bg flex flex-col gap-1">
                        <div className="flex flex-col sm:flex-row gap-1 items-start sm:items-center">
                          <span className="font-semibold">
                            Commande numéro: {commande.numCommande}
                          </span>
                          <span className="opacity-60 text-sm sm:pl-2">
                            {commande.dateCommande}
                          </span>
                        </div>
                        <span className="text-primaire-2">
                          {commande.client.nom}
                        </span>
                      </div>
                      <div className="flex justify-center gap-3 items-center">
                        <div className="md:flex items-center gap-2 mr-4 hidden">
                          {commande.produits.map(
                            (p, index) =>
                              index < 3 && (
                                <div
                                  key={p.produit.numProduit}
                                  className="h-12 w-10"
                                >
                                  <img
                                    src={p.produit.images[0].nomImage}
                                    className="object-cover rounded-md shadow-md w-full h-full"
                                    alt={p.produit.libelleProduit}
                                  />
                                </div>
                              )
                          )}
                          {commande.produits.length > 3 && (
                            <span className="text-nowrap opacity-60">
                              +{commande.produits.length - 3}
                            </span>
                          )}
                        </div>
                        <div className="flex flex-col gap-1">
                          <span className="opacity-60">Total</span>
                          <span className="font-semibold text-nowrap">
                            {totalMontantCommande(commande.produits)} Ar
                          </span>
                        </div>
                        <div
                          onClick={() => toggleDetails(commande.numCommande)}
                        >
                          {visibleDetails[commande.numCommande] ? (
                            <ChevronUp className="opacity-50 cursor-pointer" />
                          ) : (
                            <ChevronDown className="opacity-50 cursor-pointer" />
                          )}
                        </div>
                      </div>
                    </div>
                    <div
                      className={`flex flex-col overflow-hidden ml-3 mt-2 gap-2 
                    transition-all duration-1000 ease-in-out ${
                      visibleDetails[commande.numCommande]
                        ? "max-h-screen"
                        : "max-h-0"
                    }`}
                    >
                      {commande.produits.map((p, index) => (
                        <div key={index} className="custom-border rounded p-3">
                          <div
                            className="flex flex-col sm:flex-row justify-between items-start 
                        sm:items-center gap-3"
                          >
                            <div className="flex flex-col">
                              <span className="font-semibold">
                                {p.produit.libelleProduit}
                              </span>
                              <div className="flex py-2">
                                <div className="w-10 h-10">
                                  <img
                                    src={p.produit.images[0].nomImage}
                                    className="rounded"
                                    alt=""
                                  />
                                </div>
                                <ul className="pl-3 opacity-70 text-sm">
                                  <li className="list-item">
                                    {" "}
                                    {p.produit.prixUnitaire} Ar /{" "}
                                    {p.produit.uniteMesure}
                                  </li>
                                  <li>{p.produit.categorie.nomCategorie}</li>
                                </ul>
                              </div>
                            </div>
                            <div className="flex items-center gap-1">
                              <span className="opacity-70 text-sm pr-6 hidden md:flex">
                                {p.produit.prixUnitaire} Ar *{" "}
                                {p.quantiteCommande} {p.produit.uniteMesure}
                              </span>
                              <span className="font-semibold">
                                {p.produit.prixUnitaire * p.quantiteCommande} Ar
                              </span>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
      {showFilter && (
        <div
          className="fixed inset-0 bg-transparent z-10"
          onClick={() => setShowFilter(false)}
        />
      )}
    </div>
  );
}

export default Historique;
