import React from "react";
import { useState, useRef, useEffect } from "react";
import { MoveLeft, ImagePlus, X } from "lucide-react";
import { Link, useNavigate, useParams, useLocation } from "react-router-dom";
import InputComponent from "../../components/InputComponent";
import SelectComponent from "../../components/SelectComponent";
import { getCategorie } from "../../services/CategorieService";
import {
  addProduit,
  getProduitById,
  updateProduit,
} from "../../services/ProduitService";
import { cleanFormData } from "../../utils/validation";
import { renameFile } from "../../utils/traitement";
import { handleChange } from "../../utils/formUtils";

function FormulaireProduit() {
  const [formData, setFormData] = useState({
    numProduit: "",
    libelleProduit: "",
    numCategorie: "",
    prixUnitaire: "",
    categorie: "",
    quantite: "",
    uniteMesure: "",
    description: "",
  });
  const { numProduit } = useParams();
  const navigate = useNavigate();
  const location = useLocation();
  const [optionCategories, setOptionCategories] = useState({});
  const [erreurs, setErreurs] = useState({});
  const fileInputRef = useRef(null);
  const [images, setImages] = useState([]);
  const [imageDelted, setImageDeleted] = useState([]);
  const MAX_IMAGES = 5;
  const isEdit = !!numProduit;

  const handleSubmit = async (e) => {
    e.preventDefault();

    let donneeProduit = new FormData();
    let nouveauErreurs = {};

    if (!formData.libelleProduit.trim()) {
      nouveauErreurs.libelleProduit = "required";
    } else if (formData.libelleProduit.length < 3) {
      nouveauErreurs.libelleProduit = "Au moins 3 caracères!";
    }
    if (!formData.quantite.toString().trim()) {
      nouveauErreurs.quantite = "required";
    }
    if (!formData.prixUnitaire.toString().trim()) {
      nouveauErreurs.prixUnitaire = "required";
    }
    if (!formData.uniteMesure.trim()) {
      nouveauErreurs.uniteMesure = "required";
    }
    setErreurs(nouveauErreurs);
    if (Object.keys(nouveauErreurs).length == 0) {
      donneeProduit = cleanFormData(formData);
      images.forEach((image) => {
        if (image.file instanceof File) {
          donneeProduit.append("images", renameFile(image.file));
        }
      });
      imageDelted.forEach((id) => {
        donneeProduit.append("imageDeleted", id);
      });
      try {
        isEdit
          ? await updateProduit(donneeProduit, numProduit)
          : await addProduit(donneeProduit);
        navigate("/produit", {
          state: {
            successMessage: isEdit
              ? "Produit modifié avec succès !"
              : "Produit ajouté avec succès !",
          },
        });
      } catch (erreur) {
        console.error(erreur);
      }
    }
  };

  const handleFileChange = (e) => {
    const selectedFiles = Array.from(e.target.files);
    const totalImages = [...images, ...selectedFiles];

    if (totalImages.length > MAX_IMAGES) {
      alert(`Vous pouvez importer au maximum ${MAX_IMAGES} images.`);
      return;
    }
    const newPreviews = selectedFiles.map((file) => ({
      file: file,
      url: URL.createObjectURL(file),
    }));
    setImages((prev) => [...prev, ...newPreviews]);
    console.log(images);
  };

  const triggerFileInput = () => {
    if (images.length >= MAX_IMAGES) {
      alert(`Vous avez déjà importé ${MAX_IMAGES} images.`);
      return;
    }
    fileInputRef.current.click();
  };

  const removeImage = (indexToRemove) => {
    if (!(images[indexToRemove].file instanceof File)) {
      setImageDeleted((prev) => [...prev, images[indexToRemove].file]);
    }
    const updatedImages = images.filter((_, index) => index !== indexToRemove);
    setImages(updatedImages);
  };

  const chargeCategories = async () => {
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
  useEffect(() => {
    if (isEdit) {
      let produit = null;
      if (location.state?.produit) {
        produit = location.state.produit;
      } else {
        getProduitById(numProduit)
          .then((data) => {
            produit = data;
          })
          .catch((error) => console.error(error));
      }
      setFormData(produit);
      const imagePreviews = produit.images.map((image) => ({
        file: image.numImage,
        url: image.nomImage,
      }));
      setImages(imagePreviews);
    }
    chargeCategories();
  }, [numProduit, location.state]);
  return (
    <div className="flex h-full justify-center p-3">
      <form
        onSubmit={handleSubmit}
        className="w-full max-h-full overflow-auto lg:w-3/5 bg-white shadow-md rounded-lg p-6 space-y-4"
        encType="multipart/form-data"
      >
        <div className="relative group flex justify-center">
          <Link to="/produit">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-2 ml-3 sm:ml-0">
            {isEdit ? "Modifier un produit" : "Ajouter un nouveau produit"}
          </h2>
        </div>
        <InputComponent
          label="Nom du produit"
          type="text"
          name="libelleProduit"
          value={formData.libelleProduit}
          setFormData={setFormData}
          placeholder="Ex: Riz"
          erreur={erreurs.libelleProduit}
        />

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <InputComponent
            label="Prix unitaire"
            type="number"
            minValeur={1}
            name="prixUnitaire"
            value={formData.prixUnitaire}
            setFormData={setFormData}
            placeholder="Ex: 15000"
            erreur={erreurs.prixUnitaire}
          />
          <SelectComponent
            label="Catégorie"
            name="numCategorie"
            value={formData.numCategorie}
            setFormData={setFormData}
            options={optionCategories}
          />
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <InputComponent
            label="Stock disponible"
            type="number"
            minValeur={1}
            name="quantite"
            value={formData.quantite}
            setFormData={setFormData}
            placeholder="Ex: 12"
            erreur={erreurs.quantite}
          />
          <InputComponent
            label="Unité de mesure"
            type="text"
            name="uniteMesure"
            value={formData.uniteMesure}
            setFormData={setFormData}
            placeholder="Ex: Kg"
            erreur={erreurs.uniteMesure}
          />
        </div>
        <div>
          <label className="block text-md font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea
            name="description"
            value={formData.description}
            onChange={(e) => handleChange(e, setFormData)}
            rows="4"
            className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-1 focus:ring-primaire-2"
            placeholder="Ex: Riz du bonne qualité provenant d'Ambatondrazaka"
          />
        </div>
        <div className="flex flex-col gap-4">
          <div
            className="border-2 border-dashed border-gray-400 p-6 rounded-md cursor-pointer flex flex-col items-center justify-center hover:border-primaire-2 transition duration-200"
            onClick={triggerFileInput}
          >
            <ImagePlus className="w-12 h-12 text-gray-400 mb-2" />
            <p className="text-gray-500">
              Cliquez pour importer jusqu'à {MAX_IMAGES} images
            </p>
            <input
              type="file"
              name="images"
              multiple
              accept="image/*"
              ref={fileInputRef}
              className="hidden"
              onChange={handleFileChange}
            />
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-4">
            {images.map((imageObj, index) => (
              <div key={index} className="relative group">
                <img
                  src={imageObj.url}
                  alt={`importée-${index}`}
                  className="w-full h-28 object-cover rounded-md shadow-md transition-all duration-300 hover:scale-105"
                />
                <button
                  className="absolute top-1 right-1 bg-white text-red-600
                  hover:scale-105 border-0
                   rounded-full p-1 shadow transition-all"
                  onClick={() => removeImage(index)}
                  type="button"
                >
                  <X size={16} />
                </button>
              </div>
            ))}
          </div>
        </div>

        <div className="text-center">
          <button
            type="submit"
            className="bg-primaire-1 hover:bg-primaire-2 sm:w-1/2 text-white font-semibold px-6 py-2 rounded-md transition duration-200"
          >
            Enregistrer
          </button>
        </div>
      </form>
    </div>
  );
}

export default FormulaireProduit;
