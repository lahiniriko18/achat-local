import { useCallback, useEffect, useState } from "react";
import { useLocation, useParams } from "react-router-dom";
import {
  getCategorie,
  getCategorieById,
  getEffectifProduitCategorie,
  getProduitPlusCommandeCategorie,
} from "../services/CategorieService";

export const useCategories = () => {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchCategories = useCallback(async () => {
    setLoading(true);
    try {
      const data = await getCategorie();
      setCategories(data);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCategories();
  }, [fetchCategories]);

  return { categories, loading, error, fetchCategories };
};

export const useDetailCategorie = () => {
  const { numCategorie } = useParams();
  const [categorie, setCategorie] = useState({});
  const [effectifProduit, setEffectifProduit] = useState([]);
  const [plusCommande, setPlusCommande] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const location = useLocation();

  const chargeCategorie = async () => {
    setLoading(true);
    try {
      const dataCategorie = await getCategorieById(numCategorie);
      setCategorie(dataCategorie);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  };

  const chargeEffectif = async () => {
    setLoading(true);
    try {
      const dataEffectif = await getEffectifProduitCategorie(numCategorie);
      const dataPlusCommande = await getProduitPlusCommandeCategorie(
        numCategorie
      );
      setEffectifProduit(dataEffectif);
      setPlusCommande(dataPlusCommande);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  };

  const fetchCategorie = useCallback(async () => {
    chargeEffectif();
    setLoading(true);
    if (location.state?.categorie) {
      setCategorie(location.state.categorie);
      setLoading(false);
    } else {
      chargeCategorie();
    }
  }, []);

  useEffect(() => {
    fetchCategorie();
  }, [fetchCategorie]);

  return {
    categorie,
    effectifProduit,
    plusCommande,
    numCategorie,
    loading,
    error,
  };
};
