import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";
import { colors } from "../../utils/colors";

const dataProduit = [
  { name: "Lundi", commandes: 4 },
  { name: "Mardi", commandes: 10 },
  { name: "Mercredi", commandes: 5 },
  { name: "Jeudi", commandes: 3 },
  { name: "Vendredi", commandes: 7 },
  { name: "Samedi", commandes: 13 },
  { name: "Dimanche", commandes: 10 },
];

export function LineChartComponent({ data }) {
  return (
    <ResponsiveContainer>
      <LineChart data={data}>
        <CartesianGrid stroke="#ccc" strokeDasharray="3 3" />
        <XAxis dataKey="jour" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="nombre"
          stroke={colors.primary}
          strokeWidth={2}
        />
      </LineChart>
    </ResponsiveContainer>
  );
}

export function LineChartProduit() {
  return (
    <ResponsiveContainer>
      <LineChart data={dataProduit}>
        <CartesianGrid stroke="#ccc" strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="commandes"
          stroke={colors.primary}
          strokeWidth={2}
        />
      </LineChart>
    </ResponsiveContainer>
  );
}

export function LineChartCategorie({ data }) {
  const chartData = data.map((item) => ({
    name: item.libelleProduit,
    valeur: item.totalCommandes,
  }));
  return (
    <ResponsiveContainer>
      <LineChart data={chartData}>
        <CartesianGrid stroke="#ccc" strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="valeur"
          stroke={colors.primary}
          strokeWidth={2}
        />
      </LineChart>
    </ResponsiveContainer>
  );
}
