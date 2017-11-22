# frozen_string_literal: true

# Connects announcement to an Agenda
class Bullet < ApplicationRecord
  acts_as_paranoid
  acts_as_list(scope: [:agenda_id, deleted_at: nil])
  belongs_to :agenda, inverse_of: :bullets
  has_many :documents, dependent: :destroy
  has_many :votes, dependent: :destroy
  self.inheritance_column = :_type_disabled

  enum(status: { future: 0, current: 5, closed: 10 })
  enum(type: { announcement: 0, decision: 5, election: 10 })
  # Announcement: `data` is not used.
  # Election: `title` is used as the title of the position,
  #           `data` for candidates
  # Decision: `data` is used as the title for the decision, e.g. in a vote
  # Example uses:
  # Announcement for e.g. `Messages`
  # Decision for a `Motion`
  # Election for a `Election of President, candidates: [Jakob, David]`

  validates(:title, :type, presence: true)
  scope(:position, -> { order(:position) })

  def to_s
    "§#{agenda.position}.#{position} #{title}"
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def table_form_partial
    '/admin/bullets/form'
  end
end
