class NewUserFieldItemTransaction < Cortex::ApplicationTransaction
  step :process

  def process(field_item)
    Success(field_item)
  end
end
