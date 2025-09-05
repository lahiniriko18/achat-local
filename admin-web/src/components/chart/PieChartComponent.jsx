import { Pie, PieChart, ResponsiveContainer, Tooltip } from "recharts";
import { colors } from "../../utils/colors";

export const PieChartComponent = ({ data }) => {
  const chartData = Object.entries(data).map(([key, value]) => ({
    name: key,
    valeur: value,
  }));
  return (
    <ResponsiveContainer width="100%" height="100%">
      <PieChart width={400} height={400}>
        <Pie
          dataKey="valeur"
          data={chartData}
          cx="50%"
          cy="50%"
          //   outerRadius={100}
          fill={colors.primary}
          label
        />
        <Tooltip />
      </PieChart>
    </ResponsiveContainer>
  );
};

export const PieChartProduitCategorie = ({ data }) => {
  const chartData = data.map((item) => ({
    name: item.libelleProduit,
    valeur: item.quantite,
    texte: `${item.quantite} ${item.uniteMesure}`,
  }));
  console.log(chartData);
  return (
    <ResponsiveContainer width="100%" height="100%">
      <PieChart width={400} height={400}>
        <Pie
          dataKey="valeur"
          data={chartData}
          cx="50%"
          cy="50%"
          //   outerRadius={100}
          fill={colors.primary}
          label
          
        />
        <Tooltip />
      </PieChart>
    </ResponsiveContainer>
  );
};
