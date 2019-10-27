import React, { Component } from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";

export default function(WrappedComponent) {
  class Container extends Component {
    shouldComponentUpdate(nextProps) {
      const { error } = this.props;
      if (error !== nextProps.error) {
        return true;
      }
      return false;
    }

    render() {
      const { error } = this.props;
      if (error && error.message) {
        return <WrappedComponent messageId={error.message} type="error" />;
      }
      return null;
    }
  }

  Container.propTypes = {
    error: PropTypes.object.isRequired
  };

  return connect(({ message: { error } }) => ({
    error
  }))(Container);
}
