require 'rest-client'
# WebMock.allow_net_connect!

namespace :import do
  desc "Go through categories and import missing gifs from Giphy"
  task giphy: :environment do
    base_url = "http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC"
    offset = 0
    limit = 1000
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
    # categories = ["crying"]

    categories.each do |category|
      query_url = "#{base_url}&q=#{category}&limit=#{limit}"
      response = RestClient.get(query_url)
      puts "Category response returned #{response.size}"
      response_parsed = Yajl::Parser.new.parse(response)
      # response_parsed = parser.parse(file)
      data = response_parsed['data']
      total = response_parsed['total']
      iterations = (total.to_i / 1000).to_i
      iterations = 1 if iterations == 0
      puts "Iterators #{iterations}"
      iterations.times do |i|
        begin
          if !data.empty?
            data.each do |gif|
              base_attributes = {
                id: gif['id'],
                source: gif['images']['original']['url'],
                tags: [category]
              }
              found = Gif.where(id: gif['id'])
              if found.empty?
                puts "Trying to create or first #{base_attributes.inspect}"
                Gif.create!(base_attributes)
              end
            end
          end
        rescue Exception => e
          puts "Data: #{e}"
        end
        begin
          offset = i * limit
          next_url = "#{query_url}&offset=#{offset}"
          puts "Url: #{next_url}"
          new_response = RestClient.get(next_url)
          break if new_response != nil
          parsed = Yajl::Parser.new.parse(new_response)
          puts "Parsed #{parsed.size}"
          data = parsed['data']
        rescue Exception => e
          puts "Getting New Response: #{e}"
        end
      end
    end
  end

  desc "TODO"
  task forgifs: :environment do
  end

end
