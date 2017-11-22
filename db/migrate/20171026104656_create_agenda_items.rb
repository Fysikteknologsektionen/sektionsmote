class CreateAgendaItems < ActiveRecord::Migration[5.1]
  def change
    create_table :agenda_items do |t|
      t.string :title, null: false, default: ""
      t.string :data, null: false, default: ""
      t.string :result
      t.references :agenda, foreign_key: true
      t.integer :type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.datetime :deleted_at, index: true
      t.integer :position

      t.timestamps
    end
  end
end
