import axios from "../constants/api";

export const getClient = async () => {
  try {
    const response = await axios.get(`/client`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const getClientById = async (numClient) => {
  try {
    const response = await axios.get(`/client/${numClient}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteClient = async (id) => {
  try {
    const response = await axios.delete(`/client/supprimer/${id}`);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const deleteMultipleClient = async (data) => {
  try {
    const response = await axios.post(`/client/supprimer/multiple/`, data);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const addClient = async (data) => {
  try {
    const response = await axios.post(`/client/ajouter/`, data, {});
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};

export const updateClient = async (formData, numClient) => {
  try {
    const response = await axios.put(`/client/modifier/${numClient}`, formData);
    return response.data;
  } catch (error) {
    console.error(error.response.data);
    throw error;
  }
};
