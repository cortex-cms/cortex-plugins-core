require 'dry/transaction'

class NewTagFieldItemTransaction
  include Dry::Transaction

  step :process

  def process(field_item)
    Right(field_item)
  end
end
