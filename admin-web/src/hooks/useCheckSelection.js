import { useState, useMemo } from "react";

const useCheckSelection = (items = [], key = "id") => {
  const [checkedIds, setCheckedIds] = useState([]);

  const allChecked = useMemo(
    () =>
      items.length > 0 && items.every((item) => checkedIds.includes(item[key])),
    [items, checkedIds, key]
  );

  const nbChecked = checkedIds.length;

  const handleCheck = (id) => {
    setCheckedIds((prev) =>
      prev.includes(id) ? prev.filter((i) => i !== id) : [...prev, id]
    );
  };

  const handleCheckAll = () => {
    const currentIds = items.map((item) => item[key]);
    if (allChecked) {
      setCheckedIds((prev) => prev.filter((id) => !currentIds.includes(id)));
    } else {
      setCheckedIds((prev) => [
        ...prev,
        ...currentIds.filter((id) => !prev.includes(id)),
      ]);
    }
  };

  return {
    checkedIds,
    allChecked,
    nbChecked,
    handleCheck,
    handleCheckAll,
    setCheckedIds,
  };
};

export default useCheckSelection;
