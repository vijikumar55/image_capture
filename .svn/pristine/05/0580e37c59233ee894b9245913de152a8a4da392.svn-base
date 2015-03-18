module Gentestdata
  ##############################################################################
  def gentestdata()
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
#    Rails.logger.debug("gentestdata - $gExperiment.state = " + $gExperiment.state.inspect)
    if ($gExperiment.state == Constants::StateGuess1 || $gExperiment.state == Constants::StateGuess2)
      unless $gTestControl[:testguessflag][$gExperiment.activeindex]
        Rails.logger.warn("**Generating Test Guess Data")
        for pid1 in 1..40
          if !$gExperiment.usersonline[pid1]
            createguesses(pid1)
          end
        end
        $gTestControl[:testguessflag][$gExperiment.activeindex] = true
      end
    end
    if ($gExperiment.state == Constants::StateSend1 || $gExperiment.state == Constants::StateSend2)
      unless $gTestControl[:gentestdataloaded][$gExperiment.activeindex]
        Rails.logger.warn("**Generating Test Send Data")
        for pid2 in 1..40
          if !$gExperiment.usersonline[pid2]
            createrandomdata(pid2,$gExperiment.interactions[pid2][$gExperiment.activeindex][Constants::Unk], "unk")
            createrandomdata(pid2,$gExperiment.interactions[pid2][$gExperiment.activeindex][Constants::Same], "same")
            createrandomdata(pid2,$gExperiment.interactions[pid2][$gExperiment.activeindex][Constants::Diff], "diff" )
          end
        end
        $gTestControl[:gentestdataloaded][$gExperiment.activeindex] = true
        #      Rails.logger.debug("$gExperiment.activities[$gExperiment.activeindex] = " + $gExperiment.activities[$gExperiment.activeindex].inspect)
      end
      unless $gTestControl[:doneflag][$gExperiment.activeindex]
         for pid2a in 1..40
          if !$gExperiment.usersonline[pid2a]
            $gExperiment.resultsdone(pid2a)
            $gExperiment.genuserexit(pid2a)
          end
        end
        $gTestControl[:doneflag][$gExperiment.activeindex] = true
      end
    end
    if ($gExperiment.state == Constants::StateRec1 || $gExperiment.state == Constants::StateRec2)
      unless $gTestControl[:testrecflag][$gExperiment.activeindex]
        Rails.logger.warn("**Generating Test Receive Data")
        for pid3 in 1..40
          if !$gExperiment.usersonline[pid3]
            fakerecdata(pid3, $gExperiment.userdata[pid3])
          end
        end
        $gTestControl[:testrecflag][$gExperiment.activeindex] = true
      end
    end
    if ( $gExperiment.state == Constants::StatePayout )
      unless $gTestControl[:payout]
        Rails.logger.warn("**Generating Test Payout Data")
        for pid4 in 1..40
          if !$gExperiment.usersonline[pid4]
            fakepayoutdata(pid4, $gExperiment.userdata[pid4])
          end
        end
        $gTestControl[:payout] = true
      end
    end
  end

  ##############################################################################
  def gentestinittestcontrol()
  ##############################################################################
    $gTestControl = Hash.new()
    $gTestControl[:testguessflag] = Array.new(2,false)
    $gTestControl[:gentestdataloaded] = Array.new(2,false)
    $gTestControl[:testrecflag] = Array.new(2,false)
    $gTestControl[:doneflag] = Array.new(2,false)
    $gTestControl[:payout] = false
#    Rails.logger.warn("*Test Generator Initialized")
  end

  ##############################################################################
  def createrandomdata(pid,interacts, grouping)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    for idx in 0..5
      rid = interacts[idx]
      flip = flipcoin()
      split = splitflip(flip)
#        Rails.logger.debug("pid = " + pid.inspect + "   rid = " + rid.to_s + "   flip = " + flip.to_s + "   split = " + split.to_s + "  gouping = " + grouping.inspect)
      $gExperiment.recordsenddata(pid,rid.to_i,flip.to_i,split.to_i,grouping)
    end
    $gExperiment.senddone(pid) if grouping == "diff"
  end

  ##############################################################################
  def flipcoin()
    ##############################################################################
    flipvalue = rand()
    if flipvalue < 0.5
      coinflip = 2
    else
      coinflip = 4
    end
    return coinflip
  end

  ##############################################################################
  def splitflip(flip)
    ##############################################################################
    if flip == 2
      splitvalue = 2
    else
      randvalue = rand()
      if randvalue < 0.5
        splitvalue = 2
      else
        splitvalue = 4
      end
    end
    return splitvalue
  end

  ##############################################################################
  def fakerecdata(pid, userdata)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s)
    rechash = Hash.new()
    recdata = userdata.getdatatosend(rechash,"rec")
