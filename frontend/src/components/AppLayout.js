import React from "react";
import { Layout } from "antd";
import PropTypes from "prop-types";
import Header from "./Header";

const { Content } = Layout;

const AppLayout = ({ withHeader, children }) => (
  <Layout>
    {withHeader && (
      <Layout.Header>
        <Header />
      </Layout.Header>
    )}
    <Content style={{ minHeight: "1000px" }}>{children}</Content>
  </Layout>
);

AppLayout.propTypes = {
  withHeader: PropTypes.bool,
  children: PropTypes.object
};

export default AppLayout;
