/** @type {import('tailwindcss').Config} */
const colors = require("tailwindcss/colors");
export default {
  darkMode: "class",
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      boxShadow: {
        "my-shadow": "0 5px 30px -3px rgba(0,0,0,0.1)",
      },
      colors: {
        primaire: {
          1: colors.cyan[600],
          2: colors.cyan[700],
        },
        theme: {
          dark: colors.gray[800],
          light: colors.gray[300],
        },
        font: {
          dark: colors.gray[900],
          light: colors.white,
        },
      },
      fontFamily: {
        body: ["Montserrat"],
      },
    },
  },
  plugins: [],
};
