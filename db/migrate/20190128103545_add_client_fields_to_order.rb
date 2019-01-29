class AddClientFieldsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :name, :string
    add_column :orders, :sex, :string
    add_column :orders, :mobile, :string
    add_column :orders, :country, :string
    add_column :orders, :id_no, :string
    add_column :orders, :birthday, :date
    add_column :orders, :job, :string
    add_column :orders, :tel, :string
    add_column :orders, :address, :string
    add_column :orders, :email, :string
    add_column :orders, :reminder, :string
    add_column :orders, :note, :string
  end
end
