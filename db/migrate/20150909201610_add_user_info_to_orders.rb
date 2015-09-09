class AddUserInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :address, :text
    add_column :orders, :phone, :bigint
    add_column :orders, :email, :string
  end
end
