# encoding: utf-8

class ControlController < ApplicationController
  #  include Gentestdata
  before_filter :validatecontrol
  respond_to :html, :js, :json

  ##############################################################################
  def index
    ##############################################################################
    @controlimagefile = $gControlImageFile
    @redsphere = $gRedSphere
    @greensphere = $gGreenSphere

    @pageupdatetime = 4000
    $gApplicationReady = true


  end

  ##############################################################################
  def startexperiment()
    ##############################################################################

    #    myjsonobj = $gExperiment.userids.ids[1].to_json
    #    Rails.logger.debug("myjsonobj" + myjsonobj)
    if $gExperiment.start()
      successstart = true
    else
      successstart = false
    end

    render :update do |page|
      page.alert("ERROR !!!! Experiment cannot start.  Please check setup!") unless successstart
      #     page.alert("Experient Started!") if successstart
    end

  end


  ##############################################################################
  def resetexperiment()
    ##############################################################################

    resetapplication()

    render :update do |page|
      page.alert("ERROR !!!! Experiment did not reset.  Please check setup!") if $gExperiment.running
      #     page.alert("Experient Started!") if successstart
    end

  end

  ##############################################################################
  def changeamount()
    ##############################################################################
    newamount = params[:time]

  data = YAML.load_file "path/to/yml_file.yml"
    data["time"] = params[:time]
    File.open(Rails.root.to_s + "/config/experimentconfigdata.yml", 'w') { |f| YAML.dump(data, f) }
    render :update do |page|
    end

  end
  ##############################################################################
  def changerequiredusers()
    ##############################################################################
    newnumber = params[:requiredusers]
    $gRequiredUsers = newnumber.to_i

    $gExperiment.canstart()

    render :update do |page|
    end

  end
  ##############################################################################
  def changeautoplay()
    ##############################################################################
    newvalue = params[:autoplay]
    $gAutoplay = newvalue
    
    render :update do |page|
    end

  end
  ##############################################################################
  def changeallowlogins()
    ##############################################################################
    newvalue = params[:allowlogins]
    Rails.logger.warn("Received a Change Allow Login State to [" + newvalue.inspect + "]")
    Rails.logger.warn("Current State of $gAllowLogins = [" + $gAllowLogins.inspect + "]")
    if $gExperiment.running
      Rails.logger.warn("!!! This should not have happened!  Tries to disable logins while experiment is running.")
    else
      if newvalue == "Yes" || newvalue == "No"
        $gAllowLogins = newvalue
        logoffalluser() if newvalue == "No"
      else
        Rails.logger.warn("!!! This should not have happened!  Illigal data sent to disable logins.")
      end
    end

    render :update do |page|
    end
  end

  ##############################################################################
  def changerequirepasswords()
    ##############################################################################
     newvalue = params[:requrepasswords]
      if newvalue == "Yes" || newvalue == "No"
        $gRequirePasswords = newvalue
      else
        Rails.logger.warn("!!! This should not have happened!  Illigal data sent to change require passords.")
      end
    render :update do |page|
    end
  end


  ##############################################################################
  def pageupdate()
    ##############################################################################
    #  Rails.logger.debug("$gExperiment.can_start = " + $gExperiment.can_start.inspect)
    #  Rails.logger.debug("$gRequiredUsers = " + $gRequiredUsers.inspect)
    $gExperiment.controllerupdate()
    #    Rails.logger.debug("$gExperiment.usersonline = " + $gExperiment.usersonline.inspect)
    returnhash = Hash.new()
    returnhash[:usersonline] = $gExperiment.usersonline
    returnhash[:usercomputerid] = $gExperiment.usercomputerid
    returnhash[:userstatus] = $gExperiment.userstatus
    returnhash[:can_start] = $gExperiment.can_start
    returnhash[:running] = $gExperiment.running
    returnhash[:completed] = $gExperiment.completed
    returnhash[:amount] = $gConfigData.amount
    returnhash[:requiredusers] = $gRequiredUsers
    returnhash[:allowlogins] = $gAllowLogins
    returnhash[:autoplay] = $gAutoplay
    returnhash[:requirepasswords] = $gRequirePasswords
    jsonreturn = returnhash.to_json

    #    Rails.logger.debug("$gControllerSession = " + $gControllerSession.inspect)

    gentestdata() unless $gRequiredUsers == $gUserCount

    #    Rails.logger.debug(" **** #{Rails.root}")


    #    indata =  ActiveSupport::JSON.decode params.to_json
    #    Rails.logger.debug("params = " + indata.inspect)
    #    Rails.logger.debug("params = " + params.to_yaml)
    #    Rails.logger.debug("params[:item2] = " + params[:item2][1].to_s)

    render :json => jsonreturn
  end
end
