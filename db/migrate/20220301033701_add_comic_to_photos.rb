class AddComicToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :comic, :string
  end
end
