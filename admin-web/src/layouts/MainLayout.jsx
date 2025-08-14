import Header from "../components/Header";
import { Outlet } from "react-router-dom";
import SidebarLayout from "./SidebarLayout";

function MainLayout() {
  return (
    <div className="App w-screen h-screen flex overflow-hidden">
      <SidebarLayout />
      <div className="flex flex-1 w-full flex-col overflow-hidden transition-all duration-100">
        <Header />
        <main className="flex-1 w-full overflow-hidden"><Outlet /></main>
      </div>
    </div>
  );
}

export default MainLayout;
