import React from "react";

function Modal({action}) {
  return (
    <div 
    onClick={action}
    className="fixed inset-0 bg-black opacity-10 z-10"
    >
    </div>
  );
}

export default Modal;
