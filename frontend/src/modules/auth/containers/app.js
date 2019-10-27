import React, { Component } from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";

export default function(WrappedComponent) {
  class Container extends Component {
    componentDidMount() {
      if (this.props.authenticated) {
        this.fetchCurrentUser();
      }
    }

    shouldComponentUpdate(nextProps) {
      const { authenticated } = this.props;
      if (
        authenticated !== nextProps.authenticated &&
        nextProps.authenticated
      ) {
        this.fetchCurrentUser();
      }
      return false;
    }

    render() {
      return <WrappedComponent />;
    }

    fetchCurrentUser() {
      console.log("Fetch Current User");
    }
  }

  Container.propTypes = {
    authenticated: PropTypes.bool.isRequired
  };

  return connect(({ auth: { authenticated } }) => ({
    authenticated
  }))(Container);
}
