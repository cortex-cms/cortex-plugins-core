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

var DefaultRender = function DefaultRender(_ref2) {
  var name = _ref2.name,
      _ref2$value = _ref2.value,
      value = _ref2$value === undefined ? '' : _ref2$value,
      id = _ref2.id,
      field_item = _ref2.field_item,
      _ref2$required = _ref2.required,
      required = _ref2$required === undefined ? false : _ref2$required;

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
    React.createElement('input', { defaultValue: value, required: required, className: 'mdl-textfield__input' })
  );
};

var MultilineRender = function MultilineRender(_ref3) {
  var name = _ref3.name,
      _ref3$value = _ref3.value,
      value = _ref3$value === undefined ? '' : _ref3$value,
      id = _ref3.id,
      field_item = _ref3.field_item,
      _ref3$required = _ref3.required,
      required = _ref3$required === undefined ? false : _ref3$required;
  var _field_item$display = field_item.display,
      display = _field_item$display === undefined ? {} : _field_item$display;

  return React.createElement(
    'div',
    { className: 'mdl-textfield mdl-js-textfield mdl-textfield--floating-label' },
    React.createElement(
      'label',
      { className: 'mdl-textfield__label' },
      name
    ),
    field_item.tooltip && ToolTip(field_item),
    React.createElement('input', { type: 'hidden', value: id }),
    React.createElement(
      'textarea',
      { required: required, rows: display.rows, className: 'mdl-textfield__input' },
      value
    )
  );
};

var WysiwygRender = function WysiwygRender(_ref4) {
  var name = _ref4.name,
      _ref4$value = _ref4.value,
      value = _ref4$value === undefined ? '' : _ref4$value,
      id = _ref4.id,
      field_item = _ref4.field_item,
      _ref4$required = _ref4.required,
      required = _ref4$required === undefined ? false : _ref4$required;
  var _field_item$display2 = field_item.display,
      display = _field_item$display2 === undefined ? {} : _field_item$display2,
      _field_item$input_opt = field_item.input_options,
      input_options = _field_item$input_opt === undefined ? {} : _field_item$input_opt;

  return React.createElement(
    'div',
    { className: 'mdl-textfield mdl-js-textfield' },
    React.createElement('input', { type: 'hidden', value: id }),
    React.createElement(
      'textarea',
      { required: required, className: input_options.classes + ' wysiwyg_ckeditor' },
      value
    )
  );
};

var RenderMethods = {
  default: DefaultRender,
  multiline_input: MultilineRender,
  wysiwyg: WysiwygRender
};

var TextFieldType = function (_React$PureComponent) {
  _inherits(TextFieldType, _React$PureComponent);

  function TextFieldType() {
    _classCallCheck(this, TextFieldType);

    return _possibleConstructorReturn(this, (TextFieldType.__proto__ || Object.getPrototypeOf(TextFieldType)).apply(this, arguments));
  }

  _createClass(TextFieldType, [{
    key: 'render',
    value: function render() {
      var _props = this.props,
          field_item = _props.field_item,
          metadata = _props.metadata,
          validations = _props.validations;
      var render_method = field_item.render_method;

      console.log('TextFieldType', this.props);
      return render_method ? RenderMethods[render_method](this.props) : RenderMethods.default(this.props);
    }
  }]);

  return TextFieldType;
}(React.PureComponent);

export default TextFieldType;