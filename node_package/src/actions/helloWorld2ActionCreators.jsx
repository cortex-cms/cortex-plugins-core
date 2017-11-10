/* eslint-disable import/prefer-default-export */

import { HELLO_WORLD2_NAME_UPDATE } from '../constants/helloWorld2Constants';

export const updateName = (text) => ({
  type: HELLO_WORLD2_NAME_UPDATE,
  text,
});
