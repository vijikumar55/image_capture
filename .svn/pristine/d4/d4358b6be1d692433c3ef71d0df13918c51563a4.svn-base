# encoding: utf-8

class FailedloginController < ApplicationController
  respond_to :html, :js
  ################################################################################
  def index
    ##############################################################################

    Rails.logger.debug("FailedloginController Entered")

    @failmsg = "Login data incorrect!"
    @failmsg = "Controller is not logged in.   You cannot login until controller is logged in!!!" unless $gApplicationReady

    respond_with("index")



  end

end
