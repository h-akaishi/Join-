class AddColumnUsers < ActiveRecord::Migration
  def change
    add_column :users, :introduction, :string
    add_column :users, :affiliation, :string
  end
end
