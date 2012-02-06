class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.datetime :renewal
      t.string :didyoumean

      t.timestamps
    end
  end
end
