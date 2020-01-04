class AddIndexNameToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :subdomain, :string, null: false, index: true
  end
end
