import axios from "../constants/api";

export const signIn = async (username, password) => {
  try {
    const response = await axios.post("/user/connexion/", {
      username,
      password,
    });
    const { access, refresh } = response.data;

    localStorage.setItem("access_token", access);
    localStorage.setItem("refresh_token", refresh);

    axios.defaults.headers.common["Authorization"] = `Bearer ${access}`;
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
};

export const logout = async () => {
  try {
    const refresh = localStorage.getItem("refresh_token");
    await axios.post("/user/deconnexion/", { refresh });

    localStorage.removeItem("access_token");
    localStorage.removeItem("refresh_token");
    delete axios.defaults.headers.common["Authorization"];
  } catch (error) {
    console.error("Erreur :" + error.response?.data);
    throw error.response?.data?.detail || "Erreur inconnue";
  }
};

export const profile = async () => {
  try {
    const response = await axios.get("/user/profile/");
    return response.data;
  } catch (error) {
    console.error("Erreur :" + error.response?.data);
    throw error.response?.data?.detail || "Erreur inconnue";
  }
};

export const updateProfile = async (data) => {
  try {
    const response = await axios.put("/user/modifier-profile/", data);
    return response.data;
  } catch (error) {
    console.error("Erreur :" + error.response?.data);
    throw error.response?.data?.detail || "Erreur inconnue";
  }
};

export const signUp = async (data) => {
  try {
    const response = await axios.post("/user/inscription/", data);
    return response.data;
  } catch (error) {
    console.error("Erreur :" + error.response?.data);
    throw error.response?.data?.detail || "Erreur inconnue";
  }
};

export const verifyPassword = async (password) => {
  try {
    const response = await axios.post("/user/verify-password/", { password });
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
};

export const validationCode = async () => {
  try {
    const response = await axios.post("/user/validation-code/");
    if (response.status !== 200) {
      throw response.data.error;
    }
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
};

export const resetPassword = async (password) => {
  try {
    const response = await axios.post("/user/reset-password/", { password });
    if (response.status !== 200) {
      throw response.data.error;
    }
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
};

export const changeUsername = async (username) => {
  try {
    const response = await axios.post("/user/change-username/", { username });
    if (response.status !== 200) {
      throw response.data.error;
    }
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
};
