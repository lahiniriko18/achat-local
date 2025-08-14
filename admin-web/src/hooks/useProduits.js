import { useState, useEffect, useCallback } from 'react';
import { getProduit } from '../services/produitService';

const useProduits = () => {
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
};

export default useProduits;
