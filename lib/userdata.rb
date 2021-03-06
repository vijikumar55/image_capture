################################################################################
class UserData
  ##############################################################################
  # guess array[0-1][0-5]
  #   [0][x] Phase 1 guess
  #   [1][x] Phase 3 guess
  #   [x][0] Unknown Sender
  #   [x][1] Unknown Receiver
  #   [x][2] Same Sender
  #   [x][3] Same receiver
  #   [x][4] Different Sender
  #   [x][5] Different Receiver
  attr_reader :id
  attr_reader :receivedactions, :receivedactionscount
#  attr_accessor :senddatacomplete, :receivedatacomplete
  attr_accessor :sentinteractions, :sentreceivedmsg
  attr_reader :guesssend, :guessrec, :actualsend, :actualrec, :earnedsend, :earnedrec
  attr_reader :historysend, :historyrec
  attr_reader :guesspayout, :interactpayout, :totalpayout
  attr_accessor :name, :namefirst, :namelast, :group
  ##############################################################################
  def resetabledata()
    ##############################################################################
    #    Rails.logger.debug("def " + __method__.to_s)
    @guesssend = Array.new(2) {|i| Array.new(3,nil)}
    @guessrec = Array.new(2) {|i| Array.new(3,nil)}
    @actualsend = Array.new(2) {|i| Array.new(3,nil)}
    @actualrec = Array.new(2) {|i| Array.new(3,nil)}
    @earnedsend = Array.new(2) {|i| Array.new(3,0)}
    @earnedrec = Array.new(2) {|i| Array.new(3,0)}
    @calcearnedsend = Array.new(2) {|i| Array.new(3,0)}
    @calcearnedrec = Array.new(2) {|i| Array.new(3,0)}
    @myactivities = Array.new(2){|jjj| Array.new(3){|fff| Hash[:flip2 => 0, :flip4 => 0, :split2 => 0, :split4 => 0, :accept => 0, :challenge => 0, :split2rec => 0, :lies => 0, :totalflips => 0]}}
    @totalsactivities = Array.new(2){|jjj| Array.new(3){|fff| Hash[:flip2 => 0, :flip4 => 0, :split2 => 0, :split4 => 0, :accept => 0, :challenge => 0, :lies => 0, :scoresend => 0, :scorerec => 0,  :percentlies => 0, :percentchallenges => 0]}}
    @receivedactions = Array.new(2){|ff| Array.new(3){|dd| Array.new()}}
    @receivedactionscount = Array.new(2,0)
