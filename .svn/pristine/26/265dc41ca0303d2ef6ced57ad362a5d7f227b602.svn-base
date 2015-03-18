# encoding: utf-8

class ParticipantController < ApplicationController
  before_filter :authorize
  require "json"


  ##############################################################################
  def index
    ##############################################################################
    #    @mysession = getmysession()

    mycomputerid = @mysession[:mycomputerid]
    updateuserstatus(@myuserid, "Entered Activity Screen")
    agemsg = $gExperiment.getgroup(@myuserid) == 2 ?  "Younger Adult Group":"Older Adult Group"
    @senderunk = "Sender is Unknown Age Group"
    @sendersame = "Sender is Same Age Group"
    @senderdiff = "Sender is " + agemsg.to_s

    @receiverunk = "Receiver is Unknown Age Group"
    @receiversame = "Receiver is Same Age Group"
    @receiverdiff = "Receiver is " + agemsg.to_s

    @pageupdatetime = 5000
  end

  ##############################################################################
  def processsenddata(grouping, senddata)
    ##############################################################################
#     Rails.logger.error(">>> process senddata = " + senddata.inspect)
     if !senddata.nil?
      #      Rails.logger.debug("senddata = " + senddata.inspect)
      #      Rails.logger.warn("processsenddata - grouping = " + grouping.to_s)
      for idx in 0..5
        sidx = idx.to_s
        rid = senddata[sidx]["rid"]
        flip = senddata[sidx]["flip"]
        split = senddata[sidx]["split"]
#        Rails.logger.debug("**2> senddata,@myuserid,rid,flip,split,gouping")
#        Rails.logger.debug("**2> senddata," + @myuserid.inspect + "," + rid.to_s + "," + flip.to_s + "," + split.to_s + "," + grouping.inspect)
#        Rails.logger.debug(">>> process senddata -  sid = " + @myuserid.inspect + "  rid = " + rid.to_s + "   flip" + flip.to_s + "   split" + split.to_s + "   grouping" + grouping.inspect)
        $gExperiment.recordsenddata(@myuserid,rid.to_i,flip.to_i,split.to_i,grouping)
      end
      updateuserstatus(@myuserid, "Completed send for " + grouping.to_s)
      $gExperiment.senddone(@myuserid) if grouping == "diff"
    end
  end

  ##############################################################################
  def processrecdata(grouping, recdata)
    ##############################################################################
    #    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    #    Rails.logger.debug("recdata = " + recdata.inspect)
#    Rails.logger.error(">>> process recdata = " + recdata.inspect)
         unless recdata.nil?
#      Rails.logger.debug("processrecdata - grouping = " + grouping.to_s + "    recdata[sidx] = " + recdata[sidx].inspect)
#      Rails.logger.debug("processrecdata - grouping = " + grouping.to_s)
      for idx in 0..5
        sidx = idx.to_s
        sid = recdata[sidx]["sid"]
        accept = recdata[sidx]["accept"]
        challenge = recdata[sidx]["challenge"]
#        Rails.logger.warn("**3> recdata,@myuserid,sid,accept,challenge,grouping")
#        Rails.logger.warn("**3> recdata," + @myuserid.to_s + "," + sid.to_s + "," + accept.to_s + "," + challenge.to_s + "," + grouping.to_s)
        $gExperiment.recordreceivedata(@myuserid,sid.to_i,accept.to_i,challenge.to_i,grouping)
      end
      updateuserstatus(@myuserid, "Completed receive for " + grouping.to_s)
      $gExperiment.recdone(@myuserid) if grouping == "diff"
    end
  end


  ##############################################################################
  def pageupdate()
    ##############################################################################
    #    Rails.logger.debug("params = " + params.to_yaml)
    #    unk = params[:unk]
    #    Rails.logger.debug("unk[0] = " + unk["0"]["rid"].inspect)
    #    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
#    Rails.logger.info("@myuserid = " + @myuserid.to_s)
    returnhash = Hash.new()
    returnhash[:controller] = "participant"

    loadsenddata = params[:needsenddata].nil? ? false:true
    loadrecdata = params[:needrecdata].nil? ? false:true

    unksend = params[:unksend]
    samesend = params[:samesend]
    diffsend = params[:diffsend]

    unkrec =  params[:unkrec]
    samerec =  params[:samerec]
    diffrec =  params[:diffrec]

    processsenddata("unk", unksend.to_hash) unless unksend.nil?
    processsenddata("same", samesend.to_hash) unless samesend.nil?
    processsenddata("diff", diffsend.to_hash) unless diffsend.nil?

    processrecdata("unk", unkrec.to_hash) unless unkrec.nil?
    processrecdata("same", samerec.to_hash) unless samerec.nil?
    processrecdata("diff", diffrec.to_hash) unless diffrec.nil?

    @mydata = $gExperiment.userdata[@myuserid]
    activity = @mydata.getactivity()
#    Rails.logger.info("activity = " + activity.to_s)
    
    #    returnhash[:redirect] = $gExperiment.running ? true : false
    returnhash[:activity] = activity
    $gExperiment.redirectme(returnhash, "results") if activity == "results"

    #    Rails.logger.debug("loadsenddata = " + loadsenddata.inspect)
    #    Rails.logger.debug("loadrecdata = " + loadrecdata.inspect)
    returnhash = @mydata.getdatatosend(returnhash, "send") if loadsenddata
    returnhash = @mydata.getdatatosend(returnhash, "rec") if loadrecdata
#    Rails.logger.error("loadsenddata - returnhash = " + returnhash.inspect)if loadsenddata
#    Rails.logger.error("loadrecdata - returnhash = " + returnhash.inspect)if loadrecdata

    $gExperiment.experimentcontol(returnhash)
    jsonreturn = returnhash.to_json

    render :json => jsonreturn
  end




end

