/* eslint-disable import/prefer-default-export */

import { HELLO_WORLD2_NAME_UPDATE } from '../constants/helloWorld2Constants';

export var updateName = function updateName(text) {
  return {
    type: HELLO_WORLD2_NAME_UPDATE,
    text: text
  };
};