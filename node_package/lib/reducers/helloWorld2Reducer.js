import { combineReducers } from 'redux';
import { HELLO_WORLD2_NAME_UPDATE } from '../constants/helloWorld2Constants';

var name = function name() {
  var state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '';
  var action = arguments[1];

  switch (action.type) {
    case HELLO_WORLD2_NAME_UPDATE:
      return action.text;
    default:
      return state;
  }
};

var helloWorld2Reducer = combineReducers({ name: name });

export default helloWorld2Reducer;