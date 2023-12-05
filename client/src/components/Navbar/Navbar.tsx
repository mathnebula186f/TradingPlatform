import React, { useState, useEffect } from "react";
import { Layout, Button, Drawer } from "antd";
import LeftMenu from "./LeftMenu";
import RightMenu from "./RightMenu";
import { MenuFoldOutlined } from "@ant-design/icons";
import { useLocation, Link } from "react-router-dom";
import "./navbar.css";

function Navbar() {
  const [visible, setVisible] = useState(false);
  const [isSmallScreen, setIsSmallScreen] = useState(window.innerWidth < 768);

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

  return (
    <nav className="navbar">
      <Layout>
        <Layout.Header className="nav-header">
          <div className="logo">
            <Link to="/"><h3 className="brand-font">OurToDoList</h3></Link>
          </div>
          <div className="navbar-menu">
            <div className="leftMenu">
              {!isSmallScreen && <LeftMenu mode="horizontal" />}
            </div>
            {isSmallScreen ? (
              <Button className="menuButton" type="text" onClick={showDrawer}>
                <MenuFoldOutlined />
              </Button>
            ) : null}
            <div className="rightMenu">
              {!isSmallScreen && <RightMenu mode="horizontal" />}
            </div>

            {isSmallScreen && (
              <Drawer
                title={"OurToDoList"}
                placement="right"
                closable={true}
                onClose={showDrawer}
                visible={visible}
                style={{ zIndex: 99999 }}
              >
                <LeftMenu mode={"inline"} />
                <RightMenu mode={"inline"} />
              </Drawer>
            )}
          </div>
        </Layout.Header>
      </Layout>
    </nav>
  );
}

export default Navbar;
