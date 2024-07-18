export const initialState = {
  hidden: true,
  route: 'bank',
};

const appReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'APP_SHOW':
      return { ...state, hidden: false };
    case 'APP_HIDE':
      return { ...state, hidden: true };
    case 'APP_SET_ROUTE':
      return { ...state, route: action.payload.page };
    default:
      return state;
  }
};

export default appReducer;
