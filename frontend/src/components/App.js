import React, { Fragment } from "react";
import { Route, Switch } from "react-router-dom";

import LoginPage from "./Pages/LoginPage";
import LogoutPage from "./Pages/LogoutPage";
import HomePage from "./Pages/HomePage";
import E404Page from "./Pages/E404Page";
import Message from "./Message";
import {
  RouteContainer as PrivateRoute,
  AppContainer
} from "../modules/auth/containers";

const App = () => (
  <Fragment>
    <Message />
    <Switch>
      <Route exact path="/login">
        <LoginPage />
      </Route>
      <Route exact path="/logout">
        <LogoutPage />
      </Route>
      <PrivateRoute exact path="/" comp={HomePage} />
      <Route path="*" component={E404Page} />
    </Switch>
  </Fragment>
);

export default AppContainer(App);
