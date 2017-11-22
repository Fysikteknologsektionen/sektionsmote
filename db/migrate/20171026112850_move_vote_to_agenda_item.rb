class MoveVoteToAgendaItem < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:votes, :agenda)
    add_reference(:votes, :agenda_item, foreign_key: true)
  end
end
