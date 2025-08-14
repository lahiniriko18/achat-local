import { useState, useEffect, useCallback } from "react";
import { profile } from "../services/UtilisateurService";

const useProfiles = () => {
  const [user, setUser] = useState({});
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchUser = useCallback(async () => {
    setLoading(true);
    try {
      const data = await profile();
      setUser(data);
      setError(null);
    } catch (err) {
      setError(err);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchUser();
  }, [fetchUser]);

  return { user, loading, error, setUser, fetchUser };
};

export default useProfiles;
