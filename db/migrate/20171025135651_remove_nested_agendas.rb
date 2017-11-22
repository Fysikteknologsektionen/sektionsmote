class RemoveNestedAgendas < ActiveRecord::Migration[5.1]
  def change
    remove_column(:agendas, :parent_id, :integer, index: true)
    remove_column(:agendas, :short, :string)
    remove_column(:agendas, :sort_index, :string)
    remove_column(:agendas, :status, :integer, default: 0, null: false)
    remove_column(:agendas, :index, :integer, default: 1)
    add_column(:agendas, :position, :integer)
  end
end
