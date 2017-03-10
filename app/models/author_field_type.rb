class AuthorFieldType < FieldType
  include Devise::Controllers::Helpers

  attr_accessor :author_name
  jsonb_accessor :data, author_name: :string

  validates :author_name, presence: true, if: :validate_presence?

  def data=(data_hash)
    if data_hash.deep_symbolize_keys[:author_name].blank?
      @author_name = current_user.fullname
    else
      @author_name = data_hash.deep_symbolize_keys[:author_name]
    end
  end

  def field_item_as_indexed_json_for_field_type(field_item, options = {})
    json = {}
    json[mapping_field_name] = field_item.data['author_name']
    json
  end

  def mapping
    {author_name: mapping_field_name, type: :string, analyzer: :snowball}
  end

  private

  def mapping_field_name
    "#{field_name.parameterize('_')}_author_name"
  end

  def author_name_present
    errors.add(:author_name, 'must be present') if @author_name.empty?
  end

  def validate_presence?
    @validations.key? :presence
  end
end