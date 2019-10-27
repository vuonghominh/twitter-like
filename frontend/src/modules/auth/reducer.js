import {
  AUTH_LOGIN_REQUEST,
  AUTH_LOGIN_SUCCESS,
  AUTH_LOGIN_FAILURE
} from "./action";

const initState = {
  isFetching: false,
  role: "admin",
  authenticated: !!localStorage.elixirToken
};

export default function(state = initState, action = {}) {
  switch (action.type) {
    case (action.type.match(/logout_success/i) || {}).input:
    case (action.type.match(/logout_failure/i) || {}).input:
      localStorage.removeItem("elixirToken");
      return {
        ...initState,
        authenticated: false
      };
    case AUTH_LOGIN_REQUEST:
      return {
        ...state,
        authenticated: false,
        isFetching: true
      };
    case AUTH_LOGIN_FAILURE:
      return {
        ...state,
        authenticated: false,
        isFetching: false
      };
    case AUTH_LOGIN_SUCCESS:
      if (action.response.data.token) {
        localStorage.setItem("elixirToken", action.response.data.token);
      }
      return {
        ...state,
        authenticated: !!localStorage.elixirToken,
        isFetching: false
      };
    default:
      return state;
  }
}
