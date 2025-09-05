export const totalMontantCommande = (produitCommande) => {
  return produitCommande.reduce(
    (total, p) => total + p.produit.prixUnitaire * p.quantiteCommande,
    0
  );
};