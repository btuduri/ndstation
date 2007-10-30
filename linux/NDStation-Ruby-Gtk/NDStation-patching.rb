#!/usr/bin/env ruby
#NDStation-patching handles individual file patching in NDStation

require 'open-uri'

#downloads files from the internet
def download(file_name, webloc)
  open(file_name, "w").write(open(webloc).read) {|file_name| puts "Downloading #{file_name}"}
end

def file_check
  unless File.exist?("ndstool") and File.exist?("9.bin") and File.exist?("7.bin") #test for file existance(duh :P)
    1
  end
end

def exec_check
  unless Dir.entries('/usr/bin').include?('7z') and Dir.entries('/usr/bin').include?('unrar') and Dir.entries('/usr/bin').include?('zip')
    1
  end
end

class Rom
  attr_accessor :file_name, :path, :icon, :title
  def initialize(file_name, path, icon, title)
    @file_name, @path, @icon, @title = file_name, path, icon, title
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
    reg = file_name.split('.')   #and executes command to extract file.
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
      when rar.include?('gba')
        puts "File is not compressed"
        patch
      else
        puts "File format unkown"
        exit
      end
    rom.file_name = reg[0] + ".gba"
  end
end
