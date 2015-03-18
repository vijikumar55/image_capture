# encoding: utf-8

class LoginController < ApplicationController
  respond_to :html, :js, :erb

  ################################################################################
  def index
    ##############################################################################
    setuplogindata($gValidateDigit)

    @group = params[:group]
    @autologin = params[:autologin]
    if @group.nil?
      @group = 0
    else
      @group = @group.to_i
    end
    if @autologin.nil?
      @autologin = "no"
    else
      @autologin = "no" unless @autologin == "yes"
    end


  end

  ################################################################################
  def validatelogin
    ##############################################################################


    if $gAllowLogins == "Yes"

      @allowed = false
      if $gApplicationReady && !$gExperiment.running
        groupinput = params[:commit]
        group = 0
        group = groupinput == "Group 1" ? 1:2
        group = groupinput == "Group 2" ? 2:1

        validgroup = validategroup(group)
        if validgroup
          sessionid = getmysessionid
          @allowed = Login.validate($gInputDataValidator, $gTempHash[sessionid.to_s + "-1"],
            $gTempHash[sessionid.to_s + "-2"].to_i,
            params[:logindatapick].to_i,
            params[:password].to_s,
            $gTempHash[sessionid.to_s + "-3"],
            params[:group].to_i)
        else
          Rails.logger.error("Login Error: Invalid group - [" + group.to_s + "]")
        end

        if @allowed
          mysession = createnewuser(group)
          Rails.logger.error("*** ERROR mysession is nil") if mysession.nil?
          Rails.logger.info("sessionid = " + sessionid.to_s)
          Rails.logger.info("access = " + @allowed.to_s)

        else
          Rails.logger.error("*** User failed to login.")
          Rails.logger.info("sessionid = " + sessionid.inspect)
          Rails.logger.info("access = " + @allowed.to_s)
        end
      end
   end

        render :update do |page|
          if $gAllowLogins == "Yes"
            if @allowed
              page.redirect_to :controller => "wait"
            else
              page.redirect_to :controller => "failedlogin", :status => 401, :flash => "Login failed."
            end
          end
        end

    
  end

end
