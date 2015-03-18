require "usersession"
require "userdata"
require "userids"
require "userlogindata"
require "configdata"
require "participant"
require "controller"
require "connections"
include Datasave


##############################################################################
class AgeismExperiment
  ##############################################################################
  # This is the experiment class for the Ageism experiment.
  # It contains all control and collected data during an experiment.
  attr_reader :running, :allow_connections, :can_start, :completed
  attr_reader :usersonline, :usercomputerid, :userstatus, :userscreen
  attr_reader :phase, :state, :guesscomplete
  attr_reader :userids, :userdata, :interactions, :allinteractions
  attr_reader :userconnections, :sessions
  attr_reader :guessindex, :activities, :validactivities
  attr_reader :activeindex, :totalsactivities
  attr_reader :resultscompletecount, :resultscreen
  attr_reader :completedexperiment, :completedexperimentcount
  ##############################################################################
  def resetabledata()
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s)
    @activities = Array.new(2){|jj| Array.new(3){|kk| Array.new(41){|mm| Hash.new()}}}
    @totalsactivities = Array.new(2){|jjj| Array.new(3){|fff| Hash[:flip2 => 0, :flip4 => 0, :split2 => 0, :split4 => 0, :accept => 0, :challenge => 0, :lies => 0, :score => 0]}}
    @validactivities = Hash.new()
    @interactions = Array.new(41){|pp| Array.new(2){|ii| Array.new(6){|jj| Array.new(6,0)}}}
    @allinteractions = Array.new(41){|pp| Array.new(2){|ii| Array.new}}
    @guesscomplete = Array.new(2){|rr| Array.new(41,false)}
    @guesscompletecount = Array.new(2,0)
    @sendcomplete = Array.new(2){|rr| Array.new(41,false)}
    @sendcompletecount = Array.new(2,0)
    @receivecomplete = Array.new(2){|rr| Array.new(41,false)}
    @receivecompletecount = Array.new(2,0)
    @resultscompletecount = Array.new(2,0)
    @resultscomplete = Array.new(2){|rr| Array.new(41,false)}

    @resultsexitcount = Array.new(2,0)
    @resultsexit = Array.new(2){|rr| Array.new(41,false)}

    @completedexperiment = Array.new(41,false)
    @completedexperimentcount = 0
    @activeindex = 0
    @guessindex = 0
    @numberguess = 0
    @running = false
    @completed = false
    @phase = 0
    @state = 0
    @resultscreen = 0
    @lies = Array.new(3)
    @challenges = Array.new(3)
#    Rails.logger.debug("@totalsactivities = " + @totalsactivities.inspect)
  end

  ##############################################################################
  def cleanuserdata()
  ##############################################################################
    @can_start = false
    @usersonline.fill(false)
    @usercomputerid.fill("")
    @userstatus.fill("Not Connected")
    @userscreen.fill(0)
    @userdata.fill(nil)
    @allow_connections = false
    @usercount = 0
    @userids = UserIds.new()
    @userconnections = Connections.new()
    @sessions =  UserSession.new()
    for i in 1..40 do
      @userdata[i] = UserData.new(i)
    end
    initinteractions()
  end

  ##############################################################################
  def initialize()
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    resetabledata()
    @usersonline = Array.new(41)
    @usercomputerid = Array.new(41)
    @userstatus = Array.new(41)
    @userscreen = Array.new(41)
    @userdata = Array.new(41)
    cleanuserdata()
  end

  ##############################################################################
  def start()
    ##############################################################################
    @running = true if @can_start
    generatebasefilename() if @running
    @state = 1 if @running
    @phase = 1 if @running
    return @running
  end

  ##############################################################################
  def reset()
    ##############################################################################
    @running = false
    @state = 0
    @phase = 0
    resetabledata()
    initinteractions()
    for i in 1..40 do
      @userdata[i].reset()
    end
  end

 
  ##############################################################################
  def shouldexitresults(uid)
    ##############################################################################
    returnvalue = false
    returnvalue = true if @resultscompletecount[@activeindex] == $gUserCount
    userexited(uid,returnvalue)
    return returnvalue
  end

  ##############################################################################
  def userexited(uid,exitflag)
  ##############################################################################
  if exitflag
    @resultsexit[@activeindex][uid] = true
    @resultsexitcount[@activeindex] = @resultsexit[@activeindex].count(true)
  end

  end

  def genuserexit(uid)
    @resultsexit[@activeindex][uid] = true
    @resultsexitcount[@activeindex] = @resultsexit[@activeindex].count(true)
  end


  ##############################################################################
  def activestate()
    ##############################################################################
    returnvalue = $gExperiment.state == Constants::StateSend1 || $gExperiment.state == Constants::StateSend2 ? true:false
    return returnvalue
  end

  ##############################################################################
  def logoffalluser()
  ##############################################################################
    cleanuserdata()
  end

  ##############################################################################
  def reguser(userid, computerid)
    # This information is displayed on the controller screen.  When the
    # "useronline" is set to true the green indicator is turned on and the
    # ip address is displayed.
    ##############################################################################
    @usersonline[userid] = true
    @usercomputerid[userid] = computerid.to_s
    @usercount = @usersonline.count(true)
    canstart()
    Rails.logger.debug("reguser - userid = " + userid.to_s)
    Rails.logger.debug("reguser - usercount = " + @usercount.to_s)
  end

  ##############################################################################
  def updateuserstatus(uid, statusmsg)
    # Update the status message that is displayed on the controller screen.
    ##############################################################################
    @userstatus[uid] = statusmsg.to_s
  end

  ##############################################################################
  def newuser(mysessionid, computerid, group)
    ##############################################################################
    newsession = nil
    if @userconnections.add(mysessionid, computerid)
      newsession = @sessions.newuser(mysessionid, computerid)
      newsession[:group] = group
      if $gExperiment.userids.adduser(newsession)
        #        newsession[:mydata] = @userdata[newsession[:myuserid].to_i]
        #        Rails.logger.debug("newsession = " + newsession.to_yaml)
      else
        newsession = nil
      end
    end
    return newsession
  end

  ##############################################################################
  def canstart()
    ##############################################################################
    returnvalue = @usercount >= $gRequiredUsers ? true:false
    @can_start = returnvalue
    return returnvalue
  end

  def endexperiment()
    @completed = true
  end

  def candisablelogins()
   returnvalue =  @usercount == 0 ? true : false
   return returnvalue
  end

  ##############################################################################
  def controllerupdate()
    ##############################################################################
    if @running
