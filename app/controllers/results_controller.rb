# encoding: utf-8
class ResultsController < ApplicationController
  before_filter :authorize

  def index
    @headertext = Array.new(2)

    @mydata = $gExperiment.userdata[@myuserid]

    Rails.logger.debug("@mygroup = " + @mygroup.inspect)
    @diffbuttonvalue = "Older Age Group" if @mygroup == 1
    @diffbuttonvalue = "Younger Age Group" if @mygroup == 2
    Rails.logger.debug("@diffbuttonvalue = " + @diffbuttonvalue.inspect)

    @guesssend,@guessrec = @mydata.getguesses($gExperiment.activeindex)
    @actualsend,@actualrec = @mydata.getactuals($gExperiment.activeindex)
    @earnedsend,@earnedrec = @mydata.getearned($gExperiment.activeindex)

    Rails.logger.info("@guesssend = " + @guesssend.inspect)
    Rails.logger.info("@guessrec = " + @guessrec.inspect)
    Rails.logger.info("@actualsend = " + @actualsend.inspect)
    Rails.logger.info("@actualrec = " + @actualrec.inspect)
    Rails.logger.info("@earnedsend = " + @earnedsend.inspect)
    Rails.logger.info("@earnedrec = " + @earnedrec.inspect)

    #    Rails.logger.debug("@guesssend = " + @guesssend.inspect)
    #    Rails.logger.debug("$gExperiment.userdata[@myuserid].guesssend = " + $gExperiment.userdata[@myuserid].guesssend.inspect)

    @resultpeak = $gResultPeak
    @resultspan = $gResultSpan

    @headertext[0] = "Of the senders' coin flips that produce \"Four\", here is how often a false message of \"Two to split\" was sent."
    @headertext[1] = "Here is how often receivers challenged a message of \"Two to split\"?"
    @resultspagetitle = "Results Interactions - "
    @maxamount = $gConfigData.amount

    updateuserstatus(@myuserid, "Viewing Guess Results")

    render :layout => "results1"

  end

  def results2
   @headertext = Array.new(2)

   @headertext[0] = "You Were Sender"
   @headertext[1] = "You Were Receiver"
   @resultspagetitle = "Results of Interactions - "

    Rails.logger.debug("@mygroup = " + @mygroup.inspect)
    @diffbuttonvalue = "Older Age Group" if @mygroup == 1
    @diffbuttonvalue = "Younger Age Group" if @mygroup == 2
    Rails.logger.debug("@diffbuttonvalue = " + @diffbuttonvalue.inspect)

    updateuserstatus(@myuserid, "Viewing Interaction Results")

    render :layout => "results2"

  end


  ##############################################################################
  def pageupdate()
    ##############################################################################
    #    Rails.logger.debug("params = " + params.to_yaml)
    #    unk = params[:unk]
    #    Rails.logger.debug("unk[0] = " + unk["0"]["rid"].inspect)
    returnhash = Hash.new()
    returnhash[:controller] = "results"

    @mydata = $gExperiment.userdata[@myuserid]
    activity = @mydata.getactivity()

    exitresults = $gExperiment.shouldexitresults(@myuserid)
    $gExperiment.redirectme(returnhash, "guess") if exitresults && $gExperiment.resultscreen == 1
    $gExperiment.redirectme(returnhash, "final") if exitresults && $gExperiment.resultscreen == 2

    #    returnhash[:redirect] = $gExperiment.running ? true : false
    returnhash[:activity] = activity



    $gExperiment.experimentcontol(returnhash)
    jsonreturn = returnhash.to_json

    render :json => jsonreturn
  end

  ##############################################################################
  def loadhistorydata()
    ##############################################################################
    @mydata = $gExperiment.userdata[@myuserid]

    returnhash = Hash.new()
    returnhash = @mydata.gethistorydata($gExperiment.activeindex)

    jsonreturn = returnhash.to_json


    render :json => jsonreturn

  end

  def done()
    returnhash = Hash.new()
    jsonreturn = returnhash.to_json
    updateuserstatus(@myuserid, "Finished Viewing Results")

    $gExperiment.resultsdone(@myuserid)

    render :json => jsonreturn


  end

end
