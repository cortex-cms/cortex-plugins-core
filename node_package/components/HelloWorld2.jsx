import React, { PropTypes } from 'react';

const HelloWorld2 = ({ name, updateName }) => (
  <div>
    <h3>
      Hello2, {name}!
    </h3>
    <hr />
    <form >
      <label htmlFor="name">
        Say hello2 to:
      </label>
      <input
        id="name"
        type="text"
        value={name}
        onChange={(e) => updateName(e.target.value)}
      />
    </form>
  </div>
);

HelloWorld2.propTypes = {
  name: PropTypes.string.isRequired,
  updateName: PropTypes.func.isRequired,
};

export default HelloWorld2;
