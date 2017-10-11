import { createStore } from 'redux';
import helloWorld2Reducer from '../reducers/helloWorld2Reducer';

var configureStore = function configureStore(railsProps) {
  return createStore(helloWorld2Reducer, railsProps);
};

export default configureStore;