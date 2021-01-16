# frozen_string_literal: true

class Language::Lesson::Member < ApplicationRecord
  include AASM
  include Language::Lesson::MemberRepository

  belongs_to :user
  belongs_to :language
  belongs_to :lesson

  aasm :state do
    state :started, initial: true
    state :finished

    event :finish do
      transitions from: %i[started finished], to: :finished
    end
  end
end
