# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  require "yaml"
  require "userlogindata"
  include Computerid
  include Constants
  require "ageism"
  include Gentestdata
  include Datasave


  $gTestIpAddress = 2 if $gTestIpAddress.nil?
  
  $gLoginImageFile = "images/chapmanLogoLarge.gif"
  $gWaitImageFile = "images/waitscreenimage.png"
  $gControlImageFile = "images/controlimage.png"


  ################################################################################
  def initialize()
    super()
#    Rails.logger.info("ApplicationController Initialized = " + $gInitApp.inspect)
    $gInitApp = initapplication() unless $gInitApp == true
  end


  ################################################################################
  def initapplication()
    ##############################################################################
    Rails.logger.info("def " + __method__.to_s)
    $gResultSpan = 36
    $gResultPeak = 5
    $gAllowLogins = "No"

    $gAutoplay = "Off"
    $gRequiredUsers = 40

    $gApplicationReady = false
    $gTestMode = true
    $gRequirePasswords = "Yes"
    $gRoworder = [1,2,3] if $gRoworder.nil?
    $gColorder = [1,2] if $gColorder.nil?
    $gInputDataValidator = "chapman" if $gInputDataValidator.nil?
    $gInputDataValidatorControl = "chapmanesi" if $gInputDataValidatorControl.nil?
    $gValidateDigit = 2 if $gValidateDigit.nil?
    $gValidateDigitContol = 4 if $gValidateDigitContol.nil?
    $gLoginImageFile = "images/chapmanLogoLarge.gif"
    $gWaitImageFile = "images/waitscreenimage.png"
    $gControlImageFile = "images/controlimage.png"
    $gGreenSphere = "images/sphere-green.png"
    $gRedSphere = "images/sphere-red.png"

    $gUserCount = 40
    $gUserGroup2 = 21
    
    $gConfigData = ConfigData.new if $gConfigData.nil?
    $gConnections = Connections.new() if $gConnections.nil?
    $gTempHash = Hash.new
    Rails.logger.info("ApplicationController \"initapplication\" Completed")

    $gExperiment = AgeismExperiment.new()

    resetabledata()

#    Rails.logger.debug("$gUserIdTable = " + $gUserIdTable.to_s)

    return true
  end

  ##############################################################################
  def resetabledata()
  ##############################################################################
    gentestinittestcontrol()
  end

  ##############################################################################
  def resetapplication()
  ##############################################################################
    resetabledata()
    $gExperiment.reset()
  end

  ##############################################################################
  def logoffalluser()
  ##############################################################################
    Rails.logger.warn("!!!Logging Off All Logged On Users!!!")
    $gExperiment.logoffalluser()
  end

  ##############################################################################
  def createnewuser(group)
    ##############################################################################
    mysession = nil
    mysessionid = getmysessionid()
    mycomputerid = genseratecomputerid()
    mysession = $gExperiment.newuser(mysessionid, mycomputerid,group)
    return mysession
  end

  ##############################################################################
  def validategroup(group)
  ##############################################################################
    returnvalue = false
    if group == 1 || group == 2
      returnvalue = $gExperiment.userids.groupallowed(group)
    end
    return returnvalue
  end

  ##############################################################################
  def getmysessionid()
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    sessionid = request.session_options[:id].to_s.strip
#   Rails.logger.warn("getmysessionid() sessionid = " + sessionid.inspect)
    return sessionid
  end

  ##############################################################################
  def getmysession()
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + ")
    yoursession = nil
    mysessionid = getmysessionid()
    if Rails.env == "development"
      yoursession = $gExperiment.sessions.mysession(mysessionid)
    else
      mycomputerid = getcomputerid()