#    @senddatacomplete = Array.new(2,false)
#    @receivedatacomplete = Array.new(2,false)
    @sentinteractions = Array.new(2,false)
    @sentreceivedmsg = Array.new(2,false)
    @activity = Array.new(2,"wait")
    @historysendidx = Array.new(2){|x1| Array.new(3,0)}
    @historyrecidx = Array.new(2){|x1| Array.new(3,0)}
    @historysend = Array.new(2){|x1| Array.new(3){|x2| Array(6)}}
    @historyrec = Array.new(2){|x1| Array.new(3){|x2| Array(6)}}
    @guesspayout = Array.new(2){|ss| Hash.new()}
    @interactpayout = Array.new(4){|ss| Hash.new()}
    @totalpayout = 0
    @name = ""
    @namelast = ""
    @namefirst = ""
    @mylies = Array.new(2) {|i| Array.new(3,-1)}
    @mychallenge = Array.new(2) {|i| Array.new(3,-1)}
  end

  ##############################################################################
  def initialize(userid)
    ##############################################################################
    resetabledata()
    @id = userid
    @group = @id.to_i < $gUserGroup2 ? 1:2

  end

  ################################################################################
  def reset()
    ################################################################################
    resetabledata()
  end
  ################################################################################
  def makeguess(guesssend0, guessrec0, guesssend1, guessrec1, guesssend2, guessrec2)
    ################################################################################
    idx = $gExperiment.activeindex
    @guesssend[idx][0] = guesssend0.to_f / 100
    @guessrec[idx][0] = guessrec0.to_f / 100
    @guesssend[idx][1] = guesssend1.to_f / 100
    @guessrec[idx][1] = guessrec1.to_f / 100
    @guesssend[idx][2] = guesssend2.to_f / 100
    @guessrec[idx][2] = guessrec2.to_f / 100
    
    $gExperiment.guessok(@id)

  end

  ################################################################################
  def getguesses(idx)
    ################################################################################
    #    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    #    Rails.logger.debug("@guesssend = " + @guesssend.inspect)
    return @guesssend[idx],@guessrec[idx]
  end
  ################################################################################
  def getactuals(idx)
    ################################################################################
    #    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    return @actualsend[idx],@actualrec[idx]
  end

  ################################################################################
  def getearned(idx)
    ################################################################################
    #    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    return @calcearnedsend[idx],@calcearnedrec[idx]
  end

  ################################################################################
  def getactivity
    ################################################################################
    idx = $gExperiment.activeindex
    @activity[idx] = getnextactivity(@activity[idx])
    return @activity[idx]
  end

  ################################################################################
  def getnextactivity(currentactivity)
    ################################################################################
    returnactivity = currentactivity
    #    Rails.logger.debug("$gExperiment.state = " + $gExperiment.state.inspect)
    #    Rails.logger.debug("currentactivity0 = " + currentactivity.inspect)
    case $gExperiment.state
    when Constants::StateStart
      returnactivity = "send"
      #      Rails.logger.debug("currentactivity1 = " + currentactivity.inspect)
    when Constants::StateSend1, Constants::StateSend2
      returnactivity = "send"
      #      Rails.logger.debug("currentactivity2 = " + currentactivity.inspect)
    when Constants::StateRec1, Constants::StateRec2
      returnactivity = "receive"
      #      Rails.logger.debug("currentactivity3 = " + currentactivity.inspect)
    when Constants::StateResults1, Constants::StateResults2
      #      Rails.logger.debug("currentactivity4 = " + currentactivity.inspect)
      returnactivity = "results"
    else
      #      Rails.logger.debug("currentactivity5 = " + currentactivity.inspect)
    end
    return returnactivity
  end

  ################################################################################
  def getmyinteractions()
    ################################################################################
    currentiteractions = Hash.new()
    currentiteractions[:unk] = $gExperiment.interactions[@id][$gExperiment.activeindex][Constants::Unk]
    currentiteractions[:same] = $gExperiment.interactions[@id][$gExperiment.activeindex][Constants::Same]
    currentiteractions[:diff] = $gExperiment.interactions[@id][$gExperiment.activeindex][Constants::Diff]
