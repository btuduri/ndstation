// project created on 8/20/2007 at 5:07 PM
using System;
using Gtk;

namespace NDStation
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Application.Init ();
			MainWindow win = new MainWindow ();
			win.Show ();
			Application.Run ();
		}
	}
}