import axios from "../constants/api";

export const getProduit = async () => {
  try {
    const response = await axios.get("/produit");
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getProduitById = async (numProduit) => {
  try {
    const response = await axios.get(`/produit/${numProduit}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteProduit = async (numProduit) => {
  try {
    const response = await axios.delete(`/produit/supprimer/${numProduit}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteMultipleProduit = async (data) => {
  try {
    const response = await axios.post(`/produit/supprimer/multiple/`, data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const addProduit = async (formData) => {
  try {
    const response = await axios.post(`/produit/ajouter/`, formData);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const updateProduit = async (formData, numProduit) => {
  try {
    const response = await axios.put(
      `/produit/modifier/${numProduit}`,
      formData
    );
    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};