#    Rails.logger.debug("User id = " + @id.to_s + "   currentiteractions = " + currentiteractions.inspect)

    return currentiteractions
  end

   ################################################################################
  def addreceivedaction(aidx, gidx, action)
    ################################################################################
    #    Rails.logger.debug("@id = " + @id.to_s )
    @receivedactions[aidx.to_i][gidx.to_i].push(action)
    @receivedactionscount[aidx.to_i] += 1
  end

  ################################################################################
  def historysendadd(aidx, gidx, action)
  ################################################################################
    msg = "4 Split" if action[:split] == 4
    msg = "2 Split" unless action[:split] == 4
    coin = action[:flip]
    if coin.to_i == 2
      msg = ""
    else
      if action[:split] == 4
        msg = ""
      else
        msg = "2 to Split" unless action[:split] == 4
      end
    end
    chal = "Yes" if action[:challenge] == 1
    chal = "" unless action[:challenge] == 1
    sendscore, receivescore = $gExperiment.getscore(action[:flip],action[:split],action[:accept])
    pay = sendscore
    @historysend[aidx][gidx][@historysendidx[aidx][gidx]] = [:msg => msg, :coin => coin, :chal => chal, :pay => pay]
    @historysendidx[aidx][gidx] += 1
  end
  ################################################################################
  def historyrecadd(aidx, gidx, action)
  ################################################################################
    msg = "4 to Split" if action[:split].to_i == 4
    msg = "2 to Split" unless action[:split].to_i == 4
    coin = "?"
    coin = action[:flip] if action[:challenge].to_i == 1 || action[:split].to_i == 4
    chal = "Yes" if action[:challenge].to_i == 1
    chal = "" unless action[:challenge].to_i == 1
    sendscore, receivescore = $gExperiment.getscore(action[:flip].to_i,action[:split].to_i,action[:accept].to_i)
    pay = receivescore
    @historyrec[aidx][gidx][@historyrecidx[aidx][gidx]] = [:msg => msg, :coin => coin, :chal => chal, :pay => pay]
    @historyrecidx[aidx][gidx] += 1
  end

  def gethistorydata(act)
    currenthistory = Hash.new()
    sendgrouphash = Hash.new()
    recgrouphash = Hash.new()

    sendgrouphash[:unk] = @historysend[act][Constants::Unk]
    sendgrouphash[:same] = @historysend[act][Constants::Same]
    sendgrouphash[:diff] = @historysend[act][Constants::Diff]

    recgrouphash[:unk] = @historyrec[act][Constants::Unk]
    recgrouphash[:same] = @historyrec[act][Constants::Same]
    recgrouphash[:diff] = @historyrec[act][Constants::Diff]

    currenthistory[:send] = sendgrouphash
    currenthistory[:rec] = recgrouphash
    return currenthistory
  end

  ##############################################################################
  def allrec()
    ##############################################################################
    returnvalue = @receivedactionscount[$gExperiment.activeindex] == 18 ? true:false
    #    Rails.logger.debug("allrec() - @receivedactionscount[$gExperiment.activeindex] = " + @receivedactionscount[$gExperiment.activeindex].inspect)
    return returnvalue
  end

  ################################################################################
  def getmyreceiveddata()
    ################################################################################
    receiveddata = Hash.new()
    receiveddata[:unk] = @receivedactions[$gExperiment.activeindex][Constants::Unk]
    receiveddata[:same] = @receivedactions[$gExperiment.activeindex][Constants::Same]
    receiveddata[:diff] = @receivedactions[$gExperiment.activeindex][Constants::Diff]
    return receiveddata
  end

  ################################################################################
  def getdatatosend(datahash, datatype)
    ################################################################################
    # Only call this from the Participants controller.
    aidx = $gExperiment.activeindex
    if datatype == "send"
      interactions = getmyinteractions()
      #      Rails.logger.debug("interactions = " + interactions.inspect)
      datahash[:unksend]  = interactions[:unk]
      datahash[:samesend] = interactions[:same]
      datahash[:diffsend] = interactions[:diff]
      #      Rails.logger.debug("@sentinteractions[aidx] = " + @sentinteractions[aidx].inspect)
    end
    if datatype == "rec"
      if allrec()
        receiveddata = getmyreceiveddata()
        datahash[:unkrec]  = receiveddata[:unk]
        datahash[:samerec] = receiveddata[:same]
        datahash[:diffrec] = receiveddata[:diff]
        @sentreceivedmsg[aidx] = true
        #        Rails.logger.debug("@sentreceivedmsg[aidx] = " + @sentreceivedmsg[aidx].inspect)
      end
    end
    return datahash
  end

  ################################################################################
  def updatemytotals(aidx,lies,challenges)
  ################################################################################
#    Rails.logger.debug("updatemytotals(aidx,lies,challenges)- lies = " + lies.inspect)
#    Rails.logger.debug("updatemytotals(aidx,challenges)- challenges = " + challenges.inspect)

#    interactions = $gExperiment.interactions[@id][$gExperiment.activeindex][0]
#    interactions += $gExperiment.interactions[@id][$gExperiment.activeindex][1]
#    interactions += $gExperiment.interactions[@id][$gExperiment.activeindex][2]

    interactions = $gExperiment.allinteractions[@id][$gExperiment.activeindex]
    
    Rails.logger.debug("ID = " + @id.inspect  + "    interactions = " + interactions.inspect)
    for gidx in 0..2
      grouping = "Unk" if gidx == 0
      grouping = "Same" if gidx == 1
      grouping = "Diff" if gidx == 2
      Rails.logger.debug("Grouping = " + grouping.to_s)
#      @totalsactivities[aidx][gidx][:flip2] = $gExperiment.totalsactivities[aidx][gidx][:flip2] - @myactivities[aidx][gidx][:flip2]
#      @totalsactivities[aidx][gidx][:flip4] = $gExperiment.totalsactivities[aidx][gidx][:flip4] - @myactivities[aidx][gidx][:flip4]
#      flip4 = @totalsactivities[aidx][gidx][:flip4]
#      @totalsactivities[aidx][gidx][:split2] = $gExperiment.totalsactivities[aidx][gidx][:split2] - @myactivities[aidx][gidx][:split2]
#      split2 = @totalsactivities[aidx][gidx][:split2]
#      @totalsactivities[aidx][gidx][:split4] = $gExperiment.totalsactivities[aidx][gidx][:split4] - @myactivities[aidx][gidx][:split4]
#      @totalsactivities[aidx][gidx][:accept] = $gExperiment.totalsactivities[aidx][gidx][:accept] - @myactivities[aidx][gidx][:accept]
#      @totalsactivities[aidx][gidx][:challenge] = $gExperiment.totalsactivities[aidx][gidx][:challenge] - @myactivities[aidx][gidx][:challenge]
#      challenges = @totalsactivities[aidx][gidx][:challenge]

