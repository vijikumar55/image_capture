################################################################################
class ConfigData
  ##############################################################################
  attr_reader :logindata
  attr_reader :amount
  attr_reader :payoutscale

  ##############################################################################
  def initialize()
    ##############################################################################
    loginyamldata = YAML.load_file( Rails.root.to_s + "/config/control.yml")
    @logindata = loginyamldata["logindata"]
    @experimentdata = YAML.load_file( Rails.root.to_s + "/config/experimentconfigdata.yml")
    @amount = @experimentdata[:amount]
    @payoutscale = @experimentdata[:payoutscale]
#          Rails.logger.debug("@amount = " + @amount.inspect)
#          Rails.logger.debug("@experimentdata = " + @experimentdata.inspect)
#          Rails.logger.debug("ConfigData.@experimentdata = " + @experimentdata.to_yaml)
  end

  def newamount(newvalue)
    @experimentdata[:amount] = newvalue
    @amount = newvalue
    saveconfigdata()
  end

  def saveconfigdata()
    File.open( Rails.root.to_s + "/config/experimentconfigdata.yml", "w" ) do |out|
      YAML.dump( @experimentdata, out )
    end
  end
end