#    Rails.logger.debug("fakerecdata - recdata = " + recdata.inspect)
    processtestrecdata(pid, recdata[:unkrec], "unk")
    processtestrecdata(pid, recdata[:samerec], "same")
    processtestrecdata(pid, recdata[:diffrec], "diff")
  end

  ##############################################################################
  def processtestrecdata(pid, recdata, grouping)
    ##############################################################################
#    Rails.logger.debug("def " + __method__.to_s + "    Called by : " + __callee__.to_s)
    unless recdata.nil?
#      Rails.logger.debug("processtestrecdata - recdata = " + recdata.inspect)
      for idx in 0..5
        sidx = idx
        sid = recdata[sidx][:sid]
        split = recdata[sidx][:split]
        if split == 4
          accept = 1
          challenge = 0
        else
#          randvalue = rand()
#          if randvalue < 0.5
#            accept = 1
#            challenge = 0
#          else
            accept = 0
            challenge = 1
#          end
        end
        $gExperiment.recordreceivedata(pid,sid.to_i,accept,challenge,grouping)
      end
      $gExperiment.recdone(pid) if grouping == "diff"
    end
  end

  def createguesses(pid)
    for idx in 0..2
      $gExperiment.userdata[pid].makeguess((rand * 100).to_i, (rand * 100).to_i, (rand * 100).to_i, (rand * 100).to_i, (rand * 100).to_i, (rand * 100).to_i)
    end
  end
  
  def fakepayoutdata(pid, userdata)
    fakeguesspayment(pid, userdata)
    fakeinteractpayment(pid, userdata)
    name = "AutoBotFirstName" + pid.to_s + " AutoBotLastName" + pid.to_s
    userdata.savename(name)
    $gExperiment.finished(pid)
  end
  
  def fakeguesspayment(pid, userdata)
    paymenthash = Hash.new()
    payoutdata = Array.new(2){|i| Array.new(6)}
     for aix in 0..1
      earnedsend,earnedrec = userdata.getearned(aix)
      for idx in 0..2
        payoutdata[aix][idx] = earnedsend[idx]
        payoutdata[aix][idx + 3 ] = earnedrec[idx]
      end
    end

    roll1 = (rand * 5).round.to_i
    roll2 = (rand * 5).round.to_i
    paymenthash[:roll1] = roll1.to_i
    paymenthash[:roll2] = roll2.to_i
    paymenthash[:amount1] = payoutdata[0][roll1]
    paymenthash[:amount2] = payoutdata[1][roll2]

    userdata.updateguesspayout(paymenthash)
  end

  def fakeinteractpayment(pid, userdata)
    paymenthash = Hash.new()
    payouthistory = Array.new(2){|i| Array.new(6)}

     for aix in 0..1
      history = userdata.gethistorydata(aix)
        payouthistory[aix][0] = history[:send][:unk]
        payouthistory[aix][1] = history[:send][:same]
        payouthistory[aix][2] = history[:send][:diff]
        payouthistory[aix][3] = history[:rec][:unk]
        payouthistory[aix][4] = history[:rec][:same]
        payouthistory[aix][5] = history[:rec][:diff]
    end

    roll1 = (rand * 5).round.to_i
    roll2 = (rand * 5).round.to_i
    roll3 = (rand * 5).round.to_i
    roll4 = (rand * 5).round.to_i

    paymenthash[:roll1] = roll1.to_i
    paymenthash[:roll2] = roll2.to_i
    paymenthash[:roll3] = roll3.to_i
    paymenthash[:roll4] = roll4.to_i
#    Rails.logger.warn("payouthistory[0][roll1][roll2][0] = " + payouthistory[0][roll1][roll2][0].inspect)
#    Rails.logger.warn("paymenthash = " + paymenthash.inspect)
    paymenthash[:amount1] = payouthistory[0][roll1][roll2][0][:pay].to_f
    paymenthash[:amount2] = payouthistory[1][roll3][roll4][0][:pay].to_f

    userdata.updateinteractpayout(paymenthash)
  end

end
