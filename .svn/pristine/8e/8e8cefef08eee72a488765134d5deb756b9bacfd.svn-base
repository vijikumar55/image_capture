# encoding: utf-8
class FinalController < ApplicationController
    before_filter :authorize

  ##############################################################################
  def index
    ##############################################################################
    @headertext = Array.new(2)
    difftext = getdifftext(@mygroup)
    @rowlabel = ["Unknown Age Group", "Same Age Group", difftext]

    @payoutdata = Array.new(2){|i| Array.new(6)}
    @mydata = $gExperiment.userdata[@myuserid]

    for aix in 0..1
      earnedsend,earnedrec = @mydata.getearned(aix)
      for idx in 0..2
        @payoutdata[aix][idx] = earnedsend[idx]
        @payoutdata[aix][idx + 3 ] = earnedrec[idx]
      end
    end

    @headertext[0] = "Your guess on how often a false message of \"Two to split\" was sent."
    @headertext[1] = "Your guess on how often a receiver challenged a message of \"Two to split\"?"
    @finalpagetitle = ""

    updateuserstatus(@myuserid, "Selecting Guess Payout.")

    render :layout => "final1"

  end

  def final2()
    @headertext = Array.new(2)
    difftext = getdifftext(@mygroup)
    @rowlabel = ["Unknown Age Group", "Same Age Group", difftext]
    @headertext[0] = "Your interactions when you were sender."
    @headertext[1] = "Your interactions when you were receiver"
    @finalpagetitle = ""

    updateuserstatus(@myuserid, "Selecting Interaction Payout.")
    render :layout => "final2"

  end


  ##############################################################################
  def pageupdate()
    ##############################################################################
    #    Rails.logger.debug("params = " + params.to_yaml)
    #    unk = params[:unk]
    #    Rails.logger.debug("unk[0] = " + unk["0"]["rid"].inspect)
    returnhash = Hash.new()
    returnhash[:controller] = "final"

    mydata = $gExperiment.userdata[@myuserid]

    exitresults = $gExperiment.shouldexitresults(@myuserid)

    $gExperiment.experimentcontol(returnhash)
    jsonreturn = returnhash.to_json

    render :json => jsonreturn
  end

  ##############################################################################
  def loadhistorydata()
    ##############################################################################
    historyarray = Array.new(2)
    mydata = $gExperiment.userdata[@myuserid]

    historyarray[0] = mydata.gethistorydata(0)
    historyarray[1] = mydata.gethistorydata(1)

    jsonreturn = historyarray.to_json

    Rails.logger.debug("jsonreturn = " + jsonreturn.inspect)

    render :json => jsonreturn

  end

  def guesspayment()
    paymenthash = Hash.new()
    returnhash = Hash.new()
    returnhash[:guesspayment] = "success"

    paymenthash[:roll1] = params["roll1"].to_i
    paymenthash[:roll2] = params["roll2"].to_i
    paymenthash[:amount1] = params["amount1"].to_f
    paymenthash[:amount2] = params["amount2"].to_f

    mydata = $gExperiment.userdata[@myuserid]
    mydata.updateguesspayout(paymenthash)

   jsonreturn = returnhash.to_json
   render :json  => jsonreturn
  end

  def interactpayment()
    paymenthash = Hash.new()
    returnhash = Hash.new()
    returnhash[:interactpayment] = "success"

    paymenthash[:roll1] = params["roll1"].to_i
    paymenthash[:roll2] = params["roll2"].to_i
    paymenthash[:roll3] = params["roll3"].to_i
    paymenthash[:roll4] = params["roll4"].to_i
    paymenthash[:amount1] = params["amount1"].to_f
    paymenthash[:amount2] = params["amount2"].to_f

    mydata = $gExperiment.userdata[@myuserid]
    mydata.updateinteractpayout(paymenthash)

    jsonreturn = returnhash.to_json
    render :json  => jsonreturn

  end


end
