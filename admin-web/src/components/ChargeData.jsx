import React from "react";
import { Ghost } from "lucide-react";
export const AucunElement = ({ text }) => {
  return (
    <div className="flex items-center gap-2 flex-col">
      <Ghost size={60} />
      <span className="text-lg">{text ?? "Aucun élément"}</span>
    </div>
  );
};

export const Chargement = () => {
  return (
    <div className="flex flex-col items-center gap-2">
      <div className="w-14 h-14 border-3 border-primaire-2 border-t-transparent rounded-full animate-spin"></div>
      <span className="text-lg">Chargement</span>
    </div>
  );
};
