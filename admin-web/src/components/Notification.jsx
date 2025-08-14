import React, { useEffect, useState } from "react";
import { X } from "lucide-react";
export default function SuccessToast({ message, duration = 4000, onClose }) {
  const [progress, setProgress] = useState(100);
  const [isClose, setIsClose] = useState(false);

  const closeToast = () => {
    setIsClose(true);
    setTimeout(() => {
      onClose && onClose();
    }, 500);
  };
  useEffect(() => {
    if (duration <= 0) return;

    const interval = 10;
    const decrement = 100 / (duration / interval);

    const timer = setInterval(() => {
      setProgress((old) => {
        if (old <= 0) {
          clearInterval(timer);
          setIsClose(true);
          setTimeout(() => {
            onClose && onClose();
          }, 500);
          return 0;
        }
        return old - decrement;
      });
    }, interval);

    return () => clearInterval(timer);
  }, [duration, onClose]);

  return (
    <div
      className={`fixed bottom-5  w-80 bg-white border rounded shadow 
    font-sans select-none pointer-events-auto
    transition-all duration-500 ease-in-out ${
      isClose ? "-right-full" : "right-5"
    }
        `}
    >
      <div className="flex items-center p-4 space-x-3">
        <svg
          className="w-6 h-6 text-green-600"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          viewBox="0 0 24 24"
        >
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            d="M5 13l4 4L19 7"
          />
        </svg>
        <p className="flex-1 text-sm text-center text-wrap">{message}</p>
        <X
          onClick={() => closeToast()}
          className="cursor-pointer text-gray-700 hover:scale-110"
        />
      </div>
      <div
        className="h-1 bg-green-600 rounded-b transition-all ease-linear"
        style={{ width: `${progress}%` }}
      ></div>
    </div>
  );
}
