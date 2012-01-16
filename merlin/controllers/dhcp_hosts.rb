Merlin.controllers :dhcp_hosts do

  get :index do
    @dhcp_hosts = DhcpHosts.all
    render 'dhcp_hosts/index'
  end

  get :new do
    @dhcp_hosts = DhcpHosts.new
    render 'dhcp_hosts/new'
  end

  post :create do
    @dhcp_hosts = DhcpHosts.new(params[:dhcp_hosts])
    if @dhcp_hosts.save
      flash[:notice] = 'DhcpHosts was successfully created.'
      redirect url(:dhcp_hosts, :edit, :id => @dhcp_hosts.id)
    else
      render 'dhcp_hosts/new'
    end
  end

  get :edit, :with => :id do
    @dhcp_hosts = DhcpHosts.find(params[:id])
    render 'dhcp_hosts/edit'
  end

  put :update, :with => :id do
    @dhcp_hosts = DhcpHosts.find(params[:id])
    if @dhcp_hosts.update_attributes(params[:dhcp_hosts])
      flash[:notice] = 'DhcpHosts was successfully updated.'
      redirect url(:dhcp_hosts, :edit, :id => @dhcp_hosts.id)
    else
      render 'dhcp_hosts/edit'
    end
  end

  delete :destroy, :with => :id do
    dhcp_hosts = DhcpHosts.find(params[:id])
    if dhcp_hosts.destroy
      flash[:notice] = 'DhcpHosts was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy DhcpHosts!'
    end
    redirect url(:dhcp_hosts, :index)
  end
end
