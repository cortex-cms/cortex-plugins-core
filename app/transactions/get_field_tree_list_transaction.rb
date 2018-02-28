class GetFieldTreeListTransaction < Cortex::ApplicationTransaction
  step :init
  step :process

  def init(input)
    field = Field.find_by_id(input[:args]['field_id'])

    field ? Right({ content_item: input[:content_item], field: field }) : Left(:not_found)
  end

  def process(input)
    tree_array = input[:field].metadata['allowed_values']

    tree_values = input[:content_item].field_items.find {|field_item| field_item.field_id == input[:field].id}.data['values']
    # This will break
    tree_list = tree_values.map {|value| tree_array.find {|node| node['id'] == value.to_i}['node']['name']}.join(',')

    Right(tree_list)
  end
end
