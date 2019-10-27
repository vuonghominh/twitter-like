import React, { Component } from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { doLogin } from "./action";

export default function(WrappedComponent) {
  class Container extends Component {
    render() {
      const { isFetching } = this.props;
      return (
        <WrappedComponent loading={isFetching} onSubmit={this.props.doLogin} />
      );
    }
  }

  Container.propTypes = {
    isFetching: PropTypes.bool.isRequired,
    doLogin: PropTypes.func.isRequired
  };

  return connect(
    ({ auth: { isFetching } }) => ({
      isFetching
    }),
    {
      doLogin
    }
  )(Container);
}
