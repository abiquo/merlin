class CreateEsxHosts < ActiveRecord::Migration
  def self.up
    create_table :esx_hosts do |t|
      t.string :ip
      t.string :user
      t.string :password
      t.string :datastore
    end
  end

  def self.down
    drop_table :esx_hosts
  end
end
