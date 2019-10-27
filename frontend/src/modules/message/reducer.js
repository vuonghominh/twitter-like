const initState = {
  error: {}
};

export default function(state = initState, action = {}) {
  switch (action.type) {
    case (action.type.match(/logout/i) || {}).input:
      return initState;
    case (action.type.match(/failure/i) || {}).input:
      return {
        error: action.error
      };
    default:
      return state;
  }
}
