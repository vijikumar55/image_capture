module IpAddress

  ########################################################################################
  def IpAddress_getipaddress
    ########################################################################################
     tempadd1 = request.env["REMOTE_ADDR"]
    Rails.logger.warn("***********tempadd1 = " + tempadd1.inspect)

     tempadd2 = request.remote_ip
    Rails.logger.warn("***********tempadd2 = " + tempadd2.inspect)

     tempadd3 = request.env['REMOTE_HOST']
    Rails.logger.warn("***********tempadd3 = " + tempadd3.inspect)

     tempadd4 = request.env["HTTP_X_REAL_IP"]
    Rails.logger.warn("***********tempadd4 = " + tempadd4.inspect)


    address = request.env["HTTP_X_FORWARDED_FOR"]
    Rails.logger.warn("First check @address = " + address.inspect)
    unless  address.nil?
      address1 =  address.split(",")
    Rails.logger.warn("Second check @address = " + address.inspect)
      address =  address1[0]
    Rails.logger.warn("Third check @address = " + address.inspect)
    end
    if address.nil?
      address = request.env["HTTP_X_REAL_IP"]
    Rails.logger.warn("Last check @address = " + address.inspect)
    end
    Rails.logger.warn("IpAddress = " + address.inspect)
    if Rails.env == "development" && address == "127.0.0.1"
      actualip = address
      address = "127.0.0." + $gTestIpAddress.to_s
      $gTestIpAddress += 1
      Rails.logger.debug("*****************************************************")
      Rails.logger.debug("*****************************************************")
      Rails.logger.debug("*****************************************************")
      Rails.logger.debug("Ip Address modified in development mode")
      Rails.logger.debug("IP Address was [" + actualip + "] and is now [" + address + "]")
      Rails.logger.debug("*****************************************************")
      Rails.logger.debug("*****************************************************")
      Rails.logger.debug("*****************************************************")
    end
    address = address.strip unless address.nil?
    Rails.logger.warn("Final @address = " + address.inspect)

    Rails.logger.warn("** DUMP - request.env = " + request.env.inspect)

    return address
  end

end