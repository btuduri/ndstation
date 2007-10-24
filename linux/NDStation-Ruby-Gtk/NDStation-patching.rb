#!/usr/bin/env ruby
#NDStation-patching handles individual file patching in NDStation

require 'open-uri'

#downloads files from the internet
def download(file_name, webloc)
  open(file_name, "w").write(open(webloc).read) {|file_name| puts "Downloading #{file_name}"}
end

def check
  unless File.exist?("ndstool") and File.exist?("9.bin") and File.exist?("7.bin") #test for file existance(duh :P)
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
    exec_path =  Dir.entries("/usr/bin")  #checks for 7z, unrar and uzip executables in /usr/bin
    unless exec_path.include?("7z") and exec_path.include?("unrar") and exec_path.include?("unzip")
      puts "please make sure you have 7z, unrar and unzip installed"
      exit
    end
  end
end

class Rom
  attr_accessor :file_name, :path, :icon, :title
  def initialize(file_name, path, icon, title)
    @file_name = file_name
    @path = path
    @icon = icon
    @title = title
  end
  def patch
    print "Do you really want to patch this file[y/N]? "
    ans = gets.to_s.chomp!
    if ans == "y"
      `./ndstool -c #@file_name -7 7.bin -9 9.bin -d #@path -g NDST -b #@icon #@title` #the arguments might be wrong
    else
      puts "Exiting"
    end
  end 
  def extract                       #split filename to string and extension, compares extension
    reg = file_name.split('.', 2)   #and executes command to extract file.
    unless reg[1] == "gba"
      case
      when reg.include?('rar')
        %x(unrar x #@filename)
      when reg.include?('zip')
        %x(unzip #@filename)
      when reg.include?('tar.gz')
        %x(tar -xf #@filename)
      when reg.include?('tar.bz2')
        %x(tar -xf #@filename)
      when reg.include?('7z')
        %x(7z e #@filename)
      end
      rom.file_name = reg[0] + ".gba"
    end
  end
end

if __FILE__ == $0 #irb
  check
  #rom = Rom.new("file_name", "path", "icon.png", "title").extract.patch
end
