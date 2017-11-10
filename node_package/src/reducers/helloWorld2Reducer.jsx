import { combineReducers } from 'redux';
import { HELLO_WORLD2_NAME_UPDATE } from '../constants/helloWorld2Constants';

const name = (state = '', action) => {
  switch (action.type) {
    case HELLO_WORLD2_NAME_UPDATE:
      return action.text;
    default:
      return state;
  }
};

const helloWorld2Reducer = combineReducers({ name });

export default helloWorld2Reducer;
