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
      puts isknown
end


known("libby")
