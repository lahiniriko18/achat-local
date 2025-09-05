export const renameFile = (file) => {
  const extension = file.name.split(".").pop();
  const newFileName = `image_${Date.now()}.${extension}`;
  return new File([file], newFileName, { type: file.type });
};

export const indexImages = (url, images) => {
  let indexFind = -1;
  images.forEach((image, index) => {
    if (image.nomImage == url) {
      indexFind = index;
      return indexFind;
    }
  });
  return indexFind;
};

export const isSelected = (produits, produit) => {
  return produits.some((p) => p.numProduit === produit.numProduit);
};

export const dictToFormData = (dictionnaire) => {
  let data = new FormData();
  Object.entries(dictionnaire).forEach(([cle, valeur]) => {
    data.append(cle, valeur);
  });
  return data;
};
