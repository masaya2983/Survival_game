class Favorit < ApplicationRecord
  belongs_to :customer
  belongs_to :field
  validates_uniqueness_of :field_id, scope: :customer_id
end
