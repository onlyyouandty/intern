class CreateQsorts < ActiveRecord::Migration
  def change
    create_table :qsorts do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
