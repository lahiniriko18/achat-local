import React from "react";
import { Outlet } from "react-router-dom";
function AuthLayout() {
  return (
    <div className="h-screen custom-bg w-screen flex items-center
    justify-center text-theme-dark dark:text-theme-light font-body">
      <Outlet />
    </div>
  );
}

export default AuthLayout;
