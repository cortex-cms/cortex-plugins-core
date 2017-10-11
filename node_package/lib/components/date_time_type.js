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

var DateTimeType = function (_React$PureComponent) {
  _inherits(DateTimeType, _React$PureComponent);

  function DateTimeType() {
    _classCallCheck(this, DateTimeType);

    return _possibleConstructorReturn(this, (DateTimeType.__proto__ || Object.getPrototypeOf(DateTimeType)).apply(this, arguments));
  }

  _createClass(DateTimeType, [{
    key: 'render',
    value: function render() {
      var _props = this.props,
          field_item = _props.field_item,
          id = _props.id,
          _props$value = _props.value,
          value = _props$value === undefined ? '' : _props$value,
          metadata = _props.metadata,
          _props$required = _props.required,
          required = _props$required === undefined ? false : _props$required,
          name = _props.name,
          validations = _props.validations;

      console.log('DateTimeType', this.props);
      return React.createElement(
        'div',
        { className: 'mdl-textfield mdl-js-textfield mdl-textfield--floating-label' },
        React.createElement('input', { type: 'hidden', value: id }),
        React.createElement(
          'label',
          { className: 'mdl-textfield__label' },
          name
        ),
        field_item.tooltip && ToolTip(field_item),
        React.createElement('input', { defaultValue: value, required: required, className: 'datepicker mdl-textfield__input' })
      );
    }
  }]);

  return DateTimeType;
}(React.PureComponent);

export default DateTimeType;