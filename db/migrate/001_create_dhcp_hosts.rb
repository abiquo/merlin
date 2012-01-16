class CreateDhcpHosts < ActiveRecord::Migration
  def self.up
    create_table :dhcp_hosts do |t|
      t.string :ip
      t.string :port
    end
  end

  def self.down
    drop_table :dhcp_hosts
  end
end
