class CreateTasklists < ActiveRecord::Migration[5.1]
  def change
    create_table :tasklists do |t|

      t.string :name
      t.integer :total

      t.timestamps
    end
  end
end