#      Rails.logger.debug("controllerupdate - @state = " + @state.to_s)
      case @state
      when Constants::StateStart
        # Do nothing
        Rails.logger.info("Entering StateGuess1")
        @state = Constants::StateGuess1
      when Constants::StateGuess1
        @activeindex = 0
        @guessindex = 0
        if @guesscompletecount[@guessindex] == $gUserCount
          Rails.logger.info("Entering StateSend1")
          @state = Constants::StateSend1
          @phase = 1
        end
      when Constants::StateSend1
#         Rails.logger.debug("controllerupdate - @sendcompletecount[@activeindex] = " + @sendcompletecount[@activeindex].to_s)
        if @sendcompletecount[@activeindex] == $gUserCount
          Rails.logger.info("Entering StateRec1")
          @state = Constants::StateRec1
          @phase = 2
        end
      when Constants::StateRec1
#        Rails.logger.debug("controllerupdate - @receivecompletecount[@activeindex] = " + @receivecompletecount[@activeindex].to_s)
        if @receivecompletecount[@activeindex] == $gUserCount
          Rails.logger.info("Entering StateResults1")
          updateusertotals()
          @state = Constants::StateResults1
          @resultscreen = 1
          @phase = 2
          @guessindex = 1
        end
      when Constants::StateResults1
#          Rails.logger.debug("@activeindex = " + @activeindex.inspect)
#          Rails.logger.debug("@resultsexitcount = " + @resultsexitcount.inspect)
        if @resultsexitcount[@activeindex] == $gUserCount
          @state = Constants::StateGuess2
          @activeindex = 1
          Rails.logger.info("Entering StateGuess2")
        end
      when Constants::StateGuess2
        if @guesscompletecount[@guessindex] == $gUserCount
          Rails.logger.info("Entering StateSend2")
          @state = Constants::StateSend2
          @phase = 3
        end
      when Constants::StateSend2
        if @sendcompletecount[@activeindex] == $gUserCount
          Rails.logger.info("Entering StateRec2")
          @state = Constants::StateRec2
          @phase = 4
        end
      when Constants::StateRec2
        if @receivecompletecount[@activeindex] == $gUserCount
          updateusertotals()
          saveguessdata()
          Rails.logger.info("Entering StateResults2")
          @state = Constants::StateResults2
          @resultscreen = 2
          @phase = 4
        end
      when Constants::StateResults2
        if @resultscompletecount[@activeindex] == $gUserCount
          @state = Constants::StateFinal
          @phase = 4
        end
      when Constants::StateFinal
        saveactivitydata()
        @state = Constants::StatePayout
      when Constants::StatePayout
        if @completedexperimentcount == $gUserCount
          savepayoutdata()
          endexperiment()
          @state = Constants::Completed
        end
      when Constants::Completed
       else
      end
    end
  end

  ##############################################################################
  def guessok(uid)
    ##############################################################################
    @guesscomplete[@guessindex][uid] = true
    @guesscompletecount[@guessindex] = @guesscomplete[@guessindex].count(true)
  end

  ##############################################################################
  def senddone(uid)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    @sendcomplete[@activeindex][uid] = true
    @sendcompletecount[@activeindex] = @sendcomplete[@activeindex].count(true)
  end

  ##############################################################################
  def recdone(uid)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
#    Rails.logger.debug("User ID = " + uid.to_s)
    @receivecomplete[@activeindex][uid] = true
    @receivecompletecount[@activeindex] = @receivecomplete[@activeindex].count(true)
  end

    ##############################################################################
  def resultsdone(uid)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
