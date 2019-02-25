# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      ## Database authenticatable
      t.string :task,              null: false, default: ""
      t.string :task_desc,        null: false, default: ""
      t.string :prioriti,         null: false, default: ""
      t.integer :is_complate,         null: false, default: 0
      ## Rememberable
      t.datetime :due_date
      t.timestamps null: false
    end
    # add_index :uses, :confirmation_token,   unique: true
    # add_index :uses, :unlock_token,         unique: true
  end
end
