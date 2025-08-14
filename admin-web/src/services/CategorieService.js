import axios from "../constants/api";

export const getCategorie = async () => {
  try {
    const response = await axios.get(`/categorie`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getCategorieById = async (numCategorie) => {
  try {
    const response = await axios.get(`/categorie/${numCategorie}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteCategorie = async (id) => {
  try {
    const response = await axios.delete(`/categorie/supprimer/${id}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteMultipleCategorie = async (data) => {
  try {
    const response = await axios.post(`/categorie/supprimer/multiple/`, data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const addCategorie = async (data) => {
  try {
    const response = await axios.post(`/categorie/ajouter/`, data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const updateCategorie = async (formData, numCategorie) => {
  try {
    const response = await axios.put(
      `/categorie/modifier/${numCategorie}`,
      formData
    );
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};
