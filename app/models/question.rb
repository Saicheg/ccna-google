class Question < ActiveRecord::Base
  attr_accessible :text
  has_many :answers
end
