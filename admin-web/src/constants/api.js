import axios from "axios";

axios.defaults.baseURL = "http://localhost:8000/api/";
axios.defaults.headers.common["Authorization"] = `Bearer ${localStorage.getItem(
  "access_token"
)}`;
axios.defaults.headers.post["Content-Type"] = "multipart/form-data";

axios.interceptors.response.use(
  (response) => response, // Si tout va bien, on renvoie la réponse
  async (error) => {
    const originalRequest = error.config;

    // Éviter les boucles infinies pour le point de terminaison token/refresh/
    if (originalRequest.url === "user/token/refresh/") {
      return Promise.reject(error);
    }

    if (error.response.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true; // On évite les boucles infinies

      try {
        const refresh = localStorage.getItem("refresh_token"); // On récupère le refresh token
        const res = await axios.post("user/token/refresh/", { refresh });

        // Nouveau access_token
        localStorage.setItem("access_token", res.data.access);

        // Mettre à jour les headers
        axios.defaults.headers.common[
          "Authorization"
        ] = `Bearer ${res.data.access}`;
        originalRequest.headers["Authorization"] = `Bearer ${res.data.access}`;

        // Réessayer la requête d’origine
        return axios(originalRequest);
      } catch (refreshError) {
        console.error("Impossible de rafraîchir le token", refreshError);
        localStorage.removeItem("access_token");
        localStorage.removeItem("refresh_token");
        window.location.href = "/login"; // Rediriger vers la page de login
      }
    }

    return Promise.reject(error); // Si autre erreur, on la renvoie
  }
);

export default axios;
