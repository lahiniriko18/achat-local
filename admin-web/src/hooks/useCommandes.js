import { useState, useEffect, useCallback } from "react";
import { getCommande } from "../services/CommandeService";

const useCommandes = () => {
  const [commandes, setCommandes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchCommandes = useCallback(async () => {
    setLoading(true);
    try {
      const data = await getCommande();
      console.log(data);
      setCommandes(data);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCommandes();
  }, [fetchCommandes]);

  return { commandes, loading, error, fetchCommandes };
};

export default useCommandes;
