# encoding: utf-8

class GuessController < ApplicationController
  before_filter :authorize
  respond_to :html, :js, :json
  
  ##############################################################################
  def index
    ##############################################################################
    # Unknown Sender     = guesssender1
    # Unknown Receiver   = guessreceiver1

    # Same Sender        = guesssender2
    # Same receiver      = guessreceiver2

    # Different Sender   = guesssender3
    # Different Receiver = guessreceiver3

    updateuserstatus(@myuserid, "Guessing Phase " + $gExperiment.phase.to_s)

    headertext1 = "Of the senders' coin flips that produce \"Four\", how often will a false message of \"Two to split\" be sent?"
    headertext2 = "How often will receivers challenge a message of \"Two to split\"?"
    @roworder = Array.new()
    @colorder = Array.new(2)
    @headertext = Array.new(2)
    difftext = getdifftext(@mygroup)
    @rowlabel = ["", "Unknown Age Group", "Same Age Group", difftext]
    @guesspagetitle = "Guesses About Future Interactions"
    srand(Time.now().to_i)
    startroworder = [1,2,3]
    
    idx = rand(3)
    @roworder.push(startroworder[idx])
    startroworder.delete_at(idx)
    idx = rand(2)
    @roworder.push(startroworder[idx])
    startroworder.delete_at(idx)
    @roworder.push(startroworder[0])

    idx = rand(2)
    if idx == 0
      @colorder[0] = "guesssender"
      @colorder[1] = "guessreceiver"
      @headertext[0] = headertext1
      @headertext[1] = headertext2

    else
      @colorder[1] = "guesssender"
      @colorder[0] = "guessreceiver"
      @headertext[0] = headertext2
      @headertext[1] = headertext1
    end
    
    #    Rails.logger.debug("@rowlabel[@roworder[0]] = " + @rowlabel[@roworder[0]].inspect)
    #    Rails.logger.debug("@rowlabel = " + @rowlabel.inspect)
    #    Rails.logger.debug("@roworder = " + @roworder.inspect)
    #    Rails.logger.debug("@colorder = " + @colorder.inspect)
  end


  ##############################################################################
  def submitguess()
    ##############################################################################
    s0 = params[:guesssender1].to_i
    r0 = params[:guessreceiver1].to_i
    s1 = params[:guesssender2].to_i
    r1 = params[:guessreceiver2].to_i
    s2 = params[:guesssender3].to_i
    r2 = params[:guessreceiver3].to_i

#    Rails.logger.warn("s0 = " + s0.inspect + " r0 = " + r0.inspect)
#    Rails.logger.warn("s1 = " + s1.inspect + " r1 = " + r1.inspect)
#    Rails.logger.warn("s2 = " + s2.inspect + " r2 = " + r2.inspect)

    $gExperiment.userdata[@myuserid].makeguess(s0,r0,s1,r1,s2,r2)

    render :update do |page|
      page.redirect_to :controller => "participant"
    end

  end

  ##############################################################################
  def pageupdate()
    ##############################################################################

    #    jsonreturn = $gExperiment.to_json
    returnhash = Hash.new()
    returnhash[:controller] = "guess"
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
