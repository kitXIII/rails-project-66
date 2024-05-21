class CreateRepositoryCheckFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :repository_check_files do |t|
      t.string :path
      t.references :check, null: false, foreign_key: { to_table: :repository_checks }, index: true

      t.timestamps
    end
  end
end
