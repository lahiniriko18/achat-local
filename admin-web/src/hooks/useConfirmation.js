import { useState } from "react";

const useConfirmation = () => {
  const [showConfirmation, setShowConfirmation] = useState(false);
  const hideModal = () => {
    setShowConfirmation(false);
  };
  const confirmation = () => {
    setShowConfirmation(true);
  };

  return { showConfirmation, setShowConfirmation, hideModal, confirmation };
};

export default useConfirmation;
