# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.string :cpf,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Account
      t.belongs_to :account, null: false, type: :uuid, foreign_key: true, index: true

      t.timestamps null: false
    end

    add_index :users, :cpf, unique: true
  end
end
