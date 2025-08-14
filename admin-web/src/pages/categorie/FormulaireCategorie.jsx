import React from "react";
import { useState, useEffect } from "react";
import { Key, MoveLeft, ImagePlus, X } from "lucide-react";
import { Link, useNavigate, useParams, useLocation } from "react-router-dom";
import InputComponent from "../../components/InputComponent";
import {
  addCategorie,
  updateCategorie,
  getCategorieById,
} from "../../services/CategorieService";
import { cleanFormData } from "../../utils/validation";
import useImageManager from "../../hooks/useImageManager";
import { handleChange } from "../../utils/formUtils";

function FormulaireCategorie() {
  const [formData, setFormData] = useState({
    numCategorie: "",
    imageCategorie: "",
    nomCategorie: "",
    descCategorie: "",
  });

  const [erreurs, setErreurs] = useState({});
  const { numCategorie } = useParams();
  const navigate = useNavigate();
  const location = useLocation();
  const {
    imageFile,
    imagePreview,
    fileInputRef,
    handleFileChange,
    removeImage,
    setImagePreview,
    triggerFileInput,
  } = useImageManager();
  const isEdit = !!numCategorie;

  const handleSubmit = async (e) => {
    e.preventDefault();

    let donneeCategorie = new FormData();
    let nouveauErreurs = {};
    if (!formData.nomCategorie.trim()) {
      nouveauErreurs.nomCategorie = "required";
    }
    setErreurs(nouveauErreurs);
    if (Object.keys(nouveauErreurs).length == 0) {
      donneeCategorie = cleanFormData(formData, ["imageCategorie"]);
      if (imageFile) {
        donneeCategorie.append("imageCategorie", imageFile);
      } else {
        if (!imagePreview) {
          donneeCategorie.append("imageCategorie", "");
        }
      }
      try {
        isEdit
          ? await updateCategorie(donneeCategorie, numCategorie)
          : await addCategorie(donneeCategorie);
        navigate("/categorie", {
          state: {
            successMessage: isEdit
              ? "Catégorie modifiée avec succès !"
              : "Catégorie ajoutée avec succès !",
          },
        });
      } catch (erreur) {
        console.error(erreur);
      }
    }
  };

  useEffect(() => {
    if (isEdit) {
      let categorie = null;
      if (location.state?.categorie) {
        categorie = location.state.categorie;
      } else {
        getCategorieById(numCategorie)
          .then((data) => (categorie = data))
          .catch((error) => console.error(error));
      }
      setFormData(categorie);
      setImagePreview(categorie.imageCategorie);
    }
  }, [numCategorie, location.state]);

  return (
    <div className="flex h-full justify-center p-3">
      <form
        onSubmit={handleSubmit}
        className="w-full max-h-full overflow-auto md:w-3/5 bg-white shadow-md rounded-lg p-6 space-y-4"
        encType="multipart/form-data"
      >
        <div className="relative group flex justify-center">
          <Link to="/categorie">
            <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
          </Link>
          <h2 className="text-xl font-semibold text-center mb-4 ml-3 sm:ml-0">
            {isEdit
              ? "Modifier une catégorie"
              : "Ajouter une nouvelle catégorie"}
          </h2>
        </div>
        <InputComponent
          label="Nom du catégorie"
          type="text"
          name="nomCategorie"
          value={formData.nomCategorie}
          setFormData={setFormData}
          placeholder="Ex: Légumes"
          erreur={erreurs.nomCategorie}
        />
        <div>
          <label className="block text-md font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea
            name="descCategorie"
            value={formData.descCategorie}
            onChange={(e) => handleChange(e, setFormData)}
            rows="4"
            className="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-1 focus:ring-primaire-2"
            placeholder="Ex: Riz du bonne qualité provenant d'Ambatondrazaka"
          />
        </div>
        <div
          className="border-2 border-dashed border-gray-400 p-6 rounded-md cursor-pointer flex flex-col items-center justify-center hover:border-blue-500 transition duration-200"
          onClick={triggerFileInput}
        >
          <ImagePlus className="w-12 h-12 text-gray-400 mb-2" />
          <p className="text-gray-500">Cliquez pour importer une image</p>
          <input
            type="file"
            accept="image/*"
            ref={fileInputRef}
            className="hidden"
            onChange={handleFileChange}
          />
        </div>
        {imagePreview && (
          <div className=" relative mt-4 flex justify-center">
            <div className="relative transition-all duration-300 hover:scale-105">
              <X
                onClick={removeImage}
                className="absolute top-1 right-1 cursor-pointer text-red-500 hover:scale-105"
              />
              <img
                src={imagePreview}
                alt="aperçu"
                className="w-32 h-32 object-cover rounded-md shadow"
              />
            </div>
          </div>
        )}
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

export default FormulaireCategorie;
