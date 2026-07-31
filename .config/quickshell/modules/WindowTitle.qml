// modules/WindowTitle.qml
import QtQuick
import Quickshell.Hyprland
import "../theme"

Text {
    id: windowTitleText
    width: Math.min(implicitWidth, 170)
    clip: true

    // Helper property to resolve window title cleanly
    readonly property string currentTitle: {
        if (!Hyprland.activeToplevel) return "Desktop"
        
        let title = Hyprland.activeToplevel.title
        if (title && title.length > 0) return title

        let classTitle = Hyprland.focusedWindow.initialTitle
        if (classTitle && classTitle.length > 0) return classTitle

        return "Desktop"
    }

    text: currentTitle
    color: Theme.accent
    font.pixelSize: 13
    font.bold: false
    elide: Text.ElideRight
    maximumLineCount: 1
    horizontalAlignment: Text.AlignHCenter

    // Smooth subtle fade animation when changing active windows
    Behavior on text {
        SequentialAnimation {
            NumberAnimation { target: windowTitleText; property: "opacity"; to: 0.2; duration: 80 }
            PropertyAction { target: windowTitleText; property: "text" }
            NumberAnimation { target: windowTitleText; property: "opacity"; to: 1.0; duration: 120 }
        }
    }
}
