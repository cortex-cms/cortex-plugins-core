class ContentItemFieldType < FieldType
  def mapping
    { name: mapping_field_name, type: :string, analyzer: :snowball }
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_content_item"
  end
end
