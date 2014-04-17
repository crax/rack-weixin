# -*- encoding : utf-8 -*-
require 'multi_json'
require 'nestful'

module Weixin

  class QRCode < Api

    def gw_path(method)
      "/qrcode/#{method}?access_token=#{access_token}"
    end

    def image(scene_id)
      ticket_req = {
        expire_seconds: 1800,
        action_name: "QR_SCENE",
        action_info: {
          scene: {scene_id: scene_id}
        }
      }
      response = Nestful::Connection.new(@endpoint).post("/cgi-bin#{gw_path('create')}", MultiJson.dump(ticket_req)) rescue nil
      unless response.nil?
        ret = MultiJson.load(response.body)
        return false, ret['errcode'] if ret.include?('errcode')

        ticket = ret['ticket']
        return true, "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=#{ticket}"
      end

      return false, nil
    end

  end

end
