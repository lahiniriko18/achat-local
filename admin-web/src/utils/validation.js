export const validationEmail = (email) => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
};

export const validationPhone = (phone) => {
  const cleanedPhone = phone.replaceAll(" ", "");
  const regex = /^(?:\+261|0)[1-9]\d{8}$/;
  return regex.test(cleanedPhone);
};

export const validationPassword = (mdp) => {
  const regex = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
  return regex.test(mdp);
};

export const cleanFormData = (formData, listImage = [], exceptions = []) => {
  const cleaned = new FormData();

  Object.entries(formData).forEach(([key, value]) => {
    if (exceptions.includes(key)) {
      cleaned.append(key, String(value));
    } else {
      if (listImage.includes(key)) {
        if (typeof value === "object" && value instanceof File) {
          cleaned.append(key, value);
        }
      } else if (value == null || value == undefined) {
        cleaned.append(key, "");
      } else {
        cleaned.append(key, String(value).trim());
      }
    }
  });
  return cleaned;
};
