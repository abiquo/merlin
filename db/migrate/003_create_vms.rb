class CreateVms < ActiveRecord::Migration
  def self.up
    create_table :vms do |t|
      t.string :name
      t.string :os_type
      t.string :size
      t.string :memory
      t.string :networks
      t.string :lease_name
      t.string :ip
      t.string :mask
      t.string :pxe_path
      t.integer :cpus
      t.integer :dhcp_host_id
      t.integer :esx_host_id
      t.boolean :deployed
    end
  end

  def self.down
    drop_table :vms
  end
end
