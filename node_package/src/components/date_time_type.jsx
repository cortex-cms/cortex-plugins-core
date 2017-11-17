import React from 'react'
const ToolTip = ({id, tooltip}) => (
  <div>
    <div className='icon material-icons tooltip-icon' id={id}>help</div>
    <div className='mdl-tooltip mdl-tooltip--large' data-mdl-for={id}>
      {tooltip}
    </div>
  </div>
)

class DateTimeType extends React.PureComponent {
  render() {
    const {
      field_item,
      id,
      value = '',
      metadata,
      required = false,
      name,
      validations
    } = this.props
    console.log('DateTimeType', this.props)
    return (
      <div className='mdl-textfield mdl-js-textfield mdl-textfield--floating-label'>
        <input type='hidden' value={id}/>
        <label className='mdl-textfield__label'>{name}</label>
        {field_item.tooltip && ToolTip(field_item)}
        <input defaultValue={value} required={required} className='datepicker mdl-textfield__input'/>
      </div>

    )
  }
}

export default DateTimeType
