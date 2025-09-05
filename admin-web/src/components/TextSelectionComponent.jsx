function TextSelectionComponent({ nbChecked }) {
  return (
    <span className="absolute left-0 text-sm">
      {nbChecked > 0
        ? `${nbChecked} élèment${nbChecked > 1 ? "s" : ""} sélectionné${
            nbChecked > 1 ? "s" : ""
          }`
        : ""}
    </span>
  );
}

export default TextSelectionComponent;
