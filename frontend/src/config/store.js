import { createStore, applyMiddleware } from "redux";
import createSagaMiddleware, { END } from "redux-saga";
import { composeWithDevTools } from "redux-devtools-extension";
import { createBrowserHistory } from "history";
import { routerMiddleware } from "connected-react-router";
import { persistStore, persistReducer } from "redux-persist";
import storage from "redux-persist/lib/storage";
import rootReducer from "../reducers";

const persistConfig = {
  key: "leon-elixir",
  storage,
  whitelist: []
};
const history = createBrowserHistory();
const sagaMiddleware = createSagaMiddleware();
const middlewares = [routerMiddleware(history), sagaMiddleware];
const persistedReducer = persistReducer(persistConfig, rootReducer(history));
const isProd = process.env.NODE_ENV === "production";

export default initialState => {
  const store = createStore(
    persistedReducer,
    initialState,
    isProd
      ? applyMiddleware(...middlewares)
      : composeWithDevTools(applyMiddleware(...middlewares))
  );

  store.runSaga = sagaMiddleware.run;
  store.close = () => store.dispatch(END);

  const persistor = persistStore(store);

  return { store, history, persistor };
};
