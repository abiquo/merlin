class DhcpHostsControl
  DHCP_PARAMS = ["ip", "port"]

  def self.validate_dhcp_data data
    DHCP_PARAMS.each do |k|
      if not data.has_key? k
        return false
      end
    end
    
    return true  
  end
end