module Datasave
  $gBaseFileName
  $gGuessBaseFileName = "guess-"
  $gInteractionBaseFileName = "interactions-"
  $gPayoutBaseFileName = "payout-"

  ##############################################################################
  def generatebasefilename()
    ##############################################################################
    $gBaseFileName = Time.now.localtime("-08:00").strftime("%Y-%m-%d-%H-%M-%S")

    Rails.logger.debug("$gBaseFileName = [" + $gBaseFileName.inspect + "]")

  end


  ##############################################################################
  def saveguessdata()
    ##############################################################################
    header = "UserID,Phase,Group,Send2%,Challenge%,ActualSend2,ActualChallenge,SendPayout,ChallengePayouy"
    newline = "\n"
    groupname = Array["Unk","Same","Diff"]
    phasename = Array["1", "3"]

    guessfilename = "#{Rails.root}/public/data/" + $gGuessBaseFileName.to_s + $gBaseFileName.to_s + ".csv"

    guessdata = header + newline
    for phase in 0..1
      for pid in 1..40
        userdata = $gExperiment.userdata[pid]
        usersend,userrec = userdata.getguesses(phase)
        actsend,actrec = userdata.getactuals(phase)
        paysend,payrrec = userdata.getearned(phase)

#        Rails.logger.debug("phase= " + phase.inspect + "  pid= " + pid.inspect)
#        Rails.logger.debug("usersend" + usersend.inspect)
#        Rails.logger.debug("userrec" + userrec.inspect)
#        Rails.logger.debug("actsend" + actsend.inspect)
#        Rails.logger.debug("actrec" + actrec.inspect)
        for group in 0..2 
          guessdata += pid.to_s
          guessdata += "," + phasename[phase].to_s
          guessdata += "," + groupname[group].to_s
          guessdata += "," + (usersend[group] * 100).to_i.to_s
          guessdata += "," + (userrec[group] * 100).to_i.to_s
          guessdata += "," + (actsend[group] * 100).round(2).to_s
          guessdata += "," + (actrec[group] * 100).round(2).to_s
          guessdata += "," + paysend[group].round(2).to_s
          guessdata += "," + payrrec[group].round(2).to_s
          guessdata += newline
        end
      end
    end
    file = File.new(guessfilename, "w+")
    file.write(guessdata)
    file.close()
  end

  def saveactivitydata()
    interactionfilename = "#{Rails.root}/public/data/" + $gInteractionBaseFileName.to_s + $gBaseFileName.to_s + ".csv"
    activitydata = $gExperiment.getsaveableactivites()
    file = File.new(interactionfilename, "w+")
    file.write(activitydata)
    file.close()

  end

  def savepayoutdata()
    header = "UserID,LastName,FisrtName,UserFullName,Roll1,Roll2,Roll3,Roll4,Roll5,Roll6,Amount1,Amount2,Amount3,Amount4,TOTAL"
    newline = "\n"
    payoutfilename = "#{Rails.root}/public/data/" + $gPayoutBaseFileName.to_s + $gBaseFileName.to_s + ".csv"

    payoutdata = header + newline
    for pid in 1..40
        userdata = $gExperiment.userdata[pid]
        payoutdata += pid.to_s + ","
        payoutdata += "\"" + userdata.namelast.to_s + "\"" +","
        payoutdata += "\"" + userdata.namefirst.to_s + "\"" + ","
        payoutdata += "\"" + userdata.name.to_s + "\"" + ","
        payoutdata += (userdata.guesspayout[0][:roll] + 1).to_s + ","
        payoutdata += (userdata.guesspayout[1][:roll] + 1).to_s + ","
        payoutdata += (userdata.interactpayout[0][:roll] + 1).to_s + ","
        payoutdata += (userdata.interactpayout[1][:roll] + 1).to_s + ","
        payoutdata += (userdata.interactpayout[2][:roll] + 1).to_s + ","
        payoutdata += (userdata.interactpayout[3][:roll] + 1).to_s + ","
        payoutdata += userdata.guesspayout[0][:amount].to_s + ","
        payoutdata += userdata.guesspayout[1][:amount].to_s + ","
        payoutdata += userdata.interactpayout[1][:amount].to_s + ","
        payoutdata += userdata.interactpayout[3][:amount].to_s + ","
        payoutdata += "%2.2f" % ((userdata.totalpayout.to_f / 0.25).round * 0.25)  + newline
    end
    file = File.new(payoutfilename, "w+")
    file.write(payoutdata)
    file.close()
  end




end