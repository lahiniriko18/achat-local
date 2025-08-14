import React from "react";
import { X } from "lucide-react";
import { useEffect,useState } from "react";

function Confirmation({title, text, textButton, closeAction, confirmAction}) {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => setVisible(true), 10);
    return () => clearTimeout(timer);
  }, []);
  return (
    <div className={`
    absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-20
    transition-all duration-300 transform
    ${visible ? "opacity-100 scale-100":"opacity-0 scale-50"}
    `}>
      <div className="p-2 w-96 bg-white shadow-lg rounded-md">
        <div className="grid grid-cols-1 gap-3">
          <div className="relative flex justify-center">
            <X
              onClick={closeAction}
              className="absolute right-0 cursor-pointer hover:scale-105 text-red-500"
            />
            <h2 className="text-2xl font-semibold text-center mt-2">
              {title ?? 'Confirmation'}
            </h2>
          </div>
          <div className="flex justify-center my-2">
            <span className="text-wrap text-center">{text ?? 'Ete-vous sûre ?'}</span>
          </div>
          <div className="text-center my-2">
            <button
              type="button"
              onClick={confirmAction}
              className="bg-primaire-1 hover:bg-primaire-2 text-white font-semibold px-6 py-2 rounded-md transition duration-200"
            >
              {textButton ?? 'Supprimer'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Confirmation;
