################################################################################
class UserIds
  ##############################################################################
  attr_reader :ids, :groupcount
  def initialize()
    @ids = Array.new(21,0) + Array.new(20,-1)
    @ids[0] = -9
    @usercount = 0
    @groupcount = Array.new(3,($gUserCount/2).to_i)

  end

  ################################################################################
  def adduser(usersession)
    ##############################################################################
#    Rails.logger.info("def " + __method__.to_s)
    Rails.logger.info("usersession = " + usersession.inspect)

    group = usersession[:group]
    success = false
      myuserid = nil
      if group == 1 && @groupcount[group] > 0
        myuserid = @ids.index(0)
        @groupcount[group] -= 1
      elsif group == 2 && @groupcount[group] > 0
        myuserid = @ids.index(-1)
        @groupcount[group] -= 1
      end
      unless myuserid.nil?
        @ids[myuserid] = usersession
        usersession[:myuserid] = myuserid
        $gExperiment.reguser(myuserid,  usersession[:mycomputerid])
        success = true
      end
#    Rails.logger.debug("success = " + success.inspect)
    return success
  end

  ################################################################################
  def groupallowed(group)
  ################################################################################
    returnvalue = false
    if group == 1 or group == 2
      returnvalue = true if @groupcount[group] > 0
    end
    return returnvalue
  end

end
