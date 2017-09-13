require 'dry/transaction'

class UpdateTagFieldItemTransaction
  include Dry::Transaction

  step :process

  def process(field_item)
    Right(field_item)
  end
end
