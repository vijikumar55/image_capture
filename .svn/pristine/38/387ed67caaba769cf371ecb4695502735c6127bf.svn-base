class DataaccessController < ApplicationController
  before_filter :validatecontrol

  def index
    @path = "data"
    Dir.chdir("public/data"){
      @guessfiles = Dir.glob("guess*")
      @interactionsfiles = Dir.glob("interactions*")
      @payoutfiles = Dir.glob("payout*")

      @guessfiles.sort!.reverse!
      @interactionsfiles.sort!.reverse!
      @payoutfiles.sort!.reverse!
    }
    @rowcount = @guessfiles.length - 1
    @rowcount = 0 if @rowcount < 0

  end
end
