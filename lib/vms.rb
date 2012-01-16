class VmsControl

  VM_PARAMS = ["name", "size", "cpus", "memory", "os_type", "lease_name", "ip", "mask", "pxe_path"]
  
  def self.validate_vm_data data
    VM_PARAMS.each do |k|
      if not data.has_key? k
        return false
      end
    end
        
    true
  end  

  def self.deploy(data)
  
    #Prepare MagicWand
    dhcp_host = DHCP::Server.new(data['dhcp_host']['ip'], data['dhcp_host']['port'])
    esx_host = ESX::Host.connect(data['esx_host']['ip'], data['esx_host']['user'], data['esx_host']['password'])
    magic_wand = VMWizard::MagicWand.new(esx_host, dhcp_host)
  
    #Prepare VM definition
    networks = data['vm']['networks'].split(',')
    raise "No network found in #{data['networks']}" if networks.empty?
    
    nics = []
    networks.each do |n|
      nics.push({:network => n.strip})
    end
    
    vm = VMWizard::VirtualMachine.new(
            :name => data['vm']['name'],
            :disk_size => data['vm']['size'],
            :cpus => data['vm']['cpus'],
            :ram => data['vm']['memory'],
            :guest => data['vm']['os_type'],
            :nics => nics
    )
    datastore = data['esx_host']['datastore']
    
    #Deploy VM
    deployed_vm = magic_wand.deploy(vm, datastore)
    
    deployed_vm.power_on
    
    mac = ''
    #Recover mac address
    Net::SSH.start(data['esx_host']['ip'], data['esx_host']['user'], :password => data['esx_host']['password']) do |ssh|
      mac = ssh.exec!("grep \"ethernet0.generatedAddress \" \"/vmfs/volumes/#{datastore}/#{vm.name}/#{vm.name}.vmx\"|cut -f3 -d\" \"").gsub('"','')
    end
    
    #Prepare lease definition
    lease = DHCP::Lease.new(
              :name => data['vm']['lease_name'],
              :ip => data['vm']['ip'],
              :mask => data['vm']['mask'],
              :mac => mac,
              :pxe_path => data['vm']['pxe_path'],
              :hostname => data['vm']['hostname']
    )
    
    dhcp_host.del_lease lease
    dhcp_host.add_lease lease
        
    true
  end
        
  def self.undeploy(data)  
    dhcp_host = DHCP::Server.new(data['dhcp_host']['ip'], data['dhcp_host']['port'])
    esx_host = ESX::Host.connect(data['esx_host']['ip'], data['esx_host']['user'], data['esx_host']['password'])
    magic_wand = VMWizard::MagicWand.new(esx_host, dhcp_host)
    
    magic_wand.undeploy(data['vm']['name'])
    
    #Prepare lease definition
    lease = DHCP::Lease.new( :name => data['vm']['lease_name'] )
  
    dhcp_host.del_lease lease
    
    true
  end
  
end