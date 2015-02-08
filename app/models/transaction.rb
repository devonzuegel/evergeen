class Transaction < ActiveRecord::Base
  include Payola::Sellable

  attr_accessor :name

end
