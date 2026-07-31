// shell.qml
import QtQuick
import Quickshell
import Quickshell.Io
import "modules"

ShellRoot {
    Scope {

        Bar {
            id: mainBar
            screenTarget: Quickshell.screens[0]
            onToggleControlCenter: controlCenter.isOpen = !controlCenter.isOpen
        }

        ControlCenter {
          id: controlCenter
        }

        Launcher {
        id: globalLauncher
        }

    // Listening for IPC signals to toggle
        IpcHandler {
            target: "launcher"
            function toggle() {
            globalLauncher.isOpen = !globalLauncher.isOpen
            }
        }
        OSD {
        id: osdOverlay
    }

    // IPC Endpoint to trigger Brightness manually from brightnessctl / keybinds
        IpcHandler {
            target: "osd"

            function brightness(value: string) {
                let parsed = Math.round(parseFloat(value))
                if (!isNaN(parsed)) {
                    osdOverlay.triggerOSD("󰃠", parsed)
                }
            }
        }
    }
}
