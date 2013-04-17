class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy, inverse_of: :question

  accepts_nested_attributes_for :answers, allow_destroy: true

  attr_accessible :text, :anwers_attributes, :question_ids

  scope :search, ->(text) { where('text like ?', "%#{text}%") }

  rails_admin do
    configure :answers do

    end
    list do
      field :text
    end
    edit do
      field :text
      field :answers
    end
  end

end
