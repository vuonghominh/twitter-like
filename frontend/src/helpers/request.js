import axios from "axios";
import { throttleAdapterEnhancer } from "axios-extensions";
import appConfig from "../config/app";

const api = axios.create({
  adapter: throttleAdapterEnhancer(axios.defaults.adapter, {
    threshold: 5 * 1000
  })
});

export default function(endpoint, opts = {}) {
  const { headers, ...options } = opts;
  const config = Object.assign(
    {
      url: endpoint,
      baseURL: appConfig().apiURI,
      headers: Object.assign(
        {
          Accept: "application/json",
          "Cache-Control": "no-cache",
          "Content-Type": "application/json",
          authorization: localStorage.elixirToken
        },
        headers
      ),
      timeout: 60000 // / make it longger for bad internet connection
    },
    options
  );

  return api
    .request(config)
    .then(response => ({ response: response.data }))
    .catch(error => {
      if (error.response) {
        return {
          error: Object.assign(error.response.data, {
            status: error.response.status
          })
        };
      }
      if (error.request && error.request._response) {
        return { error: { message: error.request._response } };
      }
      return { error: { message: error.message } };
    });
}
