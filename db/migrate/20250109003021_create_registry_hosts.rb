class CreateRegistryHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :registry_hosts do |t|
      t.string :source
      t.string :destination
      t.string :status
      t.boolean :confidential

      t.timestamps
    end
  end
end
