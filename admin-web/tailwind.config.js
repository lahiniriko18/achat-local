/** @type {import('tailwindcss').Config} */
const colors = require('tailwindcss/colors');
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      boxShadow: {
        'my-shadow': '0 5px 30px -3px rgba(0,0,0,0.1)'
      },
      colors: {
        primaire: {
          "1":colors.cyan[600],
          "2":colors.cyan[700]
        }
      }
    },
  },
  plugins: [],
}

