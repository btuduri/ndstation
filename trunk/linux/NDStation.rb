#!/usr/bin/env ruby
require 'gtk2'

def hbox(homogenous, spacing)
 Gtk::HBox.new(homogenous, spacing)
end 

def vbox(homogenous, spacing)
 Gtk::VBox.new(homogenous, spacing)
end

def button(title)
 Gtk::Button.new(title)
end

def label(title)
 Gtk::Label.new(title)
end

Gtk.init

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.set_size_request(500, 600)
window.set_title($0)
window.set_border_width(15)
window.allow_grow=(false)
window.signal_connect("delete_event") {Gtk.main_quit}
window.signal_connect("destroy") {Gtk.main_quit}

vboxmain = vbox(false, 0)

hbox1 = hbox(false, 10)
hbox2 = hbox(false, 0)
hbox3 = hbox(false, 0)
hbox4 = hbox(false, 0)
hbox5 = hbox(false, 0)
hbox6 = hbox(false, 0)
hbox7 = hbox(false, 0)
hbox8 = hbox(false, 0)
hbox9 = hbox(false, 0)
hbox10 = hbox(false, 0)
hbox11 = hbox(false, 0)
hbox12 = hbox(false, 0)
hbox13 = hbox(false, 0)
hbox14 = hbox(false, 0)
hbox15 = hbox(false, 0)


vboxmain.pack_start(hbox1, false, false, 10)
vboxmain.pack_start(hbox2, false, false, 0)
vboxmain.pack_start(hbox3, false, false, 25)
vboxmain.pack_start(hbox4, false, false, 0)
vboxmain.pack_start(hbox5, false, true, 15)
vboxmain.pack_start(hbox6, false, true, 0)
vboxmain.pack_start(hbox7, false, false, 10)
vboxmain.pack_start(hbox8, false, false, 0)
vboxmain.pack_start(hbox9, false, false, 0)
vboxmain.pack_start(hbox10, false, false, 0)
vboxmain.pack_start(hbox11, false, false, 0)
vboxmain.pack_start(hbox12, false, false, 0)
vboxmain.pack_start(hbox13, false, false, 0)
vboxmain.pack_start(hbox14, false, false, 10)
vboxmain.pack_start(hbox15, false, false, 0)

#1st block
label1 = label("GBA Rom File:")
hbox1.pack_start(label1, false, false, 0)

label2 = label("Output Folder:")
hbox2.pack_start(label2, false, false, 0)

txt1 = Gtk::Entry.new
hbox1.pack_start(txt1, true, true, 8)

txt2 = Gtk::Entry.new
hbox2.pack_start(txt2, true, true, 14)

file1 = Gtk::FileChooserButton.new("Browse", Gtk::FileChooser::ACTION_OPEN)
file1.current_folder = ENV['HOME']
hbox1.pack_start(file1, false, false, 24)

file2 = Gtk::FileChooserButton.new("Browse", Gtk::FileChooser::ACTION_SELECT_FOLDER)
file2.current_folder = ENV['HOME']
hbox2.pack_start(file2, false, false, 0)

#Separator begins
#second block
hbox3.pack_start(Gtk::HSeparator.new, true, true, 10)

label3 = label("Game Title:")
hbox4.pack_start(label3, false, false, 0)

txt3 = Gtk::Entry.new
hbox4.pack_start(txt3, true, true, 28)

chkbutton1 = Gtk::CheckButton.new("Use PSRAM")
chkbutton2 = Gtk::CheckButton.new("Use Compression")
hbox5.pack_start(chkbutton1, true, false, 0)
hbox5.pack_start(chkbutton2, true, false, 0)

#Separator begins
hbox6.pack_start(Gtk::HSeparator.new, true, true, 10)

label4 = Gtk::Label.new
label4.set_markup("<i><small>Leave text boxes blank for default picture</small></i>")
hbox7.pack_start(label4, false, false, 0)

label5 = label("Icon:")
hbox8.pack_start(label5, false, false, 0)

txt4 = Gtk::Entry.new
hbox8.pack_start(txt4, true, true, 10)

file3 = Gtk::FileChooserButton.new("Browse", Gtk::FileChooser::ACTION_OPEN)
file3.current_folder = ENV['HOME']
hbox8.pack_start(file3, false, false, 0)

label6 = Gtk::Label.new
label6.set_markup("<i><small>NDS File - 32x32, 4 bit colour</small></i>")
hbox9.pack_start(label6, true, false, 0)


label7 = label("Border:")
hbox10.pack_start(label7, false, false, 0)

txt5 = Gtk::Entry.new
hbox10.pack_start(txt5, true, true, 10)

file4 = Gtk::FileChooserButton.new("Browse", Gtk::FileChooser::ACTION_OPEN)
file4.current_folder = ENV['HOME']
hbox10.pack_start(file4, false, false, 0)

label8 = Gtk::Label.new
label8.set_markup("<i><small>GBA Game Border - 256x192</small></i>")
hbox11.pack_start(label8, true, false, 0)


label9 = label("Splash:")
hbox12.pack_start(label9, false, false, 0)

txt6 = Gtk::Entry.new
hbox12.pack_start(txt6, true, true, 10)

file5 = Gtk::FileChooserButton.new("Browse", Gtk::FileChooser::ACTION_OPEN)
file5.current_folder = ENV['HOME']
hbox12.pack_start(file5, false, false, 0)

label10 = Gtk::Label.new
label10.set_markup("<i><small>Splash Screen - 256x192</small></i>")
hbox13.pack_start(label10, true, false, 0)

#separator
hbox14.pack_start(Gtk::HSeparator.new, true, true, 0)

window.add(vboxmain)
window.show_all
Gtk.main