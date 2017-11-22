class MoveAdjustmentToAgendaItem < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:adjustments, :agenda)
    add_reference(:adjustments, :agenda_item, foreign_key: true)
  end
end
