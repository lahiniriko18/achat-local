# 🌐 Multi-Platforme application (React + Django + Flutter)

Ce projet est composé de trois parties :
1. **Admin Web** – Application React (Vite + TailwindCSS)
2. **Backend** – API Django REST Framework
3. **Mobile** – Application Flutter

---

## 📂 Structure du projet
├── admin-web/ # Frontend React (interface d'administration)
├── backend/ # Backend Django + API REST
├── mobile/ # Application mobile Flutter
├── package.json # Configurations Node.js globales (si nécessaires)
├── README.md # Documentation
└── .gitignore



---

## ⚙️ 1. Installation et exécution

### 1️⃣ Admin Web (React)
**Prérequis** : Node.js ≥ 18, npm ou yarn

```bash
cd admin-web
npm install
npm run dev 
npm run build 


cd backend
python -m venv venv
source venv/bin/activate
venv\Scripts\activate

pip install -r requirements.txt
python manage.py migrate
python manage.py runserver


cd mobile
flutter pub get
flutter run
