class Answer < ActiveRecord::Base
  attr_accessible :right, :text, :question, :quetion_id
  belongs_to :question
end