#    Rails.logger.debug("User ID = " + uid.to_s)
    @resultscomplete[@activeindex][uid] = true
    @resultscompletecount[@activeindex] = @resultscomplete[@activeindex].count(true)
  end

  def finished(uid)
    @completedexperiment[uid] = true
    @completedexperimentcount = @completedexperiment.count(true)
  end


  ##############################################################################
  def experimentcontol(sendhash)
    ##############################################################################
    unless @running
      if $gAllowLogins == "Yes"
        unless sendhash[:controller] == "wait"
        sendhash[:redirect] = true
        sendhash[:path] = "wait"
        end
      elsif
        sendhash[:redirect] = true
        sendhash[:path] = "login"
      end
    end

    if $gAutoplay == "On"
      sendhash[:autoplay] = true
    else
      sendhash[:autoplay] = false
    end

  end

  ##############################################################################
  def redirectme(sendhash, contoller)
  ##############################################################################
      sendhash[:redirect] = true
      sendhash[:path] = contoller
  end


  ##############################################################################
  def getgroup(id)
    ##############################################################################
    groupid = @userdata[id.to_i].group
#    Rails.logger.debug("groupid from getgroup = " + groupid.to_s)
    return groupid
  end


  ##############################################################################
  def recordsenddata(sid,rid,flip,split,grouping)
    ##############################################################################
    sg = getgroup(sid)
    rg = getgroup(rid)
    gidx = Constants::Grouping[grouping]
    @activities[@activeindex][gidx][sid][rid] = Hash.new()

    @activities[@activeindex][gidx][sid][rid][:sid] = sid
    @activities[@activeindex][gidx][sid][rid][:rid] = rid
    @activities[@activeindex][gidx][sid][rid][:grouping] = grouping
    @activities[@activeindex][gidx][sid][rid][:sg] = sg
    @activities[@activeindex][gidx][sid][rid][:rg] = rg
    @activities[@activeindex][gidx][sid][rid][:flip] = flip
    @activities[@activeindex][gidx][sid][rid][:split] = split
    @activities[@activeindex][gidx][sid][rid][:accept] = 0
    @activities[@activeindex][gidx][sid][rid][:challenge] = 0

    Rails.logger.debug(">>> recordsenddata -  sid = " + sid.to_s + "  rid = " + rid.to_s + "   flip = " + flip.to_s + "   split = " + split.to_s + "   grouping = " + grouping.inspect + "  sg = " + sg.to_s + "  rg = " + rg.to_s)
    @allinteractions[rid][@activeindex].push(sid) unless @allinteractions[rid][@activeindex].include?(sid)
    @allinteractions[sid][@activeindex].push(rid) unless @allinteractions[sid][@activeindex].include?(rid)
    
    @userdata[rid.to_i].addreceivedaction(@activeindex,gidx, @activities[@activeindex][gidx][sid][rid] )

  end

  ##############################################################################
  def recordreceivedata(rid,sid,accept,challenge,grouping)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    gidx = Constants::Grouping[grouping]
#    Rails.logger.debug("******** @activities[@activeindex][gidx][sid][rid]")
#    Rails.logger.debug("B - " +@activities[@activeindex][gidx][sid][rid].inspect)
    @activities[@activeindex][gidx][sid][rid][:accept] = accept.to_i
    @activities[@activeindex][gidx][sid][rid][:challenge] = challenge.to_i
#    Rails.logger.debug("A - " +@activities[@activeindex][gidx][sid][rid].inspect)

    @allinteractions[sid][@activeindex].push(rid) unless @allinteractions[sid][@activeindex].include?(rid)
    @allinteractions[rid][@activeindex].push(sid) unless @allinteractions[rid][@activeindex].include?(sid)
    
    @userdata[sid.to_i].historysendadd(@activeindex,gidx, @activities[@activeindex][gidx][sid][rid])
    @userdata[rid.to_i].historyrecadd(@activeindex,gidx, @activities[@activeindex][gidx][sid][rid])

    Rails.logger.debug(">>> recordreceivedata -  rid = " + rid.to_s + "  sid = " + sid.to_s + "  accept = " + accept.to_s + "   challenge = " + challenge.to_s + "   grouping = " + grouping.inspect)

    countaction(@activeindex,gidx, sid.to_i, rid.to_i, @activities[@activeindex][gidx][sid][rid])

  end

  ##############################################################################
  def countaction(aidx, gidx, sid, rid, action)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)

    if action[:flip] == 2
      @totalsactivities[aidx][gidx][:flip2] += 1
#      @userdata[rid].addflip2(aidx,gidx)
      @userdata[sid].addflip2(aidx,gidx)
    elsif action[:flip] == 4
      @totalsactivities[aidx][gidx][:flip4] += 1
#      @userdata[rid].addflip4(aidx,gidx)
      @userdata[sid].addflip4(aidx,gidx)
    end
    if action[:split] == 2
      @totalsactivities[aidx][gidx][:split2] += 1
      @userdata[rid].addsplit2rec(aidx,gidx)
      @userdata[sid].addsplit2(aidx,gidx)
    elsif action[:split] == 4
      @totalsactivities[aidx][gidx][:split4] += 1
#      @userdata[rid].addsplit4(aidx,gidx)
      @userdata[sid].addsplit4(aidx,gidx)
    end
    if action[:accept] == 1
      @totalsactivities[aidx][gidx][:accept] += 1
      @userdata[rid].addaccept(aidx,gidx)
#      @userdata[sid].addaccept(aidx,gidx)
    end
    if action[:challenge] == 1
      @totalsactivities[aidx][gidx][:challenge] += 1
      @userdata[rid].addchallenge(aidx,gidx)
