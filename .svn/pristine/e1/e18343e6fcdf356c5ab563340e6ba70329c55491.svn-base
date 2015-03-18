class PayoutController < ApplicationController
  before_filter :authorize

  ##############################################################################
  def index
  ##############################################################################
    @mydata = $gExperiment.userdata[@myuserid]

    @payoutpagetitle = "Summary of Payout"

    @guess1 = "$" + "%2.2f" % @mydata.guesspayout[0][:amount].to_f
    @guess2 = "$" + "%2.2f" % @mydata.guesspayout[1][:amount].to_f
    @interact1 = "$" + "%2.2f" % @mydata.interactpayout[1][:amount].to_f
    @interact2 = "$" + "%2.2f" % @mydata.interactpayout[3][:amount].to_f
    @total = "$" + "%2.2f" % @mydata.totalpayout.to_f

    @pageupdatetime = "10000"
    updateuserstatus(@myuserid, "Entering User Name.")

  end

  ##############################################################################
  def savename()
    ##############################################################################
    returnhash = Hash.new()
    myuserdata = $gExperiment.userdata[@myuserid]
    name  = params["username"].to_s
    myuserdata.savename(name)
    updateuserstatus(@myuserid, "Completed Experiment.")
    Rails.logger.warn("Username = " + name.to_s)
    $gExperiment.finished(@myuserid)

    jsonreturn = returnhash.to_json

    render :json => jsonreturn


  end

  ##############################################################################
  def pageupdate()
    ##############################################################################
    #    Rails.logger.debug("params = " + params.to_yaml)
    #    unk = params[:unk]
    #    Rails.logger.debug("unk[0] = " + unk["0"]["rid"].inspect)
    returnhash = Hash.new()
    returnhash[:controller] = "payout"

    @mydata = $gExperiment.userdata[@myuserid]

    exitresults = $gExperiment.shouldexitresults(@myuserid)

    $gExperiment.experimentcontol(returnhash)
    jsonreturn = returnhash.to_json

    render :json => jsonreturn
  end


end
