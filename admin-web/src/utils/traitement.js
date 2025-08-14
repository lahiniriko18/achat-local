export const renameFile = (file) => {
  const extension = file.name.split(".").pop();
  const newFileName = `image_${Date.now()}.${extension}`;
  return new File([file], newFileName, { type: file.type });
};

export const indexImages = (url, images) => {
  images.forEach((image, index) => {
    if (image.nomImage == url) return index;
  });
  return -1;
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
