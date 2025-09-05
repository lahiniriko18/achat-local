import { useState, useEffect, useCallback } from "react";
import {
  getEffectif,
  commandeEvolution,
  getProduitPlusCommande,
  getLastCommande,
} from "../services/StatistiqueService";

export const useStatistiqueAccueil = () => {
  const [effectif, setEffectif] = useState({});
  const [commandeSemaines, setCommandeSemaines] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchEffectifAccueil = useCallback(async () => {
    setLoading(true);
    try {
      const dataEffectif = await getEffectif();
      const dataCommande = await commandeEvolution();
      setEffectif(dataEffectif);
      setCommandeSemaines(dataCommande);
      console.log(commandeSemaines);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchEffectifAccueil();
  }, [fetchEffectifAccueil]);

  return { effectif, commandeSemaines, loading, error, fetchEffectifAccueil };
};

export const useLastElement = () => {
  const [produitCommandes, setProduitCommandes] = useState([]);
  const [lastCommande, setLastCommande] = useState([]);
  const [loadingLastElement, setLoadingLastElement] = useState(false);
  const [error, setError] = useState(null);

  const fetchLastElement = useCallback(async () => {
    setLoadingLastElement(true);
    try {
      const dataProduit = await getProduitPlusCommande(3);
      const dataLastCommande = await getLastCommande(3);
      setProduitCommandes(dataProduit);
      setLastCommande(dataLastCommande);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoadingLastElement(false);
    }
  }, []);

  useEffect(() => {
    fetchLastElement();
  }, [fetchLastElement]);

  return {
    produitCommandes,
    lastCommande,
    loadingLastElement,
    error,
    fetchLastElement,
  };
};
