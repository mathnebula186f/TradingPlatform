import React, { useState, useEffect } from "react";
import { Layout } from "antd";
import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import { MenuFoldOutlined } from "@ant-design/icons";
import { useLocation, Link } from "react-router-dom";
import Lottie from "react-lottie";
import animationData from "../lottie/Logo.json";

const { Header } = Layout;

function Navbar() {
  const [visible, setVisible] = useState(false);
  const [isSmallScreen, setIsSmallScreen] = useState(
    window.innerWidth < 768
  );
  const lottieOptions = {
    loop: true,
    autoplay: true,
    animationData: animationData,
    rendererSettings: {
      preserveAspectRatio: "xMidYMid slice",
    },
  };

  const showDrawer = () => {
    setVisible(!visible);
  };

  const handleResize = () => {
    setIsSmallScreen(window.innerWidth < 768);
  };

  useEffect(() => {
    window.addEventListener("resize", handleResize);
    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);



  const walletSelectorStyles = {
  backgroundColor: "#4CAF50", // Green background color
  color: "#FFFFFF", // White text color
  "&:hover": {
    backgroundColor: "#45a049", // Darker green hover background color (adjust as needed)
    color: "#FFFFFF", // White hover text color
  },
};
  return (
    <Header
      className="bg-white shadow-md"
      style={{
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        padding: "0 20px",
        height: "80px",
        boxShadow: "0 4px 8px rgba(0, 0, 0, 0.2), 0 2px 4px rgba(0, 0, 0, 0.1)",
      }}
    >
      
      {/* Logo (Lottie Animated Image) */}
      <div className="flex items-center mx-auto flex-shrink-0">
        <div className="w-16 h-16 mr-4">
          <Lottie options={lottieOptions} height={70} width={70} />
        </div>
        <div className="text-gray-800 text-3xl font-bold animate-bounce">AnyTrade</div>
        <div className="w-16 h-16 ml-4">
          <Lottie options={lottieOptions} height={70} width={70} />
        </div>
      </div>
      {/* Wallet Selector */}
      <div className="bg-green-300 text-white p-2 rounded">
      <WalletSelector  />
    </div>
    </Header>
  );
}

export default Navbar;
