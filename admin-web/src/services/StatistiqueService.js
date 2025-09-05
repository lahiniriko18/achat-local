import axios from "../constants/api";

export const getEffectif = async () => {
  try {
    const response = await axios.get(`/statistique/effectif`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getProduitPlusCommande = async (limite) => {
  try {
    const response = await axios.get(`/produit/produit-commande/${limite}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const commandeEvolution = async () => {
  try {
    const response = await axios.get(`/commande/commande-semaine`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getLastCommande = async (limite) => {
  try {
    const response = await axios.get(`/commande/dernier-commande/${limite}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};
