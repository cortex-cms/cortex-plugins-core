var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

import React from 'react';
var ToolTip = function ToolTip(_ref) {
  var id = _ref.id,
      tooltip = _ref.tooltip;
  return React.createElement(
    'div',
    null,
    React.createElement(
      'div',
      { className: 'icon material-icons tooltip-icon', id: id },
      'help'
    ),
    React.createElement(
      'div',
      { className: 'mdl-tooltip mdl-tooltip--large', 'data-mdl-for': id },
      tooltip
    )
  );
};

var TagFieldType = function (_React$PureComponent) {
  _inherits(TagFieldType, _React$PureComponent);

  function TagFieldType() {
    _classCallCheck(this, TagFieldType);

    return _possibleConstructorReturn(this, (TagFieldType.__proto__ || Object.getPrototypeOf(TagFieldType)).apply(this, arguments));
  }

  _createClass(TagFieldType, [{
    key: 'render',
    value: function render() {
      var _props = this.props,
          field_item = _props.field_item,
          id = _props.id,
          metadata = _props.metadata,
          value = _props.value,
          _props$required = _props.required,
          required = _props$required === undefined ? false : _props$required,
          name = _props.name,
          validations = _props.validations;

      console.log('TagFieldType', this.props);
      return React.createElement(
        'div',
        null,
        React.createElement('input', { type: 'hidden', value: id }),
        React.createElement(
          'label',
          { htmlFor: name },
          name
        ),
        field_item.tooltip && ToolTip(field_item),
        React.createElement('br', null),
        React.createElement(
          'span',
          { className: 'cortex-bootstrap' },
          React.createElement('input', {
            className: 'mdl-textfield__input',
            value: value,
            'data-role': 'tagsinput',
            required: required })
        )
      );
    }
  }]);

  return TagFieldType;
}(React.PureComponent);

export default TagFieldType;