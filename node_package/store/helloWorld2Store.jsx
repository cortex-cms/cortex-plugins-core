import { createStore } from 'redux';
import helloWorld2Reducer from '../reducers/helloWorld2Reducer';

const configureStore = (railsProps) => (
  createStore(helloWorld2Reducer, railsProps)
);

export default configureStore;