# This section is being modified for new lie calculation.

      if @group == 1
        # Unknown
        if gidx == 0
          startgrp = 1
          endgrp = 40  
          # Same
        elsif gidx == 1
          startgrp = 1
          endgrp = 20 
          # Different 
        else
          startgrp = 21
          endgrp = 40
        end      
      else
        # Unknown
        if gidx == 0
          startgrp = 1
          endgrp = 40  
          # Same
        elsif gidx == 1
          startgrp = 21
          endgrp = 40 
          # Different 
        else
          startgrp = 1
          endgrp = 20
        end      
      end        
      totallies = 0
      liecount = 0
      challengescount = 0
      totalchallenges = 0
      for pid in startgrp..endgrp
        unless interactions.include?(pid) || pid == @id
          Rails.logger.debug("Include pid -  " + pid.inspect)
          Rails.logger.debug("lies[pid][gidx] -  " + lies[pid][gidx].inspect)
          Rails.logger.debug("challenges[pid][gidx] -  " + challenges[pid][gidx].inspect)
          unless lies[pid][gidx] == -1
            liecount += 1
            totallies += lies[pid][gidx]
          end
          unless challenges[pid][gidx] == -1
            challengescount += 1
            totalchallenges += challenges[pid][gidx]
            Rails.logger.debug("********** Myid = " + @id.to_s + "   Pid = " + pid.to_s)
            Rails.logger.debug("********** challenges[pid][gidx] -  " + challenges[pid][gidx].inspect)
            Rails.logger.debug("********** challengescount       -  " + challengescount.inspect)
            Rails.logger.debug("********** totalchallenges       -  " + totalchallenges.inspect)
          end
          
        end
      end
      @totalsactivities[aidx][gidx][:lies] =  liecount
      @totalsactivities[aidx][gidx][:percentlies] = totallies.to_f/liecount.to_f unless liecount == 0
      @totalsactivities[aidx][gidx][:percentlies] = 0 if liecount == 0
#      Rails.logger.debug("Liecount = " + @totalsactivities[aidx][gidx][:lies].inspect + "    Percent Lies = " + @totalsactivities[aidx][gidx][:percentlies].inspect)

      @totalsactivities[aidx][gidx][:challenges] =  challengescount
      @totalsactivities[aidx][gidx][:percentchallenges] = totalchallenges.to_f/challengescount.to_f unless challengescount == 0
      @totalsactivities[aidx][gidx][:percentchallenges] = 0 if challengescount == 0
#      Rails.logger.debug("challenges = " + @totalsactivities[aidx][gidx][:challenges].inspect + "    Percent challenges = " + @totalsactivities[aidx][gidx][:percentchallenges].inspect)
      
#      @totalsactivities[aidx][gidx][:lies] = $gExperiment.totalsactivities[aidx][gidx][:lies] - @myactivities[aidx][gidx][:lies]
#      lies = @totalsactivities[aidx][gidx][:lies]

#      @totalsactivities[aidx][gidx][:percentlies] = lies.to_f/flip4.to_f
      @actualsend[aidx][gidx] = @totalsactivities[aidx][gidx][:percentlies]

#      @totalsactivities[aidx][gidx][:percentchallenges] = challenges.to_f/split2.to_f
      @actualrec[aidx][gidx] = @totalsactivities[aidx][gidx][:percentchallenges]
# End of section to update.

      @calcearnedsend[aidx][gidx] = calculateearnings(self.guesssend[aidx][gidx],@actualsend[aidx][gidx])
      @calcearnedrec[aidx][gidx] = calculateearnings(self.guessrec[aidx][gidx],@actualrec[aidx][gidx])

      #      Rails.logger.debug("@totalsactivities[" + aidx.to_s + "][" + gidx.to_s + "]" + @totalsactivities[aidx][gidx].inspect )
    end
