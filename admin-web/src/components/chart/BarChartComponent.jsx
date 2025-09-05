import React from "react";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";
import { colors } from "../../utils/colors";

function BarChartComponent({ data }) {
  const chartData = Object.entries(data).map(([key, value]) => ({
    name: key,
    valeur: value,
  }));

  return (
    <ResponsiveContainer>
      <BarChart data={chartData}>
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Bar dataKey="valeur" fill={colors.primary} />
      </BarChart>
    </ResponsiveContainer>
  );
}

export default BarChartComponent;
