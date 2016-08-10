class AddParamsToPost < ActiveRecord::Migration
  def change
	  add_column :posts, :title, :string
	  add_column :posts, :content, :text
	  add_column :posts, :theme, :string
  end
end
