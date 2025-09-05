import { useCallback, useEffect, useState } from "react";
import { useLocation, useParams } from "react-router-dom";
import { getProduit, getProduitById } from "../services/ProduitService";

export function useProduits() {
  const [produits, setProduits] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchProduits = useCallback(async () => {
    setLoading(true);
    try {
      const data = await getProduit();
      setProduits(data);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchProduits();
  }, [fetchProduits]);

  return { produits, loading, error, fetchProduits };
}

export function useDetailProduit() {
  const { numProduit } = useParams();
  const [produit, setProduit] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [indexCurrentImage, setIndexCurrentImage] = useState(0);
  const location = useLocation();

  const nextImage = () => {
    if (indexCurrentImage + 1 < produit.images.length) {
      setIndexCurrentImage(indexCurrentImage + 1);
    }
  };
  const prevImage = () => {
    if (indexCurrentImage > 0) {
      setIndexCurrentImage(indexCurrentImage - 1);
    }
  };

  const chargeProduit = async () => {
    try {
      const p = await getProduitById(numProduit);
      setProduit(p);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  };

  const fetchProduit = useCallback(async () => {
    setLoading(true);
    if (location.state?.produit) {
      console.log(location.state.produit);
      setProduit(location.state.produit);
      setLoading(false);
    } else {
      chargeProduit();
    }
  }, []);

  useEffect(() => {
    fetchProduit();
  }, [fetchProduit]);

  return {
    produit,
    numProduit,
    loading,
    error,
    indexCurrentImage,
    nextImage,
    prevImage,
    setIndexCurrentImage,
  };
}
