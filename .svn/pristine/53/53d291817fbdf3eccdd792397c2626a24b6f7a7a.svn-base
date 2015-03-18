module Login

  ################################################################################
  def Login::validate(validator, dataarray, loginvalue, pick, input, home, group)
    ##############################################################################
    Rails.logger.debug("Login::validate - validator = " + validator.inspect)
    Rails.logger.debug("Login::validate - dataarray = " + dataarray.inspect)
    Rails.logger.debug("Login::validate - loginvalue = " + loginvalue.inspect)
    Rails.logger.debug("Login::validate - pick = " + pick.inspect)
    Rails.logger.debug("Login::validate - input = " + input.inspect)
    Rails.logger.debug("Login::validate - home = " + home.inspect)
    Rails.logger.debug("Login::validate - group = " + group.inspect)
    allowed = false
    pswd = validator.to_s
    validpoints = 0
#    matchvalue = 999
#    if pick > 0 && pick <= 11
#      validpoints += 1
#      if home > 0 && home <= 6
#        validpoints += 1
#        matchvalue = dataarray[pick].to_s[6-home].to_i
#      end
#    end
    validpoints += 1 if input == pswd
#    validpoints += 1 if matchvalue == loginvalue
    if validpoints == 1 || $gRequirePasswords == "No"
      unless $gRequirePasswords == "Yes"
         Rails.logger.error("**** Login DISABLED ****")
      end
      allowed = true
    else
      Rails.Logger.error("Failed login validation with pswd = [" + pswd.to_s + "]")
      Rails.Logger.error("Failed login validation with RequirePasswords = [" + $gRequirePasswords.to_s + "]")
    end
    Rails.logger.debug("validpoints = " + validpoints.to_s)
    Rails.logger.debug("@validated = " + @validated.to_s)
    Rails.logger.debug("@status = " + @status.to_s)

    return allowed
  end

  ################################################################################
  def Login::controlvalidate(validator, dataarray, loginvalue, pick, input, home)
    ##############################################################################
    Rails.logger.debug("Login::controlvalidate - validator = " + validator.inspect)
    Rails.logger.debug("Login::controlvalidate - dataarray = " + dataarray.inspect)
    Rails.logger.debug("Login::controlvalidate - loginvalue = " + loginvalue.inspect)
    Rails.logger.debug("Login::controlvalidate - pick = " + pick.inspect)
    Rails.logger.debug("Login::controlvalidate - input = " + input.inspect)
    Rails.logger.debug("Login::controlvalidate - home = " + home.inspect)


    allowed = false
    pswd = validator.to_s
    matchvalue = 999
    validpoints = 0
    if pick > 0 && pick <= 11
      validpoints += 1
      if home > 0 && home <= 6
        validpoints += 1
        matchvalue = dataarray[pick].to_s[6-home].to_i
      end
    end
    validpoints += 1 if input == pswd
    validpoints += 1 if matchvalue == loginvalue
    if validpoints == 4
      allowed = true
    end
    Rails.logger.debug("Control validpoints = " + validpoints.to_s)
    Rails.logger.debug("Control @validated = " + @validated.to_s)
    Rails.logger.debug("Control @status = " + @status.to_s)

    return allowed
  end


  
end