#!/usr/bin/env python

import gtk
import gtk.glade
import os
import shutil

home = os.path.expanduser("~")

class ndstation():

	def __init__(self):

		xml = gtk.glade.XML('ndstation.glade')
		line1title = xml.get_widget('line1title')
		line2title = xml.get_widget('line2title')
		line3title = xml.get_widget('line3title')
		gbafilebox = xml.get_widget('gbafilebox')
		outfilebox = xml.get_widget('outfilebox')
		button2 = xml.get_widget('button2')
		button3 = xml.get_widget('button3')
		button4 = xml.get_widget('button4')
		button11 = xml.get_widget('button11')
		filechooserbutton3 = xml.get_widget('filechooserbutton3')
		filechooserbutton4 = xml.get_widget('filechooserbutton4')
		entry6 = xml.get_widget('entry6')
#		filechooserdialog1 = xml.get_widget('filechooserdialog1')
#		filechooserdialog2 = xml.get_widget('filechooserdialog2')

		filechooserdialog1 = gtk.FileChooserDialog("Open..", None, gtk.FILE_CHOOSER_ACTION_OPEN, (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL, gtk.STOCK_OPEN, gtk.RESPONSE_OK))
		filechooserdialog1.set_default_response(gtk.RESPONSE_OK)
		filter_gba = gtk.FileFilter()
		filter_gba.set_name("GBA Roms (*.gba)")
		filter_gba.add_pattern("*.gba")
		filechooserdialog1.add_filter(filter_gba)

		filechooserdialog2 = gtk.FileChooserDialog("Open..", None, gtk.FILE_CHOOSER_ACTION_SAVE, (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL, gtk.STOCK_OPEN, gtk.RESPONSE_OK))
		filechooserdialog2.set_default_response(gtk.RESPONSE_OK)
		filter_nds = gtk.FileFilter()
		filter_nds.set_name("NDS File (*.nds)")
		filter_nds.add_pattern("*.nds")
		filechooserdialog2.add_filter(filter_nds)
		
		def filechoose(*args):

			response = filechooserdialog1.run()

			if response == gtk.RESPONSE_OK:
				infile = "'"+filechooserdialog1.get_filename()+"'"
				#infilesimple = filechooserdialog1.get_filename()
				print filechooserdialog1.get_filename(), 'selected'
				gbafilebox.set_text(infile)
			elif response == gtk.RESPONSE_CANCEL:
				print 'Closed, no files selected'
			filechooserdialog1.hide()
		infilesimple = filechooserdialog1.get_filename()
		def filesave(*args):
			infile = filechooserdialog1.get_filename()
			infilename = os.path.basename(infile)
			infilepath = os.path.dirname(infile)

			
			print infile
			filechooserdialog2.set_current_name(infilename+".nds")
			filechooserdialog2.set_filename(infilepath+"/nonexistantfilenumber9443065")
			response = filechooserdialog2.run()

			if response == gtk.RESPONSE_OK:
				outfile = "'"+filechooserdialog2.get_filename()+"'"
				fileext = os.path.splitext( outfile )
				if fileext[1] != ".nds'":
					outfile = "'"+filechooserdialog2.get_filename()+".nds'"

				print outfile, 'selected'
				outfilebox.set_text(outfile)
			elif response == gtk.RESPONSE_CANCEL:
				print 'Closed, no files selected'
			filechooserdialog2.hide()

		def gbaopen (*args):
			gbarom = filechooserdialog1.get_filename()
			gbafile.set_text(gbarom)
			filechooserdialog1.hide()

		def gbaout (*args):
			outfile = filechooserdialog2.get_filename()
			outfile.set_text(outfile)
			filechooserdialog2.hide()

		def closechooser1 (*args):
			filechooserdialog1.hide()

		def closechooser2 (*args):
			filechooserdialog2.hide()

#		button4.connect("clicked", gbaopen)
		button11.connect("clicked", gbaout)


		mainWindow = xml.get_widget('mainWindow')
		buttonGo = xml.get_widget('button1')
		mainWindow.connect("destroy", gtk.main_quit)
		filechooserdialog1.connect("destroy", closechooser1)
		filechooserdialog2.connect("destroy", closechooser2)
		button2.connect("clicked", filechoose)
		button3.connect("clicked", filesave)


		def convert():
			os.chdir(home+"/test")
			os.system('echo "P" > data/mode.txt')
			os.system('./ndstool -c', outfile(), '-7 7.bin -9 9.bin -d data -g "NDST" -b', icon(), title())

		def on_button_clicked(*args):
			title1 = line1title.get_text()
			title2 = line2title.get_text()
			title3 = line3title.get_text()
			title = "'"+title1+";"+title2+";"+title3+"'"
			gbarom = gbafilebox.get_text()
			outfile = outfilebox.get_text()
			icon = entry6.get_text()
			if icon == '':
				icon = "icon.bmp"
			print title1, "\n", title2, "\n", title3, "\n", "'"+gbarom+"'\n", "'"+outfile+"'\n", "icon:", icon
			#convert()
			os.chdir(home+"/test")
			os.system("cp "+gbarom+" "+home+"/test/data/game.gba")
			os.system('echo "P" > data/mode.txt')
			ndstoolargs = " -c "+outfile+" -7 7.bin -9 9.bin -d data -g "'"NDST"'" -b "+icon+" "+title
			os.system("./ndstool" + ndstoolargs)
			os.system("./efs "+outfile)

		buttonGo.connect("clicked", on_button_clicked)
		mainWindow.show_all()




if __name__ == "__main__":
	ndstation()
	gtk.main()

