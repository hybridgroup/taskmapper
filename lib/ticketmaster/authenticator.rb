module TicketMasterMod
  class Authenticator
    attr_reader :username, :password, :token

    def initialize(info)
      @username, @password, @token = info[:username], info[:password], info[:token]
    end
  end
end
