import { Component } from "react";
import { connect } from "react-redux";
import PropTypes from "prop-types";
import { doLogout } from "../action";

class Container extends Component {
  componentDidMount() {
    this.props.doLogout();
  }

  render() {
    return null;
  }
}

Container.propTypes = {
  doLogout: PropTypes.func.isRequired
};

export default connect(
  null,
  {
    doLogout
  }
)(Container);
