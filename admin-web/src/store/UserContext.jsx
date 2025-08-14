import { createContext, useContext } from "react";
import useProfiles from "../hooks/useProfiles";

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const { user, setUser } = useProfiles();

  return (
    <UserContext.Provider value={{ user, setUser }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => useContext(UserContext);
