Merlin.controllers :esx_hosts do

  get :index do
    @esx_hosts = EsxHosts.all
    render 'esx_hosts/index'
  end

  get :new do
    @esx_hosts = EsxHosts.new
    render 'esx_hosts/new'
  end

  post :create do
    @esx_hosts = EsxHosts.new(params[:esx_hosts])
    if @esx_hosts.save
      flash[:notice] = 'EsxHosts was successfully created.'
      redirect url(:esx_hosts, :edit, :id => @esx_hosts.id)
    else
      render 'esx_hosts/new'
    end
  end

  get :edit, :with => :id do
    @esx_hosts = EsxHosts.find(params[:id])
    render 'esx_hosts/edit'
  end

  put :update, :with => :id do
    @esx_hosts = EsxHosts.find(params[:id])
    if @esx_hosts.update_attributes(params[:esx_hosts])
      flash[:notice] = 'EsxHosts was successfully updated.'
      redirect url(:esx_hosts, :edit, :id => @esx_hosts.id)
    else
      render 'esx_hosts/edit'
    end
  end

  delete :destroy, :with => :id do
    esx_hosts = EsxHosts.find(params[:id])
    if esx_hosts.destroy
      flash[:notice] = 'EsxHosts was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy EsxHosts!'
    end
    redirect url(:esx_hosts, :index)
  end
end
