import { useState, useEffect } from "react";
import InputComponent from "./InputComponent";
import { X } from "lucide-react";

function QuantiteComponent({
  closeAction,
  value,
  maxValeur,
  onChange,
  submitAction,
}) {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => setVisible(true), 10);
    return () => clearTimeout(timer);
  }, []);
  return (
    <div
      className={`
        absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-20
        transition-all duration-300 transform
        ${visible ? "opacity-100 scale-100" : "opacity-0 scale-50"}
        `}
    >
      <div className="p-2 w-96 custom-bg shadow-lg rounded-md">
        <form
          action=""
          onSubmit={submitAction}
          className="flex flex-col w-full grid-cols-1 gap-3"
        >
          <div className="relative flex justify-center">
            <X
              onClick={closeAction}
              className="absolute right-0 cursor-pointer hover:scale-105 text-red-500"
            />
            <h2 className="text-2xl font-semibold text-center mt-2">
              Quantité commandé
            </h2>
          </div>
          <div className="flex p-2 w-full justify-center my-2">
            <InputComponent
              label="Quantité"
              type="number"
              value={value}
              minValeur={1}
              onChange={onChange}
              maxValeur={maxValeur}
            />
          </div>
          <div className="text-center my-2">
            <button
              type="submit"
              className="bg-primaire-1 hover:bg-primaire-2 text-theme-light font-semibold px-6 py-2 rounded-md transition duration-200"
            >
              Ajouter à mon panier
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default QuantiteComponent;
