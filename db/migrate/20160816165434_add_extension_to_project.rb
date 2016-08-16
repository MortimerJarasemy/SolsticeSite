class AddExtensionToProject < ActiveRecord::Migration
  def change
	  add_column :projects, :extension, :string
  end
end
