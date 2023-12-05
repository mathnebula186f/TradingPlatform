import React from "react";
import { Link } from "react-router-dom";
import { Menu } from "antd";

import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";

const LeftMenu = ({ mode }) => {
  return (
    <Menu mode={mode}>
      <Link to="/profile"><Menu.Item key="about">My Profile</Menu.Item></Link>
      <WalletSelector/>
    </Menu>
  );
};

export default LeftMenu;