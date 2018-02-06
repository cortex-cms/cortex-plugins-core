class UpdateTagFieldItemTransaction < Cortex::ApplicationTransaction
  step :process

  def process(field_item)
    Right(field_item)
  end
end
