# encoding: utf-8

class ControlloginController < ApplicationController

  layout "login"

  ################################################################################
  def index
    ##############################################################################
    setuplogindata($gValidateDigitContol)

  end

  ################################################################################
  def validatecontroller
    ##############################################################################
    sessionid = get_login_session()
    Rails.logger.info("@@@@ validatecontroller sessionid = " + sessionid.inspect)
    allowed = Login.controlvalidate($gInputDataValidatorControl,
      $gTempHash[sessionid.to_s + "-1"],
      $gTempHash[sessionid.to_s + "-2"].to_i,
      params[:logindatapick].to_i,
      params[:password].to_s,
      $gTempHash[sessionid.to_s + "-3"])

    Rails.logger.info("sessionid = " + sessionid.to_s)
    Rails.logger.info("access = " + allowed.to_s)



    render :update do |page|
      if allowed
        page.redirect_to :controller => "control"
      end
    end
  end


end
