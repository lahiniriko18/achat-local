function CardEffectif({ icon, text, effectif }) {
  return (
    <div
      className="shadow-md rounded-md p-3 flex items-start justify-between
    transition-all duration-300 hover:scale-105"
    >
      <div className="text-primaire-2">{icon}</div>
      <div className="text-end">
        <h2 className="text-base pb-1">{text}</h2>
        <span className="text-3xl font-semibold">{effectif}</span>
      </div>
    </div>
  );
}

export default CardEffectif;
