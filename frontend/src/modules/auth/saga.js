import { take, put, fork, call } from "redux-saga/effects";
import { push } from "connected-react-router";
import * as api from "./api";
import * as action from "./action";

function* login(params) {
  yield put(action.login.request(params));
  const { response, error } = yield call(api.login, params);
  if (response) {
    yield put(action.login.success(params, response));
    yield put(push("/"));
  } else {
    yield put(action.login.failure(params, error));
  }
}

export function* doLogin() {
  while (true) {
    const { params } = yield take(action.DO_AUTH_LOGIN);

    yield fork(login, params);
  }
}

function* logout() {
  yield put(action.logout.request());
  const { response, error } = yield call(api.logout);
  if (response) {
    yield put(action.logout.success(response));
  } else {
    yield put(action.logout.failure(error));
  }
  yield put(push("/login"));
}

export function* doLogout() {
  while (true) {
    yield take(action.DO_AUTH_LOGOUT);
    yield fork(logout);
  }
}