#    Rails.logger.warn("**** @id = " + @id.inspect)
#    for logid in 0..2
#      Rails.logger.warn("**5>,MyId,Activity,Group,flip2,flip4,split2,split4,accept,challenge,lies,score")
#      Rails.logger.warn("**5>," + @id.to_s + "," + aidx.to_s + "," + logid.to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:flip2].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:flip4].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:split2].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:split4].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:accept].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:challenge].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:lies].to_s + "," +
#          $gExperiment.totalsactivities[aidx][logid][:score].to_s)
#
#      Rails.logger.warn("**6>,MyId,Activity,Group,flip2,flip4,split2,split4,accept,challenge,lies")
#      Rails.logger.warn("**6>," + @id.to_s + "," + aidx.to_s + "," + logid.to_s + "," +
#          @myactivities[aidx][logid][:flip2].to_s + "," +
#          @myactivities[aidx][logid][:flip4].to_s + "," +
#          @myactivities[aidx][logid][:split2].to_s + "," +
#          @myactivities[aidx][logid][:split4].to_s + "," +
#          @myactivities[aidx][logid][:accept].to_s + "," +
#          @myactivities[aidx][logid][:challenge].to_s + "," +
#          @myactivities[aidx][logid][:lies].to_s)
#
#      Rails.logger.warn("**7>,MyId,Activity,Group,flip2,flip4,split2,split4,accept,challenge,lies,scoresend,scorerec,%lies,%challenges")
#      Rails.logger.warn("**7>," + @id.to_s + "," + aidx.to_s + "," + logid.to_s + "," +
#          @totalsactivities[aidx][logid][:flip2].to_s + "," +
#          @totalsactivities[aidx][logid][:flip4].to_s + "," +
#          @totalsactivities[aidx][logid][:split2].to_s + "," +
#          @totalsactivities[aidx][logid][:split4].to_s + "," +
#          @totalsactivities[aidx][logid][:accept].to_s + "," +
#          @totalsactivities[aidx][logid][:challenge].to_s + "," +
#          @totalsactivities[aidx][logid][:lies].to_s + "," +
#          @totalsactivities[aidx][logid][:scoresend].to_s + "," +
#          @totalsactivities[aidx][logid][:scorerec].to_s + "," +
#          @totalsactivities[aidx][logid][:percentlies].to_s + "," +
#          @totalsactivities[aidx][logid][:percentchallenges].to_s)
#     end

  end
  
  def updatemychallenges(aidx)
   Rails.logger.debug("@@@@ updatemychallenges - @id = " + @id.inspect)
   Rails.logger.debug("@@@@ aidx = " + aidx.inspect)
   for gidx in 0..2
#      Rails.logger.debug("updatemychallenges - ID = " + @id.inspect)
#      Rails.logger.debug("@myactivities[aidx][gidx][:challenge] = " + @myactivities[aidx][gidx][:challenge].inspect)
#      Rails.logger.debug("@myactivities[aidx][gidx][:split2] = " + @myactivities[aidx][gidx][:split2].inspect)
      unless @myactivities[aidx][gidx][:split2rec] == 0 
        @mychallenge[aidx][gidx] = @myactivities[aidx][gidx][:challenge].to_f / @myactivities[aidx][gidx][:split2rec].to_f
      end
    Rails.logger.debug("@@@@ gidx = " + gidx.inspect)
    Rails.logger.debug("@@@@ updatemychallenges - @myactivities[aidx][gidx][:challenge] = " + @myactivities[aidx][gidx][:challenge].inspect)
    Rails.logger.debug("@@@@ updatemychallenges - @myactivities[aidx][gidx][:split2rec] = " + @myactivities[aidx][gidx][:split2rec].inspect)
    end
    Rails.logger.debug("@@@@ updatemychallenges - @mychallenge = " + @mychallenge[aidx].inspect)
  end
  
  def updatemylies(aidx)
    Rails.logger.debug("==== updatemylies - @id = " + @id.inspect)
    Rails.logger.debug("==== aidx = " + aidx.inspect)
    for gidx in 0..2
