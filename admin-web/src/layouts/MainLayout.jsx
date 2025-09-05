import Header from "../components/Header";
import { Outlet } from "react-router-dom";
import SidebarLayout from "./SidebarLayout";
import CustomCloseButton from "../components/CustomCloseButton";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import "react-toastify/dist/ReactToastify.css";

function MainLayout() {
  return (
    <div
      className={`App w-screen h-screen flex overflow-hidden font-body
        custom-bg text-theme-dark dark:text-theme-light`}
    >
      <SidebarLayout />
      <div className="flex flex-1 w-full flex-col overflow-hidden transition-all duration-100">
        <Header />
        <main className="flex-1 w-full overflow-hidden">
          <Outlet />
        </main>
      </div>
      <ToastContainer
        position="bottom-right"
        autoClose={3000}
        hideProgressBar={false}
        newestOnTop={true}
        closeOnClick
        pauseOnHover
        closeButton={CustomCloseButton}
      />
    </div>
  );
}

export default MainLayout;
