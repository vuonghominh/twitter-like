import request from "../../helpers/request";

export function login(params) {
  return request("/auth/login", {
    method: "POST",
    data: params
  });
}

export function logout() {
  return request("/auth/logout", {
    method: "POST"
  });
}
