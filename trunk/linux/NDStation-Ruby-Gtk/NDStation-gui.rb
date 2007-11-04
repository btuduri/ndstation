#!/usr/bin/env ruby
#NDStaton-RC1
#Azimuth, dg10050

require 'gtk2'

class NDSTWindow < Gtk::Window
  
  def patch

=begin
    if @compression.active? and @rom_title_1.text == "gbatemp"
      @gba_file_entry.text = @output_folder_entry.text = @rom_title_1.text = @rom_title_2.text =\
      @rom_title_3.text = @icon_entry.text = @splash_entry.text=\
      @border_entry.text = "does it work on pal???"
    elsif @compression.active? and @rom_title_1.text == "about"
      @gba_file_entry.text = "NDStation, ezflash 3-in-1 patcher"
      @rom_title_1.text = "Greetings:"
      @rom_title_2.text = "dg10050, code/idea contributor, tester"
      @rom_title_3.text = "chuckstudios, author of NDStation"
    else
=end

    #system calls external command, if it exits > 0, system returns false
    if #{@gba_file_entry.text.size} < 16000000
        rom_title = "#{@rom_title_1.text};#{@rom_title_2.text};#{@rom_title_3.text}"
      if system("./ndstool -c file.nds -7 7.bin -9 9.bin -d data -g 'NDST' -b #{@icon_entry.text} #{rom_title}") and system("./efs file.nds")
        Dialog.new("Patching complete", "Patching is Complete")
      else
        Dialog.new("Patching Failed", "Failed to Patch File")
      end
    else
    end
    #end
  end
  
  def initialize
    super("NDStation-RC1")
    signal_connect("destroy") { Gtk.main_quit}
    set_border_width(10)
    show_all
    set_icon(Gdk::Pixbuf.new('icon.png'))
    set_resizable(false)
    
    #text entries
    @gba_file_entry = Gtk::Entry.new
    @output_folder_entry = Gtk::Entry.new
    @output_folder_entry.text = "Not Implemented Yet" #Dir class
    @rom_title_1 = Gtk::Entry.new
    @rom_title_2 = Gtk::Entry.new
    @rom_title_3 = Gtk::Entry.new
    @icon_entry = Gtk::Entry.new
    @splash_entry = Gtk::Entry.new
    @splash_entry.text = "Not Implemented Yet" #figure this out
    @border_entry = Gtk::Entry.new
    @border_entry.text = "Not Implemented Yet" #figure this out
    
    #check buttons
    @use_psram = Gtk::CheckButton.new("Use PSRAM")
    @compression = Gtk::CheckButton.new("Compress")
    check_box = Gtk::HBox.new
    check_box.pack_start(@use_psram, true, false, 12).pack_start(@compression, true, false, 12)

    #filechooserbutton, extension filter(dg10050).
    @gba_file = Gtk::FileChooserButton.new("GBA File", Gtk::FileChooser::ACTION_OPEN)
    filter_gba = Gtk::FileFilter.new.set_name("*.gba").add_pattern("*gba")
    #@gba_file.add_filter(filter_gba)
    @gba_file.signal_connect("selection-changed") {@gba_file_entry.text=(@gba_file.filename)}
    
    @output_folder = Gtk::FileChooserButton.new("Ouput Folder",Gtk::FileChooser::ACTION_SELECT_FOLDER)
    @output_folder.signal_connect("selection-changed") {@output_folder_entry.text=(@output_folder.filename)}
    
    @icon_file = Gtk::FileChooserButton.new("Icon File", Gtk::FileChooser::ACTION_OPEN)
    filter_icon = Gtk::FileFilter.new.set_name("*.bmp").add_pattern("*bmp")
    @icon_file.add_filter(filter_icon)
    @icon_file.signal_connect("selection-changed") {@icon_entry.text=(@icon_file.filename)}
    
    @splash_file = Gtk::FileChooserButton.new("Splash File", Gtk::FileChooser::ACTION_OPEN)
    @splash_file.signal_connect("selection-changed") {@splash_entry.text=(@splash_file.filename)}
    
    @border_file = Gtk::FileChooserButton.new("Border File", Gtk::FileChooser::ACTION_OPEN)
    @border_file.signal_connect("selection-changed") {@border_entry.text=(@border_file.filename)}
    
    patch_button = Gtk::Button.new("Patch")
    patch_button.signal_connect("clicked") {patch}
    
    patch_hbox = Gtk::HBox.new
    patch_hbox.add(patch_button)
    
    top_table = Gtk::Table.new(2, 3)
    middle_table = Gtk::Table.new(3, 2)
    bottom_table = Gtk::Table.new(4, 3)
    
    #pack widgets into table
    top_table.attach(Gtk::Label.new("GBA File: "), 0, 1, 0, 1).attach(@gba_file_entry,1, 2, 0, 1).attach(@gba_file, 2, 3, 0, 1)
    top_table.attach(Gtk::Label.new("Output Folder: "), 0, 1, 1, 2).attach(@output_folder_entry, 1, 2, 1, 2).attach(@output_folder, 2, 3, 1, 2)
    
    middle_table.attach(Gtk::Label.new("Rom Title: "), 0, 1, 0, 1, Gtk::SHRINK, Gtk::SHRINK).attach(@rom_title_1, 1, 2, 0, 1)
    
    middle_table.attach(@rom_title_2, 1, 2, 1, 2)
    middle_table.attach(@rom_title_3, 1, 2, 2, 3)
    
    bottom_table.attach(Gtk::Label.new("Icon: "), 0, 1, 0, 1).attach(@icon_entry, 1, 2, 0, 1).attach(@icon_file, 2, 3, 0, 1)
    bottom_table.attach(Gtk::Label.new("Splash: "), 0, 1, 1, 2).attach(@splash_entry, 1, 2, 1, 2).attach(@splash_file, 2, 3, 1, 2)
    bottom_table.attach(Gtk::Label.new("Border: "), 0, 1, 2, 3).attach(@border_entry, 1, 2, 2, 3).attach(@border_file, 2, 3, 2, 3)
    
    #pack tables into main vbox, each table seperated by HSeparator
    vbox_main = Gtk::VBox.new
    vbox_main.add(top_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(middle_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(check_box).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(bottom_table).pack_start(Gtk::HSeparator.new, true, true, 12)\
    .add(patch_hbox)
    
    add(vbox_main)
    show_all
  end
end

#class dialog, invoked after patching
class Dialog < Gtk::Dialog
  def initialize(title, message)
    super(title)
    set_default_size(250, 1)
    add_button(Gtk::Stock::OK, Gtk::Dialog::RESPONSE_REJECT)
    signal_connect("response") {destroy}
    vbox.add(Gtk::Label.new(message))
    show_all
  end
end

Gtk.init
NDSTWindow.new
Gtk.main
