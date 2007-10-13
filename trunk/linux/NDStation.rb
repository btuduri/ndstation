#!/usr/bin/env ruby
require 'open-uri'

#check files existence
unless File.exist?("./ndstool") and File.exist?("./7.bin") and File.exist?("./9.bin")
  puts "Some files are teh missingz, grabbing them from internetz naw :)"
 
  open("ndstool","w").write(open("link.site.com/ndstool").read) #grab files from the internet
  
  else
  unless File.executable?("./ndstool") #check if ndstool is executable
    puts "ndstool is not executable, making it executable"
    %x(chmod +x ndstool)
    exit
  end
end

class Rom
  attr_accessor :file_name, :dir, :gcode, :icon, :title
  def initialize(file_name, dir, gcode, icon, title)
    @file_name = file_name
    @dir = dir
    @gcode = gcode
    @icon = icon
    @title = title
  end

  def patch
    %x(./ndstool -c #@file_name -7 7.bin -9 9.bin -d #@dir -g #@gcode -b #@icon #@title)
    unless $?.exitstatus == 0
      puts "Patching failed"
      else
      puts "Success!"
    end
  end
end

print "File: "
file_name = gets
print "Directory: "
dir = gets
print "Game Code(CAPS only): "
gcode = gets
print "Icon: "
icon = gets
print "Title(t1;t2;t3): "
title = gets

rom = Rom.new(file_name, dir, gcode, icon, title)
puts rom.patch
