import { Route } from "react-router-dom";
import MainLayout from "../layouts/MainLayout";
import Accueil from "../pages/Accueil";
import Categorie from "../pages/categorie/Categorie";
import DetailCategorie from "../pages/categorie/DetailCategorie";
import FormulaireCategorie from "../pages/categorie/FormulaireCategorie";
import Client from "../pages/client/Client";
import DetailClient from "../pages/client/DetailClient";
import FormulaireClient from "../pages/client/FormulaireClient";
import Commande from "../pages/commande/Commande";
import FormulaireCommande from "../pages/commande/FormulaireCommande";
import Historique from "../pages/Historique";
import DetailProduit from "../pages/produit/DetailProduit";
import FormulaireProduit from "../pages/produit/FormulaireProduit";
import Produit from "../pages/produit/Produit";
import Statistique from "../pages/Statistique";
import AuthPassword from "../pages/user/AuthPassword";
import ChangeUsername from "../pages/user/ChangeUsername";
import Profile from "../pages/user/Profile";
import ResetPassword from "../pages/user/ResetPassword";
import UpdateProfil from "../pages/user/UpdateProfil";
import PrivateRoute from "./PrivateRoute";

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
        <Route path="details/:numCategorie" element={<DetailCategorie />} />
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
      <Route path="historique/*" element={<Historique />} />
    </Route>
  </>
);
