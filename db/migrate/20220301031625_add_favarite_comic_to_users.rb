class AddFavariteComicToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :comic, :string
  end
end
