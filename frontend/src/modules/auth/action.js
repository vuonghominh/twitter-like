function action(type, payload = {}) {
  return { type, ...payload };
}

export const AUTH_LOGIN_REQUEST = "AUTH_LOGIN_REQUEST";
export const AUTH_LOGIN_SUCCESS = "AUTH_LOGIN_SUCCESS";
export const AUTH_LOGIN_FAILURE = "AUTH_LOGIN_FAILURE";
export const DO_AUTH_LOGIN = "DO_AUTH_LOGIN";

export const login = {
  request: params => action(AUTH_LOGIN_REQUEST, { params }),
  success: (params, response) =>
    action(AUTH_LOGIN_SUCCESS, { params, response }),
  failure: (params, error) => action(AUTH_LOGIN_FAILURE, { params, error })
};

export const doLogin = params => ({
  type: DO_AUTH_LOGIN,
  params
});

export const AUTH_LOGOUT_REQUEST = "AUTH_LOGOUT_REQUEST";
export const AUTH_LOGOUT_SUCCESS = "AUTH_LOGOUT_SUCCESS";
export const AUTH_LOGOUT_FAILURE = "AUTH_LOGOUT_FAILURE";
export const DO_AUTH_LOGOUT = "DO_AUTH_LOGOUT";

export const logout = {
  request: () => action(AUTH_LOGOUT_REQUEST),
  success: response => action(AUTH_LOGOUT_SUCCESS, { response }),
  failure: error => action(AUTH_LOGOUT_FAILURE, { error })
};

export const doLogout = () => ({
  type: DO_AUTH_LOGOUT
});
