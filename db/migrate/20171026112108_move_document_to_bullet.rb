class MoveDocumentToBullet < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:documents, :user)
    remove_reference(:documents, :agenda)
    add_reference(:documents, :bullet, foreign_key: true)
  end
end
