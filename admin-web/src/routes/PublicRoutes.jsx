import { Route } from "react-router-dom";
import Login from "../pages/user/Login";
import Sign from "../pages/user/Sign";

export default (
  <>
    <Route path="/login" element={<Login />} />
    <Route path="/sign" element={<Sign />} />
  </>
);