#      Rails.logger.warn("mycomputerid = " + mycomputerid.inspect)
      yoursession = $gExperiment.sessions.mysession(mysessionid)
    end
    Rails.logger.warn("mycomputerid = " + mycomputerid.inspect) if yoursession.nil?
    Rails.logger.warn("Returning Nil session") if yoursession.nil?
    return yoursession
  end

  ##############################################################################
  def validateuser()
  ##############################################################################
    validuser = false
    computerid = getcomputerid()
    sessionid = getmysessionid()
    validuser = $gExperiment.userconnections.valid(sessionid, computerid)
    unless validuser
      Rails.logger.warn("Failed validation of computerid = [" + computerid.inspect + "]    sessionid = [" + sessionid.inspect + "]")
    end
    return validuser
  end

  def getdifftext(group)
    if group == 1
     difftext = "Older Adult Group"
    else
      difftext = "Younger Adult Group"
    end
    return difftext
  end

  ##############################################################################
  def updateuserstatus(userid,statusmsg)
   ##############################################################################
    $gExperiment.updateuserstatus(userid, statusmsg)
  end

  ##############################################################################
  def getcontrolsession()
  ##############################################################################
    controlsession = nil
    controlsessionid = getmysessionid()
    controlcomputerid = getcomputerid()
#    Rails.logger.warn("Controller computer = " + controlcomputerid.inspect)
#    Rails.logger.warn("Controller Session Id = " + controlsessionid.inspect)
    controlsession = $gControllerSession
    return controlsession
  end


  ################################################################################
  def get_login_session()
    ################################################################################
    sessionid = getmysessionid()
#    Rails.logger.warn("sessionid = " + sessionid.to_s)
#    Rails.logger.info("session inspect = " + session.inspect)

    # The first time connecting the session id will not be set.  Set the @reload
    # to "yes" will instruct the page to reload.  On the reload the session will
    # be set. WARNING: If cookies are not enabled this will go into an infinite
    # loop.  Will deal with this later since we control all connections this
    # should not have any impact.
    @reload = sessionid == "" ? "yes" : "no"
    Rails.logger.info("@reload = " + @reload.to_s)
    return sessionid
  end

  ##############################################################################
  def setuplogindata(position)
    ##############################################################################
    sessionid = get_login_session()
    Rails.logger.info("@@@@ setuplogindata sessionid = " + sessionid.inspect)

    @logindata = Hash.new
    @loginimagefile = $gLoginImageFile
    @logindata_array = $gConfigData.logindata.shuffle
    @loginvalue = rand(10).to_i
    @logindata_array.insert(0, "")
    @logindata_array.insert(1,@loginvalue.to_s)

    @logindata_array.each_index do |x|
      @logindata[@logindata_array[x].to_s] = x.to_s
    end

    # @loginposition = rand(6) + 1
    @loginposition = position
    $gTempHash[sessionid.to_s + "-1"] = @logindata_array
    $gTempHash[sessionid.to_s + "-2"] = @loginvalue
    $gTempHash[sessionid.to_s + "-3"] = @loginposition
#    Rails.logger.debug("@@@@ setuplogindata @@@@")
#    Rails.logger.debug("sessionid = " + sessionid.to_s)
#    Rails.logger.debug("$gTempHash = " + $gTempHash.inspect)
   
  end

  
  before_filter :initcontroller

  private

  ##############################################################################
  def validatecontrol()
    ##############################################################################
    @mysession = getcontrolsession()
  end



  ##############################################################################
  def initcontroller()
    ##############################################################################
    @current_action = action_name
    @current_controller = controller_name
    @mysession = getcontrolsession() if @current_controller == "control"
  end

  ##############################################################################
  def authorize()
    ##############################################################################
    @mycomputerid = getcomputerid()
    validuser = validateuser()
    if validuser
      @mysession = getmysession()
      @myuserid =  @mysession.nil? ?  0:@mysession[:myuserid]
      @mygroup =  @mysession.nil? ?  0:@mysession[:group]
    else
      Rails.logger.info("*** Invalid User Request Rejected")
      redirect_to "/login"
    end

    #       Rails.logger.warn("instantiate_controller_and_action_names - @myuserid = " + @myuserid.to_s)

  end

end


