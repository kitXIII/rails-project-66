class AddFlawsCountToRepositoryCheck < ActiveRecord::Migration[7.1]
  def change
    add_column :repository_checks, :flaws_count, :integer, default: 0
  end
end
