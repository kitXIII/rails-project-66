class CreateRepositoryCheckFlaws < ActiveRecord::Migration[7.1]
  def change
    create_table :repository_check_flaws do |t|
      t.string :rule
      t.text :message
      t.string :location
      t.references :check, null: false, foreign_key: { to_table: :repository_checks }, index: true
      t.references :file, null: false, foreign_key: { to_table: :repository_check_files }, index: true

      t.timestamps
    end
  end
end
