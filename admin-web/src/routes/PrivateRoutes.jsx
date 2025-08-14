import { Route } from "react-router-dom";
import PrivateRoute from "./PrivateRoute";
import MainLayout from "../layouts/MainLayout";
import Accueil from "../pages/Accueil";
import Produit from "../pages/produit/Produit";
import FormulaireProduit from "../pages/produit/FormulaireProduit";
import DetailProduit from "../pages/produit/DetailProduit";
import Client from "../pages/client/Client";
import FormulaireClient from "../pages/client/FormulaireClient";
import DetailClient from "../pages/client/DetailClient";
import Categorie from "../pages/categorie/Categorie";
import FormulaireCategorie from "../pages/categorie/FormulaireCategorie";
import Commande from "../pages/commande/Commande";
import FormulaireCommande from "../pages/commande/FormulaireCommande";
import Statistique from "../pages/Statistique";
import Profile from "../pages/user/Profile";
import UpdateProfil from "../pages/user/UpdateProfil";
import AuthPassword from "../pages/user/AuthPassword";
import ResetPassword from "../pages/user/ResetPassword";
import ChangeUsername from "../pages/user/ChangeUsername";

export default (
  <>
    <Route
      path="/"
      element={
        <PrivateRoute>
          <MainLayout />
        </PrivateRoute>
      }
    >
      <Route index element={<Accueil />} />
      <Route path="/produit">
        <Route index element={<Produit />} />
        <Route path="ajouter" element={<FormulaireProduit />} />
        <Route path="modifier/:numProduit" element={<FormulaireProduit />} />
        <Route path="details/:numProduit" element={<DetailProduit />} />
      </Route>
      <Route path="/client">
        <Route index element={<Client />} />
        <Route path="ajouter" element={<FormulaireClient />} />
        <Route path="modifier/:numClient" element={<FormulaireClient />} />
        <Route path="details/:numClient" element={<DetailClient />} />
      </Route>
      <Route path="/categorie">
        <Route index element={<Categorie />} />
        <Route path="ajouter" element={<FormulaireCategorie />} />
        <Route
          path="modifier/:numCategorie"
          element={<FormulaireCategorie />}
        />
      </Route>
      <Route path="/commande">
        <Route index element={<Commande />} />
        <Route path="ajouter/*" element={<FormulaireCommande />} />
      </Route>
      <Route path="/statistique" element={<Statistique />} />
      <Route path="/profile">
        <Route index element={<Profile />} />
        <Route path="modifier/">
          <Route index element={<UpdateProfil />} />
        </Route>
        <Route path="auth-password/:action" element={<AuthPassword />} />
        <Route path="reset-password/" element={<ResetPassword />} />
        <Route path="change-username/" element={<ChangeUsername />} />
      </Route>
    </Route>
  </>
);
