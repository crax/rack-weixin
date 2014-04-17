# -*- encoding: utf-8 -*-
require 'weixin/version'
require 'weixin/middleware'
require 'weixin/api'
require 'weixin/menu'
require 'weixin/user'
require 'weixin/message_custom'
require 'weixin/client'
require 'weixin/model'
require 'weixin/qrcode'

module Weixin
  
  extend self

  def music(title, desc, music_url, hq_music_url)
    item = Music.new
    item.Title = title
    item.Description = desc
    item.MusicUrl    = music_url
    item.HQMusicUrl  = hq_music_url
    item
  end

  def item(title, desc, pic_url, link_url)
    item = Item.new
    item.Title = title
    item.Description = desc
    item.PicUrl = pic_url
    item.Url    = link_url
    item
  end

  def text_msg(from, to, content)
    msg = TextReplyMessage.new
    msg.ToUserName   = to
    msg.FromUserName = from
    msg.Content = content
    msg.to_xml
  end

  def music_msg(from, to, music)
    msg = MusicReplyMessage.new
    msg.ToUserName   = to
    msg.FromUserName = from
    msg.Music = music
    msg.to_xml
  end

  def news_msg(from, to, items)
    msg = NewsReplyMessage.new
    msg.ToUserName   = to
    msg.FromUserName = from
    msg.Articles     = items
    msg.ArticleCount = items.count
    msg.to_xml
  end
end
