import React from 'react';
import { Provider } from 'react-redux';

import configureStore from '../store/helloWorld2Store';
import HelloWorld2Container from '../containers/HelloWorld2Container';

// See documentation for https://github.com/reactjs/react-redux.
// This is how you get props from the Rails view into the redux store.
// This code here binds your smart component to the redux store.
// railsContext provides contextual information especially useful for server rendering, such as
// knowing the locale. See the React on Rails documentation for more info on the railsContext
var HelloWorld2App = function HelloWorld2App(props, _railsContext) {
  return React.createElement(
    Provider,
    { store: configureStore(props) },
    React.createElement(HelloWorld2Container, null)
  );
};

export default HelloWorld2App;