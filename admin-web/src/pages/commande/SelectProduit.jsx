import {
  ExternalLink,
  PenBox,
  PlusCircle,
  ShoppingCart,
  Trash2,
} from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import InputComponent from "../../components/InputComponent";
import Modal from "../../components/Modal";
import QuantiteComponent from "../../components/QuantiteComponent";
import SelectComponent from "../../components/SelectComponent";
import { useProduits } from "../../hooks/useProduits";
import { getCategorie } from "../../services/CategorieService";
import { isSelected } from "../../utils/traitement";

function SelectProduit({ produitSelected, setProduitSelected }) {
  const [optionCategories, setOptionCategories] = useState([]);
  const { produits } = useProduits();
  const [categorieSelected, setCategorieSelected] = useState("");
  const [valueSearch, setValueSearch] = useState("");
  const [showQuantite, setShowQuantite] = useState(false);
  const [quantite, setQuantite] = useState(1);
  const [currentProduit, setCurrentProduit] = useState(null);
  const navigate = useNavigate();
  const valSearchCleaned = valueSearch.toLocaleLowerCase().trim();
  const produitCategorie = produits.filter((produit) =>
    produit.numCategorie.toString().includes(categorieSelected.toString())
  );
  const produitPanier = produitSelected.map((p) => p.produit);
  const chargeCategorie = async () => {
    try {
      const dataCategorie = await getCategorie();
      const options = dataCategorie.reduce((acc, cat) => {
        acc[cat.numCategorie] = cat.nomCategorie;
        return acc;
      }, {});
      setOptionCategories(options);
    } catch (erreur) {
      console.error(erreur);
    }
  };

  const filteredProduit = produitCategorie.filter(
    (produit) =>
      produit.libelleProduit.toLocaleLowerCase().includes(valSearchCleaned) ||
      produit.quantite
        .toString()
        .toLocaleLowerCase()
        .includes(valSearchCleaned) ||
      produit.prixUnitaire
        .toString()
        .toLocaleLowerCase()
        .includes(valSearchCleaned) ||
      produit.uniteMesure.toLocaleLowerCase().includes(valSearchCleaned)
  );

  const selectProduit = (produit) => {
    setCurrentProduit(produit);
    setShowQuantite(true);
    if (isSelected(produitPanier, produit)) {
      const selected = produitSelected.find(
        (p) => p.produit.numProduit === produit.numProduit
      );
      if (selected) {
        setQuantite(selected.quantiteCommande);
      }
    }
  };

  const changeValueQuantite = (e) => {
    setQuantite(e.target.value);
  };
  const handleDetailProduit = (produit) => {
    console.log(produit);
    navigate(`/produit/details/${produit.numProduit}`, {
      state: { produit },
    });
  };

  const addProduit = () => {
    const ps = {
      produit: currentProduit,
      quantiteCommande: quantite,
    };
    if (isSelected(produitPanier, currentProduit)) {
      const selected = produitSelected.find(
        (p) => p.produit.numProduit === currentProduit.numProduit
      );
      setProduitSelected((prev) =>
        prev.map((item) =>
          item.produit.numProduit == selected.produit.numProduit
            ? { ...item, ...ps }
            : item
        )
      );
    } else {
      setProduitSelected((prev) => [...prev, ps]);
    }
    setCurrentProduit(null);
    setQuantite(1);
    hideModal();
  };

  const hideModal = () => {
    setShowQuantite(false);
  };

  const deleteOnPanier = (produit) => {
    const newProduit = produitSelected.filter(
      (p) => p.produit.numProduit != produit.numProduit
    );
    setProduitSelected(newProduit);
  };

  useEffect(() => {
    chargeCategorie();
  }, []);

  return (
    <div className="flex h-full justify-center items-start p-3">
      <div className="flex h-full flex-col w-full md:w-4/5 custom-bg shadow rounded-lg space-y-4">
        <div className="w-full flex flex-col px-4 pt-4 justify-start">
          <div className="flex flex-col sm:flex-row justify-center items-center sm:justify-between">
            <h2 className="text-xl font-semibold text-center mb-4 ml-3">
              Sélectionner votre produit
            </h2>
            <div className="relative w-12 h-12 cursor-pointer">
              <Link to="panier">
                <ShoppingCart
                  className={`
                  text-primaire-2
                  w-full h-full transition-all duration-300 hover:scale-105 
                `}
                />
              </Link>
              <div
                className="w-6 h-6 bg-red-500 absolute -top-2 
                -right-4 rounded-full flex justify-center items-center text-theme-light"
              >
                <span className="text-[12px] font-semibold text-center">
                  {produitSelected.length}
                </span>
              </div>
            </div>
          </div>
          <div className="flex w-full justify-center px:1 md:px-10">
            <div className="flex w-full flex-col mt-2 md:flex-row">
              <SelectComponent
                name="categorie"
                defaultValeur="Tous"
                options={optionCategories}
                value={categorieSelected}
                onChange={(e) => setCategorieSelected(e.target.value)}
              />
              <InputComponent
                type="search"
                name="searchProduit"
                value={valueSearch}
                onChange={(e) => setValueSearch(e.target.value)}
                placeholder="Rechercher"
              />
            </div>
          </div>
        </div>
        <div className="flex-1 p-3 overflow-auto gap-3 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 mt-4">
          {filteredProduit.map((produit) => (
            <div
              className={`shadow-md rounded relative flex justify-center items-start p-3 flex-col 
                ${isSelected(produitPanier, produit) ? "custom-bg-low" : ""}`}
            >
              {produit.images && (
                <div className="w-full h-32 flex justify-center">
                  <img
                    src={produit.images[0].nomImage}
                    className="w-32 h-full object-cover rounded-full shadow-md"
                    alt=""
                  />
                </div>
              )}
              <div className="pt-3 flex gap-1 flex-col ">
                <div className="flex gap-2 justify-start items-center text-sm">
                  <span className="font-semibold">Nom :</span>
                  <span>{produit.libelleProduit}</span>
                </div>
                <div className="flex gap-2 justify-start items-center text-sm">
                  <span className="font-semibold">Quantité :</span>
                  <span>
                    {produit.quantite} {produit.uniteMesure}
                  </span>
                </div>
                <div className="flex gap-2 justify-start items-center text-sm">
                  <span className="font-semibold">Prix unitaire :</span>
                  <span>{produit.prixUnitaire} Ar</span>
                </div>
              </div>
              <div className="w-full flex mt-3 justify-evenly">
                {isSelected(produitPanier, produit) ? (
                  <PenBox
                    onClick={() => selectProduit(produit)}
                    className={`text-primaire-2 cursor-pointer transition-all duration-300 hover:scale-105
                        ${
                          produit.quantite > 0
                            ? "cursor-pointer"
                            : "pointer-events-none opacity-50"
                        }`}
                  />
                ) : (
                  <PlusCircle
                    onClick={() => selectProduit(produit)}
                    className={`text-primaire-2 cursor-pointer transition-all duration-300 hover:scale-105
                        ${
                          produit.quantite > 0
                            ? "cursor-pointer"
                            : "pointer-events-none opacity-50"
                        }`}
                  />
                )}
                <Trash2
                  onClick={() => deleteOnPanier(produit)}
                  className={`transition-all duration-300 hover:scale-105 text-red-500
                      ${
                        produitPanier.some(
                          (p) => p.numProduit === produit.numProduit
                        )
                          ? "cursor-pointer"
                          : "pointer-events-none opacity-50"
                      }`}
                />
                <ExternalLink
                  onClick={() => handleDetailProduit(produit)}
                  className={`transition-all duration-300 hover:scale-105 cursor-pointer`}
                />
              </div>
            </div>
          ))}
        </div>
        <div className="w-full h-10 mb-2">
          <div className="flex justify-end gap-3 px-2">
            <Link to="/commande" className="text-theme-light h-10">
              <button className="h-10 bg-gray-500 text-theme-light transition-all duration-300 hover:bg-gray-600 flex justify-center items-center">
                Annuler
              </button>
            </Link>
            <Link to="client" className="text-theme-light">
              <button className="bg-primaire-1 text-theme-light h-10 transition-all duration-300 hover:bg-primaire-2 flex justify-center items-center">
                Suivant
              </button>
            </Link>
          </div>
        </div>
      </div>
      {showQuantite && <Modal action={hideModal} />}
      {showQuantite && (
        <QuantiteComponent
          closeAction={hideModal}
          onChange={changeValueQuantite}
          submitAction={addProduit}
          value={quantite}
          maxValeur={currentProduit.quantite}
        />
      )}
    </div>
  );
}

export default SelectProduit;
