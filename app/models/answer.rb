class Answer < ActiveRecord::Base
  attr_accessible :right, :text
  belongs_to :question
end
