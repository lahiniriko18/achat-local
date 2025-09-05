import axios from "../constants/api";

export const getCommande = async () => {
  try {
    const response = await axios.get(`/commande`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getCommandeById = async (numCommande) => {
  try {
    const response = await axios.get(`/commande/${numCommande}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteCommande = async (numCommande) => {
  try {
    const response = await axios.delete(`/commande/supprimer/${numCommande}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteMultipleCommande = async (data) => {
  try {
    const response = await axios.post(`/commande/supprimer/multiple/`, data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const addCommande = async (formData) => {
  try {
    const response = await axios.post(`/commande/ajouter/`, formData);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const updateCommande = async (formData, numCommande) => {
  try {
    const response = await axios.put(
      `/commande/modifier/${numCommande}`,
      formData
    );
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

