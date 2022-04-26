class CreateExcerpts < ActiveRecord::Migration[5.2]
  def change
    create_table :excerpts, id: :uuid do |t|
      t.belongs_to :account, null: false, type: :uuid, foreign_key: true, index: true
      t.float :balance
      t.string :type_transaction
      t.timestamps
    end
  end
end
