# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module Weixin

  class MessageCustom < Api

    def gw_path(method)
      "/message/custom/#{method}?access_token=#{access_token}"
    end

    def send(message)
      response = Nestful::Connection.new(endpoint).post("/cgi-bin#{gw_path('send')}", MultiJson.dump(message)) rescue nil
      unless response.nil?
        errcode = MultiJson.load(response.body)['errcode']
        return true, 0 if errcode == 0
      end
      return false, errcode
    end

  end

end
