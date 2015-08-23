# encoding uft8
require 'pathname'
require 'logger'
require 'rest-client'
require 'json'
require 'yajl'

logger = Logger.new('giphy-scraper.log')
base_url = "http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC"
offset = 0
categories = ["crying","dancing","eating","falling","finger+guns","laughing","middle+finger","sleeping","smiling",
"black+and+white","cold","cute","kawaii","nostalgia","slow+motion","trippy","vintage","weird",
"cat","dog","goat","hedgehog","monkey","otter","panda","rabbit","sloth",
"cowboy+bebop","flcl","hamtaro","naruto","one+piece","pokemon","sailor+moon","spirited+away","trigun",
"architecture","cinemagraph","glitch","loop","mash+up","pixel","sculpture","timelapse","typography",
"adventure+time","archer","futurama","king+star+king","minions","regular+show","spongebob+squarepants","the+boondocks","the+simpsons",
"aubrey+plaza","bill+murray","emma+stone","jamie+dornan","jennifer+lawrence","jim+carrey","leonardo+dicaprio","scarlett+johansson","will+ferrell",
"80s","90s","vintage","awkward","bored","confused","drunk","excited","frustrated","hungry","mind+blown","tired",
"cara+delevingne","chanel","dior","karlie+kloss","kate+moss","makeup","miranda+kerr","runway","victorias+secret",
"alcohol","bacon","breakfast","cheeseburger","coffee","doughnut","hot+dog","ice+cream","pizza",
"8bit","bioshock+infinite","game+boy","grand+theft+auto","mortal+kombat","sonic+the+hedgehog","super+mario","super+nintendo","the+sims",
"birthday","christmas","easter","fourth+of+july","halloween","new+years","thanksgiving","valentines+day","wedding",
"baby","ballet","internet","iphone","theme+park","vampire","winter","work","zombie",
"deal+with+it","fangirling","feels","let+me+love+you","party+hard","spinning+lana","steal+yo+girl","surprised+patrick",
"american+psycho","anchorman","harry+potter","kill+bill","scarface","spring+breakers","star+wars","the+hunger+games","the+shining",
"beyonce","daft+punk","david+bowie","justin+bieber","kanye+west","lana+del+rey","miley+cyrus","one+direction","rihanna",
"clouds","forest","lava","northern+lights","ocean","snow","sunrise","waterfall",
"barack+obama","hillary+clinton","joe+biden","nsa","the+colbert+report",
"eye+roll","facepalm","happy","high+five","kiss","lol","no","sad","shrug","thumbs+up","wink","yes",
"bill+nye","biology","bubbles","computer","magnets","mathematics","nasa","robot","space",
"baseball","basketball","gymnastics","mma","nfl","skateboarding","snowboarding","surfing","wrestling",
"animatedtext+stickers","birthday+stickers","cat+stickers","cheeseburger+stickers","dinosaur+stickers","emoji+stickers","excited+stickers",
"happy+stickers","high+five+stickers","love+stickers","party+stickers","weird+stickers",
"audi","bmw","ferrari","lamborghini","motorcycle","nissan","porsche","subway","tank","arrested+development","game+of+thrones",
"infomercial","mad+men","new+girl","parks+and+recreation","sherlock","twin+peaks","workaholics"]

categories.each do |category|
  begin
    query_url = "#{base_url}&q=#{category}&limit=1000"
    response = RestClient.get("#{query_url}&offset=#{offset * limit}")
    parser = Yajl::Parser.new
    response_parsed = parser.parse(response)
    data = response_parsed['data']
    total = response_parsed['total']
    iterations = (total / 1000).to_i
    iterations.each do |i|
      if !data.empty?
        data.each do |gif|
          base_attributes = {
            id: gif['id'],
            source: gif['images']['original']['url']
          }
          tag_attributes = { tags: [category] }
          Gif.where(base_attributes).first_or_create(tag_attributes)
        end
      end
      offset = i * limit
      response = RestClient.get("#{query_url}&offset=#{offset * limit}")
      response_parsed = parser.parse(response)
      data = response_parsed['data']
    end

  rescue Exception => e
    logger.error e
    puts "ERROR: #{e}"
  end
end
