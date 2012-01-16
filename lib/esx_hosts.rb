class EsxHostsControl
  ESX_PARAMS = ["ip", "user", "password", "datastore"]


  def self.validate_esx_data data

    ESX_PARAMS.each do |k|
        if not data.has_key? k
            return false
        end
    end
    
    return true
    
  end
end