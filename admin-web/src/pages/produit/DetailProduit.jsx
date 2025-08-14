import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { getProduitById } from "../../services/ProduitService";
import { MoveLeft } from "lucide-react";

function DetailProduit() {
  const { numProduit } = useParams();
  const [produit, setProduit] = useState({});
  const [images, setImages] = useState([]);

  const chargeProduit = async () => {
    try {
      const p = await getProduitById(numProduit);
      setProduit(p);
    } catch (e) {
      console.error("Erreur :" + e);
    }
  };
  useEffect(() => {
    if (location.state?.produit) {
      setProduit(location.state.produit);
    } else {
      chargeProduit();
    }
    const listImage = produit.images.map((image) => image.nomImage);
    setImages(listImage);
  }, [numProduit]);

  return (
    <div className="flex h-full justify-center items-center p-3">
      <div className="w-full max-h-full overflow-auto lg:w-1/2 md:w-2/3 bg-white shadow-md rounded-lg p-6 space-y-4">
        <div className="relative group flex justify-center">
          <Link to="/produit">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            Détails du produit {produit.libelleProduit}
          </h2>
        </div>
        <div className="w-full flex flex-col md:flex-row">
          <div className="w-32 h-32 flex border justify-center">
            <img
              src={images[0].nomImage}
              className="w-32 h-full object-cover rounded-full shadow-md"
              alt=""
            />
          </div>
          <div className="flex-1">Produit</div>
        </div>
      </div>
    </div>
  );
}

export default DetailProduit;
