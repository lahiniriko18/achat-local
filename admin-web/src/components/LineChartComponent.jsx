import React from 'react'
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { colors } from '../utils/colors';
const data = [
  { name: 'Jan', ventes: 400 },
  { name: 'Feb', ventes: 300 },
  { name: 'Mar', ventes: 500 },
  { name: 'Apr', ventes: 200 },
  { name: 'May', ventes: 700 },
];

function LineChartComponent() {
  return (
    <ResponsiveContainer >
      <LineChart data={data}>
        <CartesianGrid stroke="#ccc" strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line type="monotone" dataKey="ventes" stroke={colors.primary} strokeWidth={2} />
      </LineChart>
    </ResponsiveContainer>
  );
}

export default LineChartComponent