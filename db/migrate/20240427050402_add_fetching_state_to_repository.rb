class AddFetchingStateToRepository < ActiveRecord::Migration[7.1]
  def change
    add_column :repositories, :fetching_state, :string, null: false
  end
end
