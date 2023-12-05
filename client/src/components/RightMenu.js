import React from "react";
import { Menu } from "antd";

import { WalletSelector } from "@aptos-labs/wallet-adapter-ant-design";
import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";

const LeftMenu = ({ mode }) => {
  return (
    <Menu mode={mode}>
      <Menu.Item key="about">My Profile</Menu.Item>
      <WalletSelector/>
    </Menu>
  );
};

export default LeftMenu;