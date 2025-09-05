import {
  MapPin,
  MoveLeft,
  PenSquare,
  PhoneIcon,
  PlusCircleIcon,
  Trash2,
  User2,
} from "lucide-react";
import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import defaultUser from "../../assets/user.png";
import useImageManager from "../../hooks/useImageManager";
import { updateProfile } from "../../services/UtilisateurService";
import { useUser } from "../../store/UserContext";
import { handleChange } from "../../utils/formUtils";
import { cleanFormData, validationPhone } from "../../utils/validation";

function UpdateProfil() {
  const navigate = useNavigate();
  const { user, setUser } = useUser();
  const [erreurs, setErreurs] = useState({});
  const {
    imageFile,
    imagePreview,
    fileInputRef,
    handleFileChange,
    removeImage,
    setImagePreview,
    triggerFileInput,
  } = useImageManager();

  const [formData, setFormData] = useState({
    id: "",
    first_name: "",
    last_name: "",
    contact: "",
    adresse: "",
    image: "",
  });

  const handleSubmit = async (e) => {
    e.preventDefault();

    let dataUser = new FormData();
    let newErrors = {};
    if (!validationPhone(formData.contact.trim())) {
      newErrors.contact = "Contact invalide!";
    }
    setErreurs(newErrors);
    if (Object.keys(newErrors).length == 0) {
      dataUser = cleanFormData(formData, ["image"]);
      if (imageFile) {
        dataUser.append("image", imageFile);
      } else {
        if (!imagePreview) {
          dataUser.append("image", "");
        }
      }
      try {
        const dataResponse = await updateProfile(dataUser);
        console.log(dataResponse);
        setUser(dataResponse);
        navigate("/profile", {
          state: {
            successMessage: "Modification avec succès!",
          },
        });
      } catch (erreur) {
        console.error(erreur);
      }
    }
  };

  const chargeData = () => {
    setFormData(user);
    setImagePreview(user.image);
  };

  useEffect(() => {
    chargeData();
  }, []);

  return (
    <div className="flex h-full justify-center p-3">
      <div className="w-full max-h-full overflow-auto md:w-4/5 lg:w-1/2 custom-bg shadow-md rounded-lg p-4">
        <div className="flex flex-col w-full h-full">
          <div className="relative group flex justify-center">
            <Link to="..">
              <MoveLeft className="absolute -left-4 sm:left-0 cursor-pointer hover:scale-105 hover:text-primaire-2" />
            </Link>
            <h2 className="text-xl font-semibold text-center mb-2 ml-3 sm:ml-0">
              Modifier votre profile
            </h2>
          </div>
          <div className="flex flex-1 flex-col w-full mt-3">
            <div className="flex flex-col w-full justify-center items-center">
              <img
                src={imagePreview ?? defaultUser}
                alt=""
                className="h-32 w-32 object-cover rounded-full"
              />
              <div className="flex flex-1 w-full justify-center gap-3 pt-2">
                <input
                  type="file"
                  accept="image/*"
                  ref={fileInputRef}
                  className="hidden"
                  onChange={handleFileChange}
                />
                {imagePreview ? (
                  <PenSquare
                    onClick={triggerFileInput}
                    className="text-gray-500 transition-all duration-300 transform hover:scale-105 cursor-pointer"
                  />
                ) : (
                  <PlusCircleIcon
                    onClick={triggerFileInput}
                    className="text-gray-500 transition-all duration-300 transform hover:scale-105 cursor-pointer"
                  />
                )}
                <Trash2
                  onClick={removeImage}
                  className="text-red-500 transition-all duration-300 transform hover:scale-105 cursor-pointer"
                />
              </div>
            </div>

            <div className="flex w-full py-3">
              <form onSubmit={handleSubmit} className="flex flex-col w-full">
                <div className="flex w-full gap-4">
                  <div className="flex flex-col justify-between">
                    <div className="flex h-12 justify-start items-end">
                      <label
                        htmlFor="first_name"
                        className="text-nowrap hidden sm:flex"
                      >
                        Nom :
                      </label>
                      <User2 className="flex sm:hidden w-6 h-6" />
                    </div>
                    <div className="flex h-12 justify-start items-end">
                      <label
                        htmlFor="last_name"
                        className="text-nowrap hidden sm:flex"
                      >
                        Prénom :
                      </label>
                      <User2 className="flex sm:hidden w-6 h-6" />
                    </div>
                    <div className="flex h-12 justify-start items-end">
                      <label
                        htmlFor="contact"
                        className="text-nowrap hidden sm:flex"
                      >
                        Contact :
                      </label>
                      <PhoneIcon className="flex sm:hidden w-6 h-6" />
                    </div>
                    <div className="flex h-12 justify-start items-end">
                      <label
                        htmlFor="adresse"
                        className="text-nowrap hidden sm:flex"
                      >
                        Adresse :
                      </label>
                      <MapPin className="flex sm:hidden w-6 h-6" />
                    </div>
                  </div>

                  <div className="flex flex-1 flex-col gap-3">
                    <div className="h-12">
                      <input
                        type="text"
                        name="first_name"
                        value={formData.first_name}
                        onChange={(e) => handleChange(e, setFormData)}
                        placeholder="Votre nom"
                        className="w-full h-full border-gray-500 border-b focus:outline-none focus:shadow
                  focus:border-primaire-2 pt-2 text-base bg-font-light dark:bg-font-dark"
                      />
                    </div>
                    <div className="h-12">
                      <input
                        type="text"
                        name="last_name"
                        value={formData.last_name}
                        onChange={(e) => handleChange(e, setFormData)}
                        placeholder="Votre prénom"
                        className="w-full h-full border-gray-500 border-b focus:outline-none focus:shadow
                  focus:border-primaire-2 pt-2 text-base bg-font-light dark:bg-font-dark"
                      />
                    </div>
                    <div className="h-12">
                      <input
                        type="text"
                        name="contact"
                        required
                        value={formData.contact}
                        onChange={(e) => handleChange(e, setFormData)}
                        placeholder="Votre contact"
                        className="w-full h-full border-gray-500 border-b focus:outline-none focus:shadow
                  focus:border-primaire-2 pt-2 text-base bg-font-light dark:bg-font-dark"
                      />
                    </div>
                    <div className="h-12">
                      <input
                        type="text"
                        name="adresse"
                        required
                        value={formData.adresse}
                        onChange={(e) => handleChange(e, setFormData)}
                        placeholder="Votre adresse"
                        className="w-full h-full border-gray-500 border-b focus:outline-none focus:shadow
                  focus:border-primaire-2 pt-2 text-base bg-font-light dark:bg-font-dark"
                      />
                    </div>
                  </div>
                </div>
                <div className="flex w-full justify-center mt-8">
                  <button
                    type="submit"
                    className="text-center w-full sm:w-1/2 rounded-lg bg-primaire-1 transition-all duration-500 hover:bg-primaire-2 
                  shadow-md text-theme-light text-base font-semibold"
                  >
                    Enregistrer
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default UpdateProfil;
