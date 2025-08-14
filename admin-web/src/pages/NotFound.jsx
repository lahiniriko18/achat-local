import React from "react";

function NotFound() {
  return (
    <div className="w-screen h-screen flex">
      <div className="flex w-full h-full justify-center items-center">
        <div className="flex flex-col items-center">
          <div className="flex items-center">
            <div className="flex flex-col m-3 items-center gap-2 border p-4 rounded-lg shadow animate-bounce">
              <span className="text-primaire-2 font-extrabold text-9xl font-sans">
                404
              </span>
              <p className="text-4xl text-primaire-2 font-sans">Not Found</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default NotFound;
