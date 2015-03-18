################################################################################
class UserLoginData 
  attr_reader :pick, :input, :home, :group, :status

  ################################################################################
  def initialize(validator, dataarray, loginvalue, pick, input, home, group)
    ##############################################################################
    @dataarray = dataarray
    @loginvalue = loginvalue.to_i
    @pick = pick.to_i
    @input = input.to_s
    @home = home.to_i.abs
    @group = group.to_i
    @checked = false
    @allowed = false
    @status = "Access Denied"
    @pswd = validator.to_s
  end

  ################################################################################
  def validate
    ##############################################################################
    unless @checked
      validpoints = 0
#      matchvalue = 999
#      if @pick > 0 && @pick <= 11
#        validpoints += 1
#        if @home > 0 && @home <= 6
#          validpoints += 1
#          matchvalue = @dataarray[@pick].to_s[6-@home].to_i
#        end
#      end
      validpoints += 1 if @input == @pswd
#      validpoints += 1 if matchvalue == @loginvalue
      if validpoints == 1 || $gRequirePasswords == "No"
        unless $gRequirePasswords == "Yes"
          Rails.logger.error("**** **** Login DISABLED **** ****")
        end
        @status = "Success"
        @allowed = true
      else
        Rails.Logger.error("*Failed login validation with - [" + pswd.to_s + "]")
      end
      @checked = true
    end
        Rails.logger.debug("validpoints = " + validpoints.to_s)
        Rails.logger.debug("@validated = " + @validated.to_s)
        Rails.logger.debug("@status = " + @status.to_s)
  end

  ################################################################################
  def status
    ##############################################################################
    self.validate
    return @status.to_s
  end

  ################################################################################
  def allow
    ##############################################################################
    self.validate
    return @allowed
  end
end



