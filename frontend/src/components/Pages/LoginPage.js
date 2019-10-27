import React, { Fragment } from "react";
import { Row, Col } from "antd";
import AppLayout from "../AppLayout";
import LoginForm from "../Forms/LoginForm";
import { LoginContainer } from "../../modules/auth/containers";

const Auth = LoginContainer(LoginForm);

const LoginPage = props => (
  <AppLayout>
    <Fragment>
      <br />
      <Row>
        <Col span={6} offset={9}>
          <Auth {...props} />
        </Col>
      </Row>
    </Fragment>
  </AppLayout>
);

export default LoginPage;
