#!/usr/bin/env ruby
$KCODE = 'U'
require 'gtk2'

class NDSTWindow < Gtk::Window
  
  def initialize
    super("NDStation")
    signal_connect("destroy") { Gtk.main_quit}
    set_default_size(400, 350)
    set_border_width(10)
    show_all
    set_resizable(false)
    
    def label(title)
      label = Gtk::Label.new(title)
    end
    
    @gba_file_entry = Gtk::Entry.new  
    @output_folder_entry = Gtk::Entry.new
    @rom_title_1 = Gtk::Entry.new
    @rom_title_2 = Gtk::Entry.new
    @rom_title_3 = Gtk::Entry.new
    @icon_entry = Gtk::Entry.new
    @splash_entry = Gtk::Entry.new
    @border_entry = Gtk::Entry.new

    @use_psram = Gtk::CheckButton.new("Use PSRAM")
    @compression = Gtk::CheckButton.new("Compress")
    
    @gba_file = Gtk::FileChooserButton.new("GBA File", Gtk::FileChooser::ACTION_OPEN)
    filter_gba = Gtk::FileFilter.new.set_name("Compatible").add_pattern("*gba")
    @gba_file.add_filter(filter_gba)

    @output_folder = Gtk::FileChooserButton.new("Ouput Folder",
                                                Gtk::FileChooser::ACTION_SELECT_FOLDER)
    
    @icon_file = Gtk::FileChooserButton.new("Icon File", Gtk::FileChooser::ACTION_OPEN)
    @splash_file = Gtk::FileChooserButton.new("Splash File", Gtk::FileChooser::ACTION_OPEN)
    @border_file = Gtk::FileChooserButton.new("Border File", Gtk::FileChooser::ACTION_OPEN)
    
    patch_button = Gtk::Button.new("Patch") { }
    patch_hbox = Gtk::HBox.new
    patch_hbox.add(patch_button)
    
    top_table = Gtk::Table.new(2, 3)
    middle_table = Gtk::Table.new(4, 2)
    bottom_table = Gtk::Table.new(4, 3)
    
    top_table.attach(label("GBA File: "), 0, 1, 0, 1).attach(@gba_file_entry,1, 2, 0, 1).attach(@gba_file, 2, 3, 0, 1)
    top_table.attach(label("Output Folder: "), 0, 1, 1, 2).attach(@output_folder_entry, 1, 2, 1, 2).attach(@output_folder, 2, 3, 1, 2)
    
    middle_table.attach(label("Rom Title: "), 0, 1, 0, 1, Gtk::SHRINK, Gtk::SHRINK)\
    .attach(@rom_title_1, 1, 2, 0, 1)
    
    middle_table.attach(@rom_title_2, 1, 2, 1, 2)
    middle_table.attach(@rom_title_3, 1, 2, 2, 3)
    middle_table.attach(@use_psram, 0, 1, 3, 4, Gtk::SHRINK, Gtk::SHRINK)\
    .attach(@compression, 1, 2, 3, 4, Gtk::SHRINK, Gtk::SHRINK)

    bottom_table.attach(label("Icon: "), 0, 1, 0, 1).attach(@icon_entry, 1, 2, 0, 1).attach(@icon_file, 2, 3, 0, 1)
    bottom_table.attach(label("Splash: "), 0, 1, 1, 2).attach(@splash_entry, 1, 2, 1, 2).attach(@splash_file, 2, 3, 1, 2)
    bottom_table.attach(label("Border: "), 0, 1, 2, 3).attach(@border_entry, 1, 2, 2, 3).attach(@border_file, 2, 3, 2, 3)

    vbox_main = Gtk::VBox.new
    vbox_main.add(top_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(middle_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(bottom_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(patch_hbox)
    
    add(vbox_main)
    show_all
  end
  
end

Gtk.init
NDSTWindow.new
Gtk.main
