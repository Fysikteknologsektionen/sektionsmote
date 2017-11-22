# frozen_string_literal: true

# An agenda item for displaying the meeting agenda.
class Agenda < ApplicationRecord
  acts_as_paranoid
  acts_as_list(scope: [deleted_at: nil])
  has_many :bullets, -> { position }, dependent: :destroy,
                                      inverse_of: :agenda
  has_many :votes, through: :bullets
  has_many :documents, through: :bullets

  validates :title, presence: true

  scope(:position, -> { order(:position) })

  def self.now
    Agenda.first
  end

  def current?
    true
  end

  def to_s
    "§#{position} #{title}"
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
