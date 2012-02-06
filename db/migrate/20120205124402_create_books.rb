class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :author
      t.integer :year
      t.string :title
      t.integer :rating
      t.string :isbn

      t.timestamps
    end
  end
end
