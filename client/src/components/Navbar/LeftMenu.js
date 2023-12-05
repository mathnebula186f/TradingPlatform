import React from "react";
import { Menu } from "antd";

const LeftMenu = ({ mode }) => {
  return (
    <Menu mode={mode}>
      <Menu.Item key="explore">Explore</Menu.Item>
      <Menu.Item key="features">Features</Menu.Item>
    </Menu>
  );
};

export default LeftMenu;