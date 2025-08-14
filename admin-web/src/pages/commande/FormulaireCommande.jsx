import SelectProduit from "./SelectProduit";
import ClientCommande from "./ClientCommande";
import PanierCommande from "./PanierCommande";
import VerificationCommande from "./VerificationCommande";
import { useState } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

function FormulaireCommande() {
  const [produitSelected, setProduitSelected] = useState([]);
  const [client, setClient] = useState({});
  return (
    <Routes>
      <Route
        index
        element={
          <SelectProduit
            produitSelected={produitSelected}
            setProduitSelected={setProduitSelected}
          />
        }
      />
      <Route
        path="client"
        element={<ClientCommande client={client} setClient={setClient} />}
      />
      <Route
        path="panier"
        element={
          <PanierCommande
            produitSelected={produitSelected}
            setProduitSelected={setProduitSelected}
          />
        }
      />
      <Route
        path="verifier"
        element={
          <VerificationCommande
            produitSelected={produitSelected}
            client={client}
          />
        }
      />
    </Routes>
  );
}

export default FormulaireCommande;
