using System;
using Gtk;
using System.IO;

public class MainWindow: Gtk.Window
{	
	
	Entry entry1 = new Entry();
	Entry entry2 = new Entry();
	Entry entry3 = new Entry();
	Entry entry4 = new Entry();
	Entry entry5 = new Entry();
	Entry entry6 = new Entry();
	Button checkbutton1 = new Button();
	Button checkbutton2 = new Button();
	public MainWindow (): base ("")
	{
		Stetic.Gui.Build (this, typeof(MainWindow));
		//System.IO.Directory.Delete ("/tmp/ndstation-tmp");
		System.IO.Directory.CreateDirectory ("/tmp/ndstation-tmp");
        System.IO.File.Delete ("/tmp/ndstation-tmp/lock");
	}
	
	protected void OnDeleteEvent (object sender, DeleteEventArgs a)
	{
	
		StreamWriter swlock = new StreamWriter("/tmp/ndstation-tmp/lock");
        swlock.Write("1");
        swlock.Close();
		Application.Quit ();
		a.RetVal = true;
	}

	

	protected virtual void OnButton10Clicked(object sender, System.EventArgs e)
	{
	// Create and display a fileChooserDialog
     FileChooserDialog chooser = new FileChooserDialog(
        "Please select a GBA file to open ...",
        this,
        FileChooserAction.Open,
        "Cancel", ResponseType.Cancel,
        "Open", ResponseType.Accept );
        FileFilter ff1 = new FileFilter();
		ff1.AddPattern ("*.gba");
		ff1.Name = "GBA File (*.gba)";
		chooser.AddFilter (ff1);
        if( chooser.Run() == ( int )ResponseType.Accept )
     	 {
     	 entry2.Text = chooser.Filename;
     	 }
     	 chooser.Destroy();

	}

	protected virtual void OnButton1Clicked(object sender, System.EventArgs e) //When Ok is clicked
	{
	    //StreamWriter sw = new StreamWriter(chooser.Filename);
     	StreamWriter swgba = new StreamWriter("/tmp/ndstation-tmp/gba");
        swgba.Write(entry2.Text);
        swgba.Close();
        
     	StreamWriter swnds = new StreamWriter("/tmp/ndstation-tmp/nds");
        swnds.Write(entry1.Text);
        swnds.Close();
        
        StreamWriter swt1 = new StreamWriter("/tmp/ndstation-tmp/t1");
        swt1.Write(entry3.Text);
        swt1.Close();
        
        StreamWriter swt2 = new StreamWriter("/tmp/ndstation-tmp/t2");
        swt2.Write(entry4.Text);
        swt2.Close();
        
        StreamWriter swt3 = new StreamWriter("/tmp/ndstation-tmp/t3");
        swt3.Write(entry5.Text);
        swt3.Close();
        
        StreamWriter swb1 = new StreamWriter("/tmp/ndstation-tmp/b1");
        swb1.Write(checkbutton1.State);
        swb1.Close();
        
        StreamWriter swb2 = new StreamWriter("/tmp/ndstation-tmp/b2");
        swb2.Write(checkbutton2.State);
        swb2.Close();
        
        StreamWriter swicon = new StreamWriter("/tmp/ndstation-tmp/icon");
        swicon.Write(entry6.Text);
        swicon.Close();
//System.IO.Directory.Delete;

 
	Application.Quit();
	}

	protected virtual void OnButton3Clicked(object sender, System.EventArgs e)
	{
	// Create and display a fileChooserDialog
	
     FileChooserDialog chooser1 = new FileChooserDialog(
        "Please select a file to save to ...",
        this,
        FileChooserAction.Save,
        "Cancel", ResponseType.Cancel,
        "Save", ResponseType.Accept );
        FileFilter ff1 = new FileFilter();
		ff1.AddPattern ("*.nds");
		ff1.Name = "NDS File (*.nds)";
		chooser1.AddFilter (ff1);
        if( chooser1.Run() == ( int )ResponseType.Accept )
     	 {
     	 if( chooser1.Filename.EndsWith (".nds") == true )
     	 	{
     	 	entry1.Text = chooser1.Filename;
     	 	}
     	 else 
     	 	{
     	 	entry1.Text = chooser1.Filename + ".nds";
     	 	}
     	 }
     	 chooser1.Destroy();
     	 
	}

	protected virtual void OnButton12Clicked(object sender, System.EventArgs e)
	{
	FileChooserDialog chooser = new FileChooserDialog(
        "Please select an Icon file (32x32 16 colors, palletable) to open ...",
        this,
        FileChooserAction.Open,
        "Cancel", ResponseType.Cancel,
        "Open", ResponseType.Accept );
        FileFilter ff1 = new FileFilter();
		ff1.AddPattern ("*.bmp");
		ff1.Name = "BMP File (*.bmp)";
		chooser.AddFilter (ff1);
        if( chooser.Run() == ( int )ResponseType.Accept )
     	 {
     	 entry6.Text = chooser.Filename;
     	 }
     	 chooser.Destroy();
	}

}