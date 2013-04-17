class Question < ActiveRecord::Base
  attr_accessible :text
  has_many :answers

  scope :search, ->(text) { where('text like ?', "%#{text}%") }


end
