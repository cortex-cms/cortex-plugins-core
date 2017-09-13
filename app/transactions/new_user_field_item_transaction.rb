require 'dry/transaction'

class NewUserFieldItemTransaction
  include Dry::Transaction

  step :process

  def process(field_item)
    Right(field_item)
  end
end
