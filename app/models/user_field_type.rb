class UserFieldType < Cortex::FieldType
  attr_accessor :user_id

  validates :user_id, presence: true, if: :validate_presence?
  validate :valid_user_id?

  def elasticsearch_mapping
    { name: mapping_field_name, type: :keyword, index: :not_analyzed }
  end

  def data=(data_hash)
    @user_id = data_hash['user_id']
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['user_id']
    json
  end

  private

  def mapping_field_name
    "#{field_name.parameterize(separator: '_')}_user_id"
  end

  def valid_user_id?
    return true if user_id.nil?

    unless User.exists?(user_id)
      errors.add(:user_id, "does not exist")
      false
    end
  end

  def validate_presence?
    validations.key? :presence
  end
end
