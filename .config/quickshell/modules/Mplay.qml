// modules/Mpris.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import "../theme"

Rectangle {
    width: 430
    height: 117
    color: Theme.bg
    radius: 17

    // Grab the first active/available MPRIS player
    property MprisPlayer player: Mpris.players.values[0] ?? null

    RowLayout {
        anchors.fill: parent
        anchors.margins: 17
        spacing: 17

        // Track Info and Controls
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 3

            Text {
                Layout.fillWidth: true
                text: player?.trackTitle ?? "No media playing"
                color: Theme.accent
                font.bold: true
                font.pixelSize: 14
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                Layout.fillWidth: true
                text: player?.trackArtist ?? "Unknown Artist"
                color: Theme.accent
                font.pixelSize: 12
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignHCenter
            }

            // Playback Buttons
            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                Layout.topMargin: 7

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 73
                    width: 37; height: 37; radius: 7
                    color: prev.containsMouse ? Theme.surface : "transparent"
                    Text { text: "󰒮"; anchors.centerIn: parent; font.pixelSize: 17; color: Theme.accent}
                    MouseArea {id: prev; anchors.fill: parent; hoverEnabled: true; onClicked: player.previous() }
                }
                // Play/Pause
                Rectangle {
                    anchors.centerIn: parent
                    width: 37; height: 37; radius: 7
                    color: pp.containsMouse ? Theme.surface : "transparent"
                    Text { text: player && player.isPlaying ? "󰏤" : "󰐊"; anchors.centerIn: parent; font.pixelSize: 17; color: Theme.accent}
                    MouseArea {id: pp; anchors.fill: parent; hoverEnabled: true; onClicked: player.togglePlaying()}
                }
                // Next
                Rectangle {
                    anchors.right: parent.right
                    anchors.rightMargin: 73
                    width: 37; height: 37; radius: 7
                    color: next.containsMouse ? Theme.surface : "transparent"
                    Text { text: "󰒭"; anchors.centerIn: parent; font.pixelSize: 17; color: Theme.accent}
                    MouseArea {id: next; anchors.fill: parent; hoverEnabled: true; onClicked: player.next() }
                }
            }
        }
    }
}

