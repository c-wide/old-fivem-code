import { combineReducers } from 'redux';

import appReducer from 'containers/App/reducer';
import bankReducer from './containers/Bank/reducer';

export default () =>
  combineReducers({
    app: appReducer,
    bank: bankReducer,
  });
