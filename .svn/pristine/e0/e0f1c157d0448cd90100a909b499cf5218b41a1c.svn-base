# encoding: utf-8

class WaitController < ApplicationController
  before_filter :authorize
  respond_to :html, :js, :json

  ################################################################################
  def index
    ##############################################################################
    #TODO: Need to remove redirect and implement wait.

    #@mysession = getmysession()
    unless @mysession.nil?
    @waitimagefile = $gWaitImageFile
    updateuserstatus(@myuserid, "Waiting to begin.")


#    Rails.logger.debug("Got my session: mysession = " + @mysession.to_yaml)
    else
      Rails.logger.error("*** Invalid Session, redirecting to login")
      redirect_to :controller => "login"
     end

    #redirect_to :controller => "participant"
  end

  
  def pageupdate()

#    jsonreturn = $gExperiment.to_json
     returnhash = Hash.new()
     returnhash[:controller] = "wait"
    $gExperiment.redirectme(returnhash, "guess") if $gExperiment.running

     $gExperiment.experimentcontol(returnhash)
     jsonreturn = returnhash.to_json

#    indata =  ActiveSupport::JSON.decode params.to_json
#    Rails.logger.debug("params = " + indata.inspect)
#    Rails.logger.debug("params = " + params.to_yaml)
#    Rails.logger.debug("params[:item2] = " + params[:item2][1].to_s)
#    Rails.logger.debug("$gExperiment.running = " + $gExperiment.running.inspect)

    render :json => jsonreturn

  end
  
end
