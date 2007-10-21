#!/usr/bin/env ruby
#NDStation-patching handles individual file patching in NDStation

require 'open-uri' #to grab files from the net

#downloads files from the internet
def download(file_name, webloc)
  puts "Downloading: #{file_name.capitalize}"
  open(file_name, "w").write(open(webloc).read)
end

unless File.exist?("ndstool") and File.exist?("9.bin") and File.exist?("7.bin") #test for file existence(duh)
  print "ndstool, 7.bin or 9.bin don't exist, grab them from the interent[y/N]? "
  answer = gets.to_s.chomp!
  if answer == "y"
    download("ndstool", "http://foobarbaz.com/ndstool")
    download("7.bin", "http://foobarbaz.com/7.bin")
    download("9.bin", "http://foobarbaz.com/9.bin")
  else
    puts "Exiting program"
    exit
  end
else
  puts "Files exist"
end

class Rom
  def initialize(file_name, path, icon, title)
    @file_name = file_name
    @path = path
    @icon = icon
    @title = title
  end
  
  def patch
    %x(./ndstool -c #@file_name -7 7.bin -9 9.bin -d #@path -g NDST -b #@icon #@title)
  end
end