#      @userdata[sid].addchallenge(aidx,gidx)
    end
    
    if action[:flip] == 4 && action[:split] == 2
      @totalsactivities[aidx][gidx][:lies] += 1
#      Rails.logger.debug("Lie rid = " + rid.to_s)
#      @userdata[rid].addlie(aidx,gidx)
#      Rails.logger.debug("Lie sid = " + sid.to_s)
      @userdata[sid].addlie(aidx,gidx)
    end
    senderscore, receiverscore = getscore(action[:flip], action[:split], action[:accept])
    @userdata[sid].updatesendscore(aidx, gidx, senderscore)
    @userdata[rid].updaterecscore(aidx, gidx, receiverscore)
          
  end

  def updateusertotals()
    for pid in 1..40
      @lies[pid] = @userdata[pid].getlies(@activeindex)
      @challenges[pid] = @userdata[pid].getchallenges(@activeindex)
    end
#    Rails.logger.debug("updateusertotals() @lies = " + @lies.inspect)     
#    Rails.logger.debug("updateusertotals() @challenges = " + @challenges.inspect)     
    for pid in 1..40
      @userdata[pid].updatemytotals(@activeindex,@lies,@challenges)
    end
  end

  ##############################################################################
  def getscore(flip,split,accept)
    ##############################################################################
    receiver = 0
    sender = 0

    if flip == 2
      if accept == 1
        receiver = 1
        sender = 1
      else
        receiver = 0
        sender = 2
      end
    else
      case split
      when 2
        if accept == 1
          receiver = 1
          sender = 3
        else
          receiver = 4
          sender = 0
        end
      when 4
        receiver = 2
        sender = 2
      end
    end
    return sender,receiver
  end

  ##############################################################################
  def getsaveableactivites()
    ##############################################################################
    newline = "\n"
    comma = ","
    groupname = Array["Unk","Same","Diff"]
    header = "Round,Gouping,SenderID,ReceiverID,Send Group, Receiver Group, Coin, Message, Challenge"
    csvdata = ""
    csvdata += header + newline
    for aidx in 0..1
      for gidx in 0..2
        for sid in 1..40
          @activities[aidx][gidx][sid].each_value { |activity|
           nextactivity = ""
           nextactivity += aidx.to_s + comma
           nextactivity += groupname[gidx].to_s + comma
           nextactivity += activity[:sid].to_s + comma
           nextactivity += activity[:rid].to_s + comma
           nextactivity += activity[:sg].to_s + comma
           nextactivity += activity[:rg].to_s + comma
           nextactivity += activity[:flip].to_s + comma
           nextactivity += activity[:split].to_s + comma
           nextactivity += activity[:challenge].to_s + newline
           csvdata += nextactivity.to_s
          }
        end
      end
    end
    return csvdata
  end

  def initinteractions
        @interactions[1][0][Constants::Diff] = [21,22,23,24,25,26]
        @interactions[1][0][Constants::Same] = [5,6,7,8,9,10]
        @interactions[1][0][Constants::Unk]  = [2,3,4,27,28,29]
        
        @interactions[2][0][Constants::Diff] = [22,23,24,25,26,27]
        @interactions[2][0][Constants::Same] = [4,5,6,7,8,9]
        @interactions[2][0][Constants::Unk]  = [3,10,1,28,29,30]
        
        @interactions[3][0][Constants::Diff] = [23,24,25,26,27,28]
        @interactions[3][0][Constants::Same] = [4,5,6,7,8,10]
        @interactions[3][0][Constants::Unk]  = [9,1,2,21,29,30]
        
        @interactions[4][0][Constants::Diff] = [24,25,26,27,28,29]
        @interactions[4][0][Constants::Same] = [5,6,7,8,2,3]
        @interactions[4][0][Constants::Unk]  = [9,10,1,30,21,22]
        
        @interactions[5][0][Constants::Diff] = [25,26,27,28,29,30]
        @interactions[5][0][Constants::Same] = [9,10,1,2,3,4]
        @interactions[5][0][Constants::Unk]  = [6,7,8,21,22,23]
        
        @interactions[6][0][Constants::Diff] = [26,27,28,29,30,21]
        @interactions[6][0][Constants::Same] = [9,10,1,2,3,4]
        @interactions[6][0][Constants::Unk]  = [7,8,5,22,23,24]
        
        @interactions[7][0][Constants::Diff] = [27,28,29,30,21,22]
        @interactions[7][0][Constants::Same] = [8,9,1,2,3,4]
        @interactions[7][0][Constants::Unk]  = [10,5,6,23,24,25]
        
        @interactions[8][0][Constants::Diff] = [28,29,30,21,22,23]
        @interactions[8][0][Constants::Same] = [10,1,2,3,4,7]
        @interactions[8][0][Constants::Unk]  = [9,5,6,24,25,26]
        
        @interactions[9][0][Constants::Diff] = [29,30,21,22,23,24]
        @interactions[9][0][Constants::Same] = [10,1,2,5,6,7]
        @interactions[9][0][Constants::Unk]  = [3,4,8,25,26,27]
        
        @interactions[10][0][Constants::Diff] = [30,21,22,23,24,25]
        @interactions[10][0][Constants::Same] = [1,3,5,6,8,9]
        @interactions[10][0][Constants::Unk]  = [2,4,7,26,27,28]
        
        @interactions[11][0][Constants::Diff] = [31,32,33,34,35,36]
        @interactions[11][0][Constants::Same] = [15,16,17,18,19,20]
        @interactions[11][0][Constants::Unk]  = [12,13,14,37,38,39]
        
        @interactions[12][0][Constants::Diff] = [32,33,34,35,36,37]
        @interactions[12][0][Constants::Same] = [14,15,16,17,18,19]
        @interactions[12][0][Constants::Unk]  = [13,20,11,38,39,40]
        
        @interactions[13][0][Constants::Diff] = [33,34,35,36,37,38]
        @interactions[13][0][Constants::Same] = [14,15,16,17,18,20]
        @interactions[13][0][Constants::Unk]  = [19,11,12,39,40,31]
        
        @interactions[14][0][Constants::Diff] = [34,35,36,37,38,39]
        @interactions[14][0][Constants::Same] = [15,16,17,18,12,13]
        @interactions[14][0][Constants::Unk]  = [19,20,11,40,31,32]
        
        @interactions[15][0][Constants::Diff] = [35,36,37,38,39,40]
        @interactions[15][0][Constants::Same] = [19,20,11,12,13,14]
        @interactions[15][0][Constants::Unk]  = [16,17,18,31,32,33]
        
        @interactions[16][0][Constants::Diff] = [36,37,38,39,40,31]
        @interactions[16][0][Constants::Same] = [19,20,11,12,13,14]
        @interactions[16][0][Constants::Unk]  = [17,18,15,32,33,34]
        
        @interactions[17][0][Constants::Diff] = [37,38,39,40,31,32]
        @interactions[17][0][Constants::Same] = [18,19,11,12,13,14]
        @interactions[17][0][Constants::Unk]  = [20,15,16,33,34,35]
        
        @interactions[18][0][Constants::Diff] = [38,39,40,31,32,33]
        @interactions[18][0][Constants::Same] = [20,11,12,13,14,17]
        @interactions[18][0][Constants::Unk]  = [19,15,16,34,35,36]
        
        @interactions[19][0][Constants::Diff] = [39,40,31,32,33,34]
        @interactions[19][0][Constants::Same] = [20,11,12,15,16,17]
        @interactions[19][0][Constants::Unk]  = [13,14,18,35,36,37]
        
        @interactions[20][0][Constants::Diff] = [40,31,32,33,34,35]
        @interactions[20][0][Constants::Same] = [11,13,15,16,18,19]
        @interactions[20][0][Constants::Unk]  = [12,14,17,36,37,38]
        
        @interactions[21][0][Constants::Diff] = [1,6,7,8,9,10]
        @interactions[21][0][Constants::Same] = [25,26,27,28,29,30]
        @interactions[21][0][Constants::Unk]  = [3,4,5,22,23,24]
        
        @interactions[22][0][Constants::Diff] = [1,2,7,8,9,10]
        @interactions[22][0][Constants::Same] = [24,25,26,27,28,29]
        @interactions[22][0][Constants::Unk]  = [4,5,6,23,30,21]
        
        @interactions[23][0][Constants::Diff] = [1,2,3,8,9,10]
        @interactions[23][0][Constants::Same] = [24,25,26,27,28,30]
        @interactions[23][0][Constants::Unk]  = [5,6,7,29,21,22]
        
        @interactions[24][0][Constants::Diff] = [1,2,3,4,9,10]
        @interactions[24][0][Constants::Same] = [25,26,27,28,22,23]
        @interactions[24][0][Constants::Unk]  = [6,7,8,29,30,21]
        
        @interactions[25][0][Constants::Diff] = [1,2,3,4,5,10]
        @interactions[25][0][Constants::Same] = [29,30,21,22,23,24]
        @interactions[25][0][Constants::Unk]  = [7,8,9,26,27,28]
        
        @interactions[26][0][Constants::Diff] = [1,2,3,4,5,6]
        @interactions[26][0][Constants::Same] = [29,30,21,22,23,24]
        @interactions[26][0][Constants::Unk]  = [8,9,10,27,28,25]
        
        @interactions[27][0][Constants::Diff] = [2,3,4,5,6,7]
        @interactions[27][0][Constants::Same] = [28,29,21,22,23,24]
        @interactions[27][0][Constants::Unk]  = [1,9,10,30,25,26]
        
        @interactions[28][0][Constants::Diff] = [3,4,5,6,7,8]
        @interactions[28][0][Constants::Same] = [30,21,22,23,24,27]
        @interactions[28][0][Constants::Unk]  = [1,2,10,29,25,26]
        
        @interactions[29][0][Constants::Diff] = [4,5,6,7,8,9]
        @interactions[29][0][Constants::Same] = [30,21,22,25,26,27]
        @interactions[29][0][Constants::Unk]  = [1,2,3,23,24,28]
        
        @interactions[30][0][Constants::Diff] = [5,6,7,8,9,10]
        @interactions[30][0][Constants::Same] = [21,23,25,26,28,29]
        @interactions[30][0][Constants::Unk]  = [2,3,4,22,27,24]
        
        @interactions[31][0][Constants::Diff] = [11,16,17,18,19,20]
        @interactions[31][0][Constants::Same] = [35,36,37,38,39,40]
        @interactions[31][0][Constants::Unk]  = [13,14,15,32,33,34]
        
        @interactions[32][0][Constants::Diff] = [11,12,17,18,19,20]
        @interactions[32][0][Constants::Same] = [34,35,36,37,38,39]
        @interactions[32][0][Constants::Unk]  = [14,15,16,33,40,31]
        
        @interactions[33][0][Constants::Diff] = [11,12,13,18,19,20]
        @interactions[33][0][Constants::Same] = [34,35,36,37,38,40]
        @interactions[33][0][Constants::Unk]  = [15,16,17,39,31,32]
        
        @interactions[34][0][Constants::Diff] = [11,12,13,14,19,20]
        @interactions[34][0][Constants::Same] = [35,36,37,38,32,33]
        @interactions[34][0][Constants::Unk]  = [16,17,18,39,40,31]
        
        @interactions[35][0][Constants::Diff] = [11,12,13,14,15,20]
        @interactions[35][0][Constants::Same] = [39,40,31,32,33,34]
        @interactions[35][0][Constants::Unk]  = [17,18,19,36,37,38]
        
        @interactions[36][0][Constants::Diff] = [11,12,13,14,15,16]
        @interactions[36][0][Constants::Same] = [39,40,31,32,33,34]
        @interactions[36][0][Constants::Unk]  = [18,19,20,37,38,35]
        
        @interactions[37][0][Constants::Diff] = [12,13,14,15,16,17]
        @interactions[37][0][Constants::Same] = [38,39,31,32,33,34]
        @interactions[37][0][Constants::Unk]  = [11,19,20,40,35,36]
        
        @interactions[38][0][Constants::Diff] = [13,14,15,16,17,18]
        @interactions[38][0][Constants::Same] = [40,31,32,33,34,37]
        @interactions[38][0][Constants::Unk]  = [11,12,20,39,33,34]
        
        @interactions[39][0][Constants::Diff] = [14,15,16,17,18,19]
        @interactions[39][0][Constants::Same] = [40,31,32,35,36,37]
        @interactions[39][0][Constants::Unk]  = [11,12,13,34,37,36]
        
        @interactions[40][0][Constants::Diff] = [15,16,17,18,19,20]
        @interactions[40][0][Constants::Same] = [31,33,35,36,38,39]
        @interactions[40][0][Constants::Unk]  = [12,13,14,32,35,38]

    
 
    
        @interactions[1][1][Constants::Diff] = [31,32,33,34,35,36]
        @interactions[1][1][Constants::Same] = [11,20,19,18,17,16]
        @interactions[1][1][Constants::Unk]  = [15,14,13,37,38,39]
        
        @interactions[2][1][Constants::Diff] = [32,33,34,35,36,37]
        @interactions[2][1][Constants::Same] = [12,11,20,19,18,17]
        @interactions[2][1][Constants::Unk]  = [16,15,14,38,39,40]
        
        @interactions[3][1][Constants::Diff] = [33,34,35,36,37,38]
        @interactions[3][1][Constants::Same] = [13,12,11,20,19,18]
        @interactions[3][1][Constants::Unk]  = [17,16,15,39,40,31]
        
        @interactions[4][1][Constants::Diff] = [34,35,36,37,38,39]
        @interactions[4][1][Constants::Same] = [14,13,12,11,20,19]
        @interactions[4][1][Constants::Unk]  = [18,17,16,40,31,32]
        
        @interactions[5][1][Constants::Diff] = [35,36,37,38,39,40]
        @interactions[5][1][Constants::Same] = [15,14,13,12,11,20]
        @interactions[5][1][Constants::Unk]  = [19,18,17,31,32,33]
        
        @interactions[6][1][Constants::Diff] = [36,37,38,39,40,31]
        @interactions[6][1][Constants::Same] = [16,15,14,13,12,11]
        @interactions[6][1][Constants::Unk]  = [20,19,18,32,33,34]
        
        @interactions[7][1][Constants::Diff] = [37,38,39,40,31,32]
        @interactions[7][1][Constants::Same] = [17,16,15,14,13,12]
        @interactions[7][1][Constants::Unk]  = [11,20,19,33,34,35]
        
        @interactions[8][1][Constants::Diff] = [38,39,40,31,32,33]
        @interactions[8][1][Constants::Same] = [18,17,16,15,14,13]
        @interactions[8][1][Constants::Unk]  = [12,11,20,34,35,36]
        
        @interactions[9][1][Constants::Diff] = [39,40,31,32,33,34]
        @interactions[9][1][Constants::Same] = [19,18,17,16,15,14]
        @interactions[9][1][Constants::Unk]  = [13,12,11,35,36,37]
        
        @interactions[10][1][Constants::Diff] = [40,31,32,33,34,35]
        @interactions[10][1][Constants::Same] = [20,19,18,17,16,15]
        @interactions[10][1][Constants::Unk]  = [14,13,12,36,37,38]
        
        @interactions[11][1][Constants::Diff] = [21,22,23,24,25,26]
        @interactions[11][1][Constants::Same] = [1,2,3,4,5,6]
        @interactions[11][1][Constants::Unk]  = [7,8,9,27,28,29]
        
        @interactions[12][1][Constants::Diff] = [22,23,24,25,26,27]
        @interactions[12][1][Constants::Same] = [2,3,4,5,6,7]
        @interactions[12][1][Constants::Unk]  = [8,9,10,28,29,30]
        
        @interactions[13][1][Constants::Diff] = [23,24,25,26,27,28]
        @interactions[13][1][Constants::Same] = [3,4,5,6,7,8]
        @interactions[13][1][Constants::Unk]  = [9,10,1,29,30,21]
        
        @interactions[14][1][Constants::Diff] = [24,25,26,27,28,29]
        @interactions[14][1][Constants::Same] = [4,5,6,7,8,9]
        @interactions[14][1][Constants::Unk]  = [10,1,2,30,21,22]
        
        @interactions[15][1][Constants::Diff] = [25,26,27,28,29,30]
        @interactions[15][1][Constants::Same] = [5,6,7,8,9,10]
        @interactions[15][1][Constants::Unk]  = [1,2,3,21,22,23]
        
        @interactions[16][1][Constants::Diff] = [26,27,28,29,30,21]
        @interactions[16][1][Constants::Same] = [6,7,8,9,10,1]
        @interactions[16][1][Constants::Unk]  = [2,3,4,22,23,24]
        
        @interactions[17][1][Constants::Diff] = [27,28,29,30,21,22]
        @interactions[17][1][Constants::Same] = [7,8,9,10,1,2]
        @interactions[17][1][Constants::Unk]  = [3,4,5,23,24,25]
        
        @interactions[18][1][Constants::Diff] = [28,29,30,21,22,23]
        @interactions[18][1][Constants::Same] = [8,9,10,1,2,3]
        @interactions[18][1][Constants::Unk]  = [4,5,6,24,25,26]
        
        @interactions[19][1][Constants::Diff] = [29,30,21,22,23,24]
        @interactions[19][1][Constants::Same] = [9,10,1,2,3,4]
        @interactions[19][1][Constants::Unk]  = [5,6,7,25,26,27]
        
        @interactions[20][1][Constants::Diff] = [30,21,22,23,24,25]
        @interactions[20][1][Constants::Same] = [10,1,2,3,4,5]
        @interactions[20][1][Constants::Unk]  = [6,7,8,26,27,28]
        
        @interactions[21][1][Constants::Diff] = [11,20,19,18,17,16]
        @interactions[21][1][Constants::Same] = [31,40,39,38,37,36]
        @interactions[21][1][Constants::Unk]  = [15,14,13,35,34,33]
        
        @interactions[22][1][Constants::Diff] = [12,11,20,19,18,17]
        @interactions[22][1][Constants::Same] = [32,31,40,39,38,37]
        @interactions[22][1][Constants::Unk]  = [16,15,14,36,35,34]
        
        @interactions[23][1][Constants::Diff] = [13,12,11,20,19,18]
        @interactions[23][1][Constants::Same] = [33,32,31,40,39,38]
        @interactions[23][1][Constants::Unk]  = [17,16,15,37,36,35]
        
        @interactions[24][1][Constants::Diff] = [14,13,12,11,20,19]
        @interactions[24][1][Constants::Same] = [34,33,32,31,40,39]
        @interactions[24][1][Constants::Unk]  = [18,17,16,38,37,36]
        
        @interactions[25][1][Constants::Diff] = [15,14,13,12,11,20]
        @interactions[25][1][Constants::Same] = [35,34,33,32,31,40]
        @interactions[25][1][Constants::Unk]  = [19,18,17,39,38,37]
        
        @interactions[26][1][Constants::Diff] = [16,15,14,13,12,11]
        @interactions[26][1][Constants::Same] = [36,35,34,33,32,31]
        @interactions[26][1][Constants::Unk]  = [20,19,18,40,39,38]
        
        @interactions[27][1][Constants::Diff] = [17,16,15,14,13,12]
        @interactions[27][1][Constants::Same] = [37,36,35,34,33,32]
        @interactions[27][1][Constants::Unk]  = [11,20,19,31,40,39]
        
        @interactions[28][1][Constants::Diff] = [18,17,16,15,14,13]
        @interactions[28][1][Constants::Same] = [38,37,36,35,34,33]
        @interactions[28][1][Constants::Unk]  = [12,11,20,32,31,40]
        
        @interactions[29][1][Constants::Diff] = [19,18,17,16,15,14]
        @interactions[29][1][Constants::Same] = [39,38,37,36,35,34]
        @interactions[29][1][Constants::Unk]  = [13,12,11,33,32,31]
        
        @interactions[30][1][Constants::Diff] = [20,19,18,17,16,15]
        @interactions[30][1][Constants::Same] = [40,39,38,37,36,35]
        @interactions[30][1][Constants::Unk]  = [14,13,12,34,33,32]
        
        @interactions[31][1][Constants::Diff] = [1,10,9,8,7,6]
        @interactions[31][1][Constants::Same] = [21,22,23,24,25,26]
        @interactions[31][1][Constants::Unk]  = [5,4,3,27,28,29]
        
        @interactions[32][1][Constants::Diff] = [2,1,10,9,8,7]
        @interactions[32][1][Constants::Same] = [22,23,24,25,26,27]
        @interactions[32][1][Constants::Unk]  = [6,5,4,28,29,30]
        
        @interactions[33][1][Constants::Diff] = [3,2,1,10,9,8]
        @interactions[33][1][Constants::Same] = [23,24,25,26,27,28]
        @interactions[33][1][Constants::Unk]  = [7,6,5,29,30,21]
        
        @interactions[34][1][Constants::Diff] = [4,3,2,1,10,9]
        @interactions[34][1][Constants::Same] = [24,25,26,27,28,29]
        @interactions[34][1][Constants::Unk]  = [8,7,6,30,21,22]
        
        @interactions[35][1][Constants::Diff] = [5,4,3,2,1,10]
        @interactions[35][1][Constants::Same] = [25,26,27,28,29,30]
        @interactions[35][1][Constants::Unk]  = [9,8,7,21,22,23]
        
        @interactions[36][1][Constants::Diff] = [6,5,4,3,2,1]
        @interactions[36][1][Constants::Same] = [26,27,28,29,30,21]
        @interactions[36][1][Constants::Unk]  = [10,9,8,22,23,24]
        
        @interactions[37][1][Constants::Diff] = [7,6,5,4,3,2]
        @interactions[37][1][Constants::Same] = [27,28,29,30,21,22]
        @interactions[37][1][Constants::Unk]  = [1,10,9,23,24,25]
        
        @interactions[38][1][Constants::Diff] = [8,7,6,5,4,3]
        @interactions[38][1][Constants::Same] = [28,29,30,21,22,23]
        @interactions[38][1][Constants::Unk]  = [2,1,10,24,25,26]
        
        @interactions[39][1][Constants::Diff] = [9,8,7,6,5,4]
        @interactions[39][1][Constants::Same] = [29,30,21,22,23,24]
        @interactions[39][1][Constants::Unk]  = [3,2,1,25,26,27]
        
        @interactions[40][1][Constants::Diff] = [10,9,8,7,6,5]
        @interactions[40][1][Constants::Same] = [30,21,22,23,24,25]
        @interactions[40][1][Constants::Unk]  = [4,3,2,26,27,28]
    
    

  end


  ##############################################################################
  def initinteractionsdisabled
    # Populates the interaction table of which user plays against which user.
    ##############################################################################

    for id in 1..20 do
      for act in 0..5 do
        diff1value = 20 + id + act
        diff1value = diff1value - 20 if diff1value > 40

        diff2value = 20 + id + act + 6
        diff2value = diff2value - 20 if diff2value > 40

        same1value =  1 + id + act
        same1value = same1value - 20 if same1value > 20

        same2value =  1 + id + act + 6
        same2value = same2value - 20 if same2value > 20

        unk1value =  1 + id + act + 12 unless act > 2
        unk1value =  20 + id + act + 9 unless act < 3
        unk1value = unk1value - 20 if unk1value > 20 && act < 3
        unk1value = unk1value - 20 if unk1value > 40 && act > 2

        unk2value =  1 + id + act + 15 unless act > 2
        unk2value =  20 + id + act + 12 unless act < 3
        unk2value = unk2value - 20 if unk2value > 20 && act < 3
        unk2value = unk2value - 20 if unk2value > 40 && act > 2

        @interactions[id][0][Constants::Diff][act] = diff1value
        @interactions[id][1][Constants::Diff][act] = diff2value

        @interactions[id][0][Constants::Same][act] = same1value
        @interactions[id][1][Constants::Same][act] = same2value

        @interactions[id][0][Constants::Unk][act] = unk1value
        @interactions[id][1][Constants::Unk][act] = unk2value

        g2id = id + 20
        diff1value = 21 - id - act
        diff1value = diff1value + 20 if diff1value < 1

        diff2value = 21 - id - act - 6
        diff2value = diff2value + 20 if diff2value < 1

        same1value =  21 + id + act
        same1value = same1value - 20 if same1value > 40

        same2value =  21 + id + act + 6
        same2value = same2value - 20 if same2value > 40

        unk1value =  21 + id + act + 12 unless act > 2
        unk1value =  21 - id - act - 9 unless act < 3
        unk1value = unk1value - 20 if unk1value > 40 && act < 3
        unk1value = unk1value + 20 if unk1value < 1 && act > 2

        unk2value =  21 + id + act + 15 unless act > 2
        unk2value =  21 - id - act - 12 unless act < 3
        unk2value = unk2value - 20 if unk2value > 40 && act < 3
        unk2value = unk2value + 20 if unk2value < 1 && act > 2

        @interactions[g2id][0][Constants::Diff][act] = diff1value
        @interactions[g2id][1][Constants::Diff][act] = diff2value

        @interactions[g2id][0][Constants::Same][act] = same1value
        @interactions[g2id][1][Constants::Same][act] = same2value

        @interactions[g2id][0][Constants::Unk][act] = unk1value
        @interactions[g2id][1][Constants::Unk][act] = unk2value

      end
    end
        Rails.logger.debug("id,phase,type,a1,a2,a3,b1,b2,b3")
        for dbi in 1..40 do
          for grp in 0..1 do
            for grping in 0..2 do
              Rails.logger.debug(dbi.to_s + "," +  grp.to_s + "," +  grping.to_s + "," + @interactions[dbi][grp][grping].join(","))
            end
          end
        end
  end

end




