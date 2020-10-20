class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.integer :github_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
