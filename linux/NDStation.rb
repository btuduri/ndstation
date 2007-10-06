#!/usr/bin/env ruby
#depends: ruby and ruby-gnome2
#This project is far from complete, the code below handles the gui only.

require 'gtk2'

Gtk.init

window = Gtk::Window.new
window.set_size_request(400,500)
window.signal_connect("destroy") { Gtk.main_quit}
window.border_width=(10)
 
vbox_main = Gtk::VBox.new

hbox1 = Gtk::HBox.new
table1 = Gtk::Table.new(2, 3)

gba_label = Gtk::Label.new("GBA Rom:")
gba_entry = Gtk::Entry.new
gba_file = Gtk::FileChooserButton.new("GBA File", Gtk::FileChooser::ACTION_OPEN)

output_label = Gtk::Label.new("Output Folder:")
output_entry = Gtk::Entry.new
output_file = Gtk::FileChooserButton.new("Output Folder", Gtk::FileChooser::ACTION_SELECT_FOLDER)

table1.attach(gba_label, 0, 1, 0, 1, Gtk::SHRINK, Gtk::SHRINK).attach(gba_entry, 1, 2, 0, 1, Gtk::SHRINK, Gtk::SHRINK).attach(gba_file, 2, 3, 0, 1, Gtk::SHRINK, Gtk::SHRINK)
table1.attach(output_label, 0, 1, 1, 2, Gtk::SHRINK, Gtk::SHRINK, 5, 0).attach(output_entry, 1, 2, 1, 2, Gtk::SHRINK, Gtk::SHRINK).attach(output_file, 2, 3, 1, 2, Gtk::SHRINK, Gtk::SHRINK, 5, 0)
    
hbox2 = Gtk::HBox.new

hbox3 = Gtk::HBox.new
rom_title_label = Gtk::Label.new("Rom Title:")
rom_title_entry1 = Gtk::Entry.new
rom_title_entry2 = Gtk::Entry.new
rom_title_entry3 = Gtk::Entry.new

table2 = Gtk::Table.new(4, 2)
table2.attach(rom_title_label, 0, 1, 0, 1, Gtk::SHRINK, Gtk::SHRINK).attach(rom_title_entry1, 1, 2, 0, 1).attach(rom_title_entry2, 1, 2, 1, 2).attach(rom_title_entry3, 1, 2, 2, 3)

use_psram = Gtk::CheckButton.new("Use PSRAM")
compress = Gtk::CheckButton.new("Compress")
table2.attach(use_psram, 0, 1, 3, 4, Gtk::SHRINK, Gtk::SHRINK).attach(compress, 1, 2, 3, 4, Gtk::SHRINK, Gtk::SHRINK)

hbox4 = Gtk::HBox.new

hbox5 = Gtk::HBox.new
table3 = Gtk::Table.new(3,3)
#
icon_label = Gtk::Label.new("Icon:")
icon_entry = Gtk::Entry.new 
icon_file = Gtk::FileChooserButton.new("Icon", Gtk::FileChooser::ACTION_OPEN)
#
splash_label = Gtk::Label.new("Splash:")
splash_entry = Gtk::Entry.new 
splash_file = Gtk::FileChooserButton.new("Splash", Gtk::FileChooser::ACTION_OPEN)
#
border_label = Gtk::Label.new("Border:")
border_entry = Gtk::Entry.new
border_file = Gtk::FileChooserButton.new("Border", Gtk::FileChooser::ACTION_OPEN)

table3.attach(icon_label, 0, 1, 0, 1).attach(icon_entry, 1, 2, 0, 1).attach(icon_file, 2, 3, 0, 1, Gtk::SHRINK, Gtk::SHRINK, 20, 0)
table3.attach(splash_label, 0, 1, 1, 2).attach(splash_entry, 1, 2, 1, 2).attach(splash_file, 2, 3, 1, 2, Gtk::SHRINK, Gtk::SHRINK, 20, 0)
table3.attach(border_label, 0, 1, 2, 3).attach(border_entry, 1, 2, 2, 3).attach(border_file, 2, 3, 2, 3, Gtk::SHRINK, Gtk::SHRINK, 20, 0)

hbox6 = Gtk::HBox.new

hbox1.pack_start(table1, true, true, 0)
hbox2.pack_start(Gtk::HSeparator.new, true, true, 0)
hbox3.pack_start(table2, true, true, 0)
hbox4.pack_start(Gtk::HSeparator.new, true, true, 0)
hbox5.pack_start(table3, true, true, 0)
hbox6.pack_start(Gtk::HSeparator.new, true, true, 0)

vbox_main.pack_start(hbox1, false, false, 0).pack_start(hbox2, false, false, 10).pack_start(hbox3, false, false, 0).pack_start(hbox4, false, false, 10).pack_start(hbox5, false, false, 0).pack_start(hbox6, false, false, 10)
window.add(vbox_main)
window.show_all
Gtk.main
