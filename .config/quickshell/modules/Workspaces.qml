// modules/Workspaces.qml
import QtQuick
import Quickshell.Hyprland
import "../theme"

Row {
    spacing: 7

    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            required property var modelData

            property bool isFocused: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === modelData.id

            width: isFocused ? 37 : 17
            height: 17
            radius: 7
            border.color: Theme.accent
            border.width: 1
            color: isFocused ? Theme.accent : Theme.surface
            anchors.verticalCenter: parent.verticalCenter

            Behavior on width {
                NumberAnimation { duration: 137; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 137 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + parent.modelData.id)
            }
        }
    }
}
