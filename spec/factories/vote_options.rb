# frozen_string_literal: true

FactoryBot.define do
  factory :vote_option do
    title
    count { 0 }
    vote
  end
end
