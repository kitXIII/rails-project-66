class CreateRepositories < ActiveRecord::Migration[7.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.integer :github_id, null: false
      t.string :full_name
      t.string :language
      t.string :clone_url
      t.string :html_url
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :repositories, :github_id, unique: true
  end
end
