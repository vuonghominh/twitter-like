import React, { Component } from "react";
import { connect } from "react-redux";
import { Route, Redirect } from "react-router-dom";
import PropTypes from "prop-types";

class Container extends Component {
  renderContent = p => {
    const {
      auth: { authenticated },
      comp: Comp
    } = this.props;
    if (!authenticated) {
      return (
        <Redirect to={{ pathname: "/login", state: { from: p.location } }} />
      );
    }
    return <Comp {...p} />;
  };

  render() {
    const { auth, comp, ...props } = this.props; // eslint-disable-line no-unused-vars

    return <Route {...props} render={this.renderContent} />;
  }
}

Container.propTypes = {
  auth: PropTypes.object.isRequired,
  comp: PropTypes.object
};

export default connect(state => ({
  auth: state.auth
}))(Container);
