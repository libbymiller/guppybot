require 'cinch'
require 'open-uri'
require 'pp'

myname = "botname"

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = myname
    c.password = "password"
    c.server = "irc.server.org"
    c.channels = ["#somechannel"]
  end

  on :message, /^hello/ do |m|
    if(m.message.match(bot.nick))
      m.reply "Hello, #{m.user.nick}. I'm a bot.\nAsk me '#{myname}, anyone in?'"
    end
  end

  on :message, /^help/ do |m|
    m.reply "Hello, #{m.user.nick}. I'm a bot.\nAsk me '#{myname}, anyone in?'"
  end

  on :message, /^about/ do |m|
    if(m.message.match(bot.nick))
      m.reply "Hello, #{m.user.nick}. I'm a bot, named for https://en.wikipedia.org/wiki/Sarah_Guppy'"
    end
  end

  helpers do
    def anyonein()
      res = "No results found"
      url = "http://bristol.hackspace.org.uk/anyonein/"
      open(url) {|f|
        f.each_line {|line|
          if(re = line.match(/Someone moved (.*)</))
            res = "Someone moved in the space #{re[1]}"
          end
          if(re = line.match(/Someone is moving</))
            res = "Someone moved in the space just now"
          end
        }
      }
    rescue
      "#{res} - see http://bristol.hackspace.org.uk/wiki/doku.php?id=how_to_get_into_the_physical_hackspace"
    else
      "#{res} - see http://bristol.hackspace.org.uk/wiki/doku.php?id=how_to_get_into_the_physical_hackspace"
    end

    def known(nick)
      isknown = false
      file_name = "./users.txt"
      f = File.read(file_name)
      arr = f.split("\n")
      arr.each do |line|
         puts line
         puts nick
         if(nick == line)
           isknown = true
           break
         else
         end
      end
      if(!isknown)
           open(file_name, 'a') { |f|
             f.puts nick
           }
      end
    rescue
      isknown
    else
      isknown
    end
  end

  on :message, /.*?anyone in\??/ do |m|
    m.reply anyonein()    
  end

  on :join do |m|
    unless m.user.nick == bot.nick # don't repl to ourselves
     if(!known(m.user.nick))
       m.reply "hi, #{m.user.nick} - welcome to the hackspace irc channel. We are actually here, we just aren't listening all the time, so please ask a question and in a few minutes someone will point you in the right direction. Or you can ask, 'anyone in?'"
     end
    end
  end

end


bot.start
