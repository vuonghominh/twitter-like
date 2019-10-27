import { message } from "antd";
import PropTypes from "prop-types";
import MessageContainer from "../modules/message/container";

const Message = ({ messageId, type }) => {
  message[type](messageId);
  return null;
};

Message.propTypes = {
  messageId: PropTypes.string.isRequired,
  type: PropTypes.oneOf(["error", "success"])
};

export default MessageContainer(Message);
