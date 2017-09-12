import React from 'react'

const ToolTip = ({id, tooltip}) => (<p>{ tooltip }</p>)

const allowedExtensions = ({allowed_extensions}) => allowed_extensions === undefined ? '' : allowed_extensions.join(', ')
const allowedExtensionsForFor = ({allowed_extensions}) => allowed_extensions === undefined ? '' : '.' + allowed_extensions.join(',.')
const maxFileSize = ({max_size}) => max_size

class AssetFieldType extends React.PureComponent {
  render() {
    const { field_item, id, metadata, required=false, name, validations } = this.props
    console.log('AssetFieldType', this.props)
    return (
      <div>
        <strong>Allowed extensions: </strong>
          { allowedExtensions(validations) }
        <br/>
        <strong>Allowed filesize: </strong>
        { maxFileSize(validations) }
        <br />
        <input type='hidden' value={id} />
        { field_item.tooltip && ToolTip(field_item) }
        <label>{ name } </label>
        <input
          type='file'
          accept={ allowedExtensionsForFor(validations) }
          name={name} />
      </div>

    )
  }
}

export default AssetFieldType
