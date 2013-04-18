class Answer < ActiveRecord::Base
  attr_accessible :right, :text, :question, :question_id, :correct

  belongs_to :question, inverse_of: :answers
end
