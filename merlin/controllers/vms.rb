Merlin.controllers :vms do

  get :index do
    @vms = Vms.all
    render 'vms/index'
  end

  get :new do
    @vms = Vms.new
    @dhcp_hosts = DhcpHosts.all
    @esx_hosts = EsxHosts.all
    
    render 'vms/new'
  end

  post :create do
    @vms = Vms.new(params[:vms])
    if @vms.save
      flash[:notice] = 'Vms was successfully created.'
      redirect url(:vms, :edit, :id => @vms.id)
    else
      render 'vms/new'
    end
  end

  get :edit, :with => :id do
    @vms = Vms.find(params[:id])
    @dhcp_hosts = DhcpHosts.all
    @esx_hosts = EsxHosts.all
    render 'vms/edit'
  end

  put :update, :with => :id do
    @vms = Vms.find(params[:id])
    if @vms.update_attributes(params[:vms])
      flash[:notice] = 'Vms was successfully updated.'
      redirect url(:vms, :edit, :id => @vms.id)
    else
      render 'vms/edit'
    end
  end

  delete :destroy, :with => :id do
    vms = Vms.find(params[:id])
    if vms.destroy
      flash[:notice] = 'Vms was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Vms!'
    end
    redirect url(:vms, :index)
  end

  post :deploy, :with => :id do
    vm = Vms.find(params[:id])
        
    esx_host = EsxHosts.find(vm.esx_host_id)
    dhcp_host = DhcpHosts.find(vm.dhcp_host_id)

    data = {}
    data['vm'] = JSON.parse(vm.to_json)['vms']
    data['esx_host'] = JSON.parse(esx_host.to_json)['esx_hosts']
    data['dhcp_host'] = JSON.parse(dhcp_host.to_json)['dhcp_hosts']

    begin
      VmsControl.deploy(data)
      vm.deployed = true
      vm.save
      flash[:notice] = 'Vms was successfully deployed.'
    rescue => e
      flash[:error] = e.message
    end

    redirect url(:vms, :index)
  end

  post :undeploy, :with => :id do
    vm = Vms.find(params[:id])
        
    esx_host = EsxHosts.find(vm.esx_host_id)
    dhcp_host = DhcpHosts.find(vm.dhcp_host_id)

    data = {}
    data['vm'] = JSON.parse(vm.to_json)['vms']
    data['esx_host'] = JSON.parse(esx_host.to_json)['esx_hosts']
    data['dhcp_host'] = JSON.parse(dhcp_host.to_json)['dhcp_hosts']
    

    begin
      VmsControl.undeploy(data)
      vm.deployed = false
      vm.save
      flash[:notice] = 'Vms was successfully undeployed.'
    rescue => e
      flash[:error] = e.message
    end

    redirect url(:vms, :index)
  end

end
