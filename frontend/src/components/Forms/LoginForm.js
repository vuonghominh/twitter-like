import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";
import { Form, Input, Button, Card, message } from "antd";
import { login } from "../../modules/auth/api";

class LoginForm extends Component {
  state = {
    authStep2: false,
    credentials: null
  };

  renderInputsStep1() {
    const { authStep2 } = this.state;
    const {
      form: { getFieldDecorator }
    } = this.props;
    if (authStep2) return null;
    return (
      <Fragment>
        <Form.Item colon={false} required={false}>
          {getFieldDecorator("email", {
            rules: [
              {
                required: true,
                message: "required"
              },
              {
                type: "email",
                message: "invalid"
              }
            ]
          })(<Input size="large" placeholder={"Email"} />)}
        </Form.Item>
        <Form.Item colon={false} required={false}>
          {getFieldDecorator("password", {
            rules: [
              {
                required: true,
                message: "required"
              }
            ]
          })(<Input.Password size="large" placeholder="Password" />)}
        </Form.Item>
      </Fragment>
    );
  }

  renderInputsStep2() {
    const { authStep2 } = this.state;
    const {
      form: { getFieldDecorator }
    } = this.props;
    if (!authStep2) return null;
    return (
      <Fragment>
        <p>Please enter the code from the console</p>
        <Form.Item colon={false} required={false}>
          {getFieldDecorator("code", {
            rules: [
              {
                required: true,
                message: "required"
              }
            ]
          })(<Input size="large" />)}
        </Form.Item>
      </Fragment>
    );
  }

  render() {
    const { authStep2 } = this.state;
    const { loading } = this.props;
    const actions = !authStep2
      ? []
      : [
          <Button type="link" size="small" onClick={this.handleBackToLogin}>
            Back
          </Button>
        ];
    return (
      <Card actions={actions}>
        <Form onSubmit={this.handleSubmit}>
          {this.renderInputsStep1()}
          {this.renderInputsStep2()}
          <Button
            type="primary"
            htmlType="submit"
            size="large"
            style={{ width: "100%" }}
            loading={loading}
          >
            LOGIN
          </Button>
        </Form>
      </Card>
    );
  }

  handleBackToLogin = () => {
    this.setState({ authStep2: false });
  };

  handleSubmit = e => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        const { authStep2, credentials } = this.state;
        if (authStep2) {
          this.props.onSubmit({ ...credentials, ...values });
        } else {
          login(values).then(({ response, error }) => {
            if (error) {
              message.error(error.message);
            } else {
              console.log(response.data.code);
              this.setState({ authStep2: true, credentials: values });
            }
          });
        }
      }
    });
  };
}

LoginForm.propTypes = {
  form: PropTypes.object,
  loading: PropTypes.bool,
  onSubmit: PropTypes.func
};

export default Form.create({ name: "loginForm" })(LoginForm);
