import { all, fork } from "redux-saga/effects";
import { doLogin, doLogout } from "../modules/auth/saga";
import { doHandleError } from "../modules/message/saga";

export default function* root() {
  yield all([fork(doLogin), fork(doLogout), fork(doHandleError)]);
}
