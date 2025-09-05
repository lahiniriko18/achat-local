import { Route } from "react-router-dom";
import Login from "../pages/user/Login";
import Sign from "../pages/user/Sign";
import AuthLayout from "../layouts/AuthLayout";

export default (
  <>
    <Route path="/" element={<AuthLayout />}>
      <Route path="/login" element={<Login />} />
      <Route path="/sign" element={<Sign />} />
    </Route>
  </>
);
