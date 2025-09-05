import { useState } from "react";
import { EyeClosed, Eye } from "lucide-react";
import { handleChange } from "../utils/formUtils";

function InputComponent({
  label,
  type = "text",
  name,
  value,
  placeholder,
  minValeur,
  maxValeur,
  erreur,
  required,
  setFormData,
  onChange,
}) {
  const [isCache, setIsCache] = useState(true);

  const togglePassword = () => {
    setIsCache((prev) => !prev);
  };

  return (
    <div className="w-full">
      {label && (
        <label
          htmlFor={name}
          className="block mb-2 font-medium text-base ms-0"
        >
          {label}
        </label>
      )}
      <div className="relative">
        <input
          type={type == "password" ? (isCache ? "password" : "text") : type}
          min={type == "number" ? minValeur ?? 0 : ""}
          max={type == "number" ? maxValeur ?? "" : ""}
          name={name}
          id={name}
          value={value}
          onChange={onChange ?? ((e) => handleChange(e, setFormData))}
          placeholder={placeholder}
          required={required ?? false}
          className={`w-full custom-border custom-bg rounded-md pl-3 ${
            type == "password" ? "pr-10" : "pr-3"
          } py-2 focus:outline-none focus:ring-1 focus:ring-primaire-2
            ${erreur ? "border-red-500" : "border-gray-300"}`}
        />
        {type == "password" && (
          <div
            onClick={() => togglePassword()}
            className="absolute right-2 top-1/2 -translate-y-1/2 cursor-pointer"
          >
            {isCache ? <Eye /> : <EyeClosed />}
          </div>
        )}
      </div>
      {erreur && (
        <p className="text-red-500 italic text-xs mt-1">
          {erreur == "required" ? "Cette champ est obligatoire!" : erreur}
        </p>
      )}
    </div>
  );
}

export default InputComponent;
