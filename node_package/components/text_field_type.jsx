import React from 'react'

const ToolTip = ({id, tooltip}) => (
  <div>
    <div className='icon material-icons tooltip-icon' id={id}>help</div>
    <div className='mdl-tooltip mdl-tooltip--large' data-mdl-for={id}>
      {tooltip}
    </div>
  </div>
)

const DefaultRender = ({
  name,
  value = '',
  id,
  field_item,
  required = false
}) => {
  return (
    <div className='mdl-textfield mdl-js-textfield mdl-textfield--floating-label'>
      <input type='hidden' value={id}/>
      <label className='mdl-textfield__label'>{name}</label>
      { field_item.tooltip && ToolTip(field_item) }
      <input defaultValue={value} required={required} className='mdl-textfield__input'/>
    </div>
  )
}

const MultilineRender = ({
  name,
  value = '',
  id,
  field_item,
  required = false
}) => {
  const { display = {} } = field_item
  return (
    <div className='mdl-textfield mdl-js-textfield mdl-textfield--floating-label'>
      <label className='mdl-textfield__label'>{name}</label>
      { field_item.tooltip && ToolTip(field_item) }
      <input type='hidden' value={id}/>
      <textarea required={required} rows={display.rows} className='mdl-textfield__input'>
        {value}
      </textarea>
    </div>
  )
}

const WysiwygRender = ({
  name,
  value = '',
  id,
  field_item,
  required = false
}) => {
  const { display = {}, input_options = {} } = field_item
  return (
    <div className='mdl-textfield mdl-js-textfield'>
      <input type='hidden' value={id}/>
      <textarea required={required} className={`${input_options.classes} wysiwyg_ckeditor`}>
        {value}
      </textarea>
    </div>
  )
}

const RenderMethods = {
  default: DefaultRender,
  multiline_input: MultilineRender,
  wysiwyg: WysiwygRender
}

class TextFieldType extends React.PureComponent {
  render() {
    const { field_item, metadata, validations } = this.props
    const { render_method } = field_item
    console.log('TextFieldType', this.props)
    return render_method ? RenderMethods[render_method](this.props) : RenderMethods.default(this.props)
  }
}

export default TextFieldType
