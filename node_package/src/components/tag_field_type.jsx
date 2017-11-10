import React from 'react'
const ToolTip = ({id, tooltip}) => (
  <div>
    <div className='icon material-icons tooltip-icon' id={id}>help</div>
    <div className='mdl-tooltip mdl-tooltip--large' data-mdl-for={id}>
      {tooltip}
    </div>
  </div>
)

class TagFieldType extends React.PureComponent {
  render() {
    const {
      field_item,
      id,
      metadata,
      value,
      required = false,
      name,
      validations
    } = this.props
    console.log('TagFieldType', this.props)
    return (
      <div>
        <input type='hidden' value={id}/>
        <label htmlFor={name}>{name}</label>
        { field_item.tooltip && ToolTip(field_item) }
        <br/>
        <span className='cortex-bootstrap'>
          <input
            className='mdl-textfield__input'
            value={ value }
            data-role='tagsinput'
            required={ required } />
        </span>
      </div>
    )
  }
}

export default TagFieldType
