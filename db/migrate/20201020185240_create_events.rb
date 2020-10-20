class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :action
      t.string :type

      t.timestamps
    end
  end
end