#      Rails.logger.debug("updatemylies - ID = " + @id.inspect)
#      Rails.logger.debug("@myactivities[aidx][gidx][:lies] = " + @myactivities[aidx][gidx][:lies].inspect)
#      Rails.logger.debug("@myactivities[aidx][gidx][:flip4] = " + @myactivities[aidx][gidx][:flip4].inspect)
      unless @myactivities[aidx][gidx][:flip4] == 0 || @myactivities[aidx][gidx][:totalflips] == 0
        @mylies[aidx][gidx] = @myactivities[aidx][gidx][:lies].to_f / @myactivities[aidx][gidx][:flip4].to_f
      end
    Rails.logger.debug("==== gidx = " + gidx.inspect)
    Rails.logger.debug("==== updatemylies - @myactivities[aidx][gidx][:lies] = " + @myactivities[aidx][gidx][:lies].inspect)
    Rails.logger.debug("==== updatemylies - @myactivities[aidx][gidx][:flip4] = " + @myactivities[aidx][gidx][:flip4].inspect)
    end
    Rails.logger.debug("==== updatemylies - @mylies = " + @mylies[aidx].inspect)
#    Rails.logger.debug("updatemylies - @mylies = " + @mylies[aidx].inspect)
  end
  
  def getlies(aidx)
    updatemylies(aidx)
#    Rails.logger.debug("getlies(aidx) @mylies = " + @mylies[aidx].inspect)
    return @mylies[aidx]
  end
  
  def getchallenges(aidx)
    updatemychallenges(aidx)
#    Rails.logger.debug("getchallenges(aidx) @mychallenge = " + @mychallenge[aidx].inspect)
    return @mychallenge[aidx]
  end

  ################################################################################
  def calculateearnings(guess, actual)
    ################################################################################
    earned = $gConfigData.amount * ( 1 - (36 * (guess - actual)**2))
    earned = 0 if earned < 0

#    unless earned == 0
#      earned = (earned.to_f / 0.25).round * 0.25
#    end
    return earned
  end

  ################################################################################
  def addflip2(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:flip2] += 1
    @myactivities[aidx][gidx][:totalflips] += 1
  end

  ################################################################################
  def addflip4(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:flip4] += 1
    @myactivities[aidx][gidx][:totalflips] += 1
  end

  ################################################################################
  def addsplit2(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:split2] += 1
  end

  ################################################################################
  def addsplit4(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:split4] += 1
  end

  ################################################################################
  def addaccept(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:accept] += 1
  end

  ################################################################################
  def addchallenge(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:challenge] += 1
  end
  ################################################################################
  def addsplit2rec(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:split2rec] += 1
  end

  ################################################################################
  def addlie(aidx,gidx)
    ################################################################################
    @myactivities[aidx][gidx][:lies] += 1
#    Rails.logger.debug("Lies:   myid= " + @myuserid.to_s + "   aidx= " + aidx.to_s + "    gidx= " + gidx.to_s + "   Total Lies = " + @myactivities[aidx][gidx][:lies].to_s)
  end
  
  ################################################################################
  def updaterecscore(aidx,gidx,score)
    ################################################################################
    @totalsactivities[aidx][gidx][:scorerec] += score
    @earnedrec[aidx][gidx] += score
  end

  ################################################################################
  def updatesendscore(aidx,gidx,score)
    ################################################################################
    @totalsactivities[aidx][gidx][:scoresend] += score
    @earnedsend[aidx][gidx] += score
  end

  ################################################################################
  def updateguesspayout(paymenthash)
  ################################################################################
    @guesspayout[0][:roll] = paymenthash[:roll1]
    @guesspayout[0][:amount] = paymenthash[:amount1]
    @guesspayout[1][:roll] = paymenthash[:roll2]
    @guesspayout[1][:amount] = paymenthash[:amount2]
 end

  ################################################################################
  def updateinteractpayout(paymenthash)
  ################################################################################
    @interactpayout[0][:roll] = paymenthash[:roll1]
    @interactpayout[1][:roll] = paymenthash[:roll2]
    @interactpayout[1][:amount] = paymenthash[:amount1]
    @interactpayout[2][:roll] = paymenthash[:roll3]
    @interactpayout[3][:roll] = paymenthash[:roll4]
    @interactpayout[3][:amount] = paymenthash[:amount2]

    @totalpayout = @guesspayout[0][:amount].to_f + @guesspayout[1][:amount].to_f +
                    @interactpayout[1][:amount].to_f + @interactpayout[3][:amount].to_f
  end

  def savename(name)
    namesplit = name.split(" ")
    firstname = namesplit[0]
    namesplit.delete_at(0)
    lastname = namesplit.join(" ")
    @name = name
    @namefirst = firstname
    @namelast = lastname
#    Rails.logger.warn("Username = " + @name.to_s + "   Fisrt = [" + @namefirst.to_s + "]    Last = [" + @namelast.to_s + "]" )
  end

end
