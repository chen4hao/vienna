class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :sex
      t.string :mobile
      t.string :country
      t.string :id_no
      t.date :birthday
      t.string :job
      t.string :tel
      t.string :address
      t.string :email
      t.string :reminder
      t.string :note

      t.timestamps
    end
  end
end
