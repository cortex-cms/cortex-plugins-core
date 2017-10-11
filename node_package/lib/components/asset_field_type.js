var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

import React from 'react';

var ToolTip = function ToolTip(_ref) {
  var id = _ref.id,
      tooltip = _ref.tooltip;
  return React.createElement(
    'p',
    null,
    tooltip
  );
};

var allowedExtensions = function allowedExtensions(_ref2) {
  var allowed_extensions = _ref2.allowed_extensions;
  return allowed_extensions === undefined ? '' : allowed_extensions.join(', ');
};
var allowedExtensionsForFor = function allowedExtensionsForFor(_ref3) {
  var allowed_extensions = _ref3.allowed_extensions;
  return allowed_extensions === undefined ? '' : '.' + allowed_extensions.join(',.');
};
var maxFileSize = function maxFileSize(_ref4) {
  var max_size = _ref4.max_size;
  return max_size;
};

var AssetFieldType = function (_React$PureComponent) {
  _inherits(AssetFieldType, _React$PureComponent);

  function AssetFieldType() {
    _classCallCheck(this, AssetFieldType);

    return _possibleConstructorReturn(this, (AssetFieldType.__proto__ || Object.getPrototypeOf(AssetFieldType)).apply(this, arguments));
  }

  _createClass(AssetFieldType, [{
    key: 'render',
    value: function render() {
      var _props = this.props,
          field_item = _props.field_item,
          id = _props.id,
          metadata = _props.metadata,
          _props$required = _props.required,
          required = _props$required === undefined ? false : _props$required,
          name = _props.name,
          validations = _props.validations;

      console.log('AssetFieldType', this.props);
      return React.createElement(
        'div',
        null,
        React.createElement(
          'strong',
          null,
          'Allowed extensions: '
        ),
        allowedExtensions(validations),
        React.createElement('br', null),
        React.createElement(
          'strong',
          null,
          'Allowed filesize: '
        ),
        maxFileSize(validations),
        React.createElement('br', null),
        React.createElement('input', { type: 'hidden', value: id }),
        field_item.tooltip && ToolTip(field_item),
        React.createElement(
          'label',
          null,
          name,
          ' '
        ),
        React.createElement('input', {
          type: 'file',
          accept: allowedExtensionsForFor(validations),
          name: name })
      );
    }
  }]);

  return AssetFieldType;
}(React.PureComponent);

export default AssetFieldType;