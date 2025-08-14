import { Navigate } from "react-router-dom";
import { UserProvider } from "../store/UserContext";
import { SearchProvider } from "../store/SearchContext";

const PrivateRoute = ({ children }) => {
  const token = localStorage.getItem("access_token");
  return token ? (
    <UserProvider>
      <SearchProvider>{children}</SearchProvider>
    </UserProvider>
  ) : (
    <Navigate to="/login" />
  );
};

export default PrivateRoute;
