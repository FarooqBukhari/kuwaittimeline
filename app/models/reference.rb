class Reference < ApplicationRecord
  belongs_to :post

  validates_presence_of :reference_url
end
