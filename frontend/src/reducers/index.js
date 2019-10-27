import { combineReducers } from "redux";
import { connectRouter } from "connected-react-router";
import auth from "../modules/auth/reducer";
import message from "../modules/message/reducer";

export default history =>
  combineReducers({
    router: connectRouter(history),
    auth,
    message
  });
