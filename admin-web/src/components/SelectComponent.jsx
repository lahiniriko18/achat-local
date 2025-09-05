import { handleChange } from "../utils/formUtils";

function SelectComponent({
  label,
  name,
  value,
  options,
  erreur,
  defaultValeur,
  setFormData,
  onChange,
}) {
  return (
    <div>
      {label && (
        <label
          htmlFor={name}
          className="block mb-1 font-medium text-base ms-0"
        >
          {label}
        </label>
      )}
      <select
        name={name}
        value={value}
        onChange={onChange ?? ((e) => handleChange(e, setFormData))}
        className="w-full custom-border custom-bg rounded-md px-3 py-2 focus:outline-none focus:ring-1 focus:ring-primaire-2"
      >
        <option value="">
          {defaultValeur ?? "-- Choisir une catégorie --"}
        </option>
        {Object.entries(options).map(([key, value]) => (
          <option key={key} value={key}>
            {value}
          </option>
        ))}
      </select>
      {erreur && (
        <p className="text-red-500 italic text-xs mt-1">
          {erreur == "required" ? "Cette champ est obligatoire!" : erreur}
        </p>
      )}
    </div>
  );
}

export default SelectComponent;
