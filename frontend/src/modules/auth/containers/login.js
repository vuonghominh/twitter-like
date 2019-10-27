import React, { Component } from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { doLogin } from "../action";

export default function(WrappedComponent) {
  class Container extends Component {
    componentDidMount() {
      if (this.props.authenticated) {
        this.props.history.push("/");
      }
    }

    render() {
      const { isFetching } = this.props;
      return (
        <WrappedComponent loading={isFetching} onSubmit={this.props.doLogin} />
      );
    }
  }

  Container.propTypes = {
    authenticated: PropTypes.bool.isRequired,
    isFetching: PropTypes.bool.isRequired,
    history: PropTypes.object.isRequired,
    doLogin: PropTypes.func.isRequired
  };

  return connect(
    ({ auth: { isFetching, authenticated } }) => ({
      authenticated,
      isFetching
    }),
    {
      doLogin
    }
  )(Container);
}
