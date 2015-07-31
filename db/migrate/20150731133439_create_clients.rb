class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, limit: 100
      t.string :api_key, :unique, limit: 128
      t.boolean :rate_limited, default: true
      t.timestamps null: false
    end
  end
end
