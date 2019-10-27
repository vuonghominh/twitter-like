import { take, put, fork } from "redux-saga/effects";
import { push } from "connected-react-router";

const FAILURE = /_failure$/i;

function* handleError(error) {
  if (error.status === 401) {
    yield put(push("/logout"));
  }
}

export function* doHandleError() {
  while (true) {
    const { error } = yield take(a => FAILURE.test(a.type));

    yield fork(handleError, error);
  }
}
