// ------------------------------------------------------------------------------
//  <autogenerated>
//      This code was generated by a tool.
//      Mono Runtime Version: 2.0.50727.42
// 
//      Changes to this file may cause incorrect behavior and will be lost if 
//      the code is regenerated.
//  </autogenerated>
// ------------------------------------------------------------------------------

namespace Stetic {
    
    
    internal class Gui {
        
        private static bool initialized;
        
        public static void Build(object cobj, System.Type type) {
            Stetic.Gui.Build(cobj, type.FullName);
        }
        
        public static void Build(object cobj, string id) {
            Stetic.Gui.Initialize();
            if ((id == "MainWindow")) {
                Stetic.SteticGenerated.MainWindow.Build(((Gtk.Window)(cobj)));
            }
        }
        
        internal static void Initialize() {
            if ((Stetic.Gui.initialized == false)) {
                Stetic.Gui.initialized = true;
            }
        }
    }
    
    internal class ActionGroups {
        
        public static Gtk.ActionGroup GetActionGroup(System.Type type) {
            return Stetic.ActionGroups.GetActionGroup(type.FullName);
        }
        
        public static Gtk.ActionGroup GetActionGroup(string name) {
            return null;
        }
    }
}
