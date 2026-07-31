import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import "../theme"

PanelWindow {
    id: osdWindow

    // LayerShell config to float above standard windows
    WlrLayershell.layer: WlrLayer.Overlay
    anchors {
      top: true
    }
    margins {
      top: 37
    }

    // Match shell dimensions
    width: 373
    height: 45
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    // State tracking
    property string activeIcon: "󰕾"
    property real activeValue: 0
    property bool isVisible: false

    // Sync with Pipewire for Volume
    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    // Auto-hide Timer
    Timer {
        id: hideTimer
        interval: 1700 // 1.8 seconds visibility
        onTriggered: osdWindow.isVisible = false
    }

    function triggerOSD(icon, val) {
        osdWindow.activeIcon = icon
        osdWindow.activeValue = Math.min(100, Math.max(0, val))
        osdWindow.isVisible = true
        hideTimer.restart()
    }

    // React to Pipewire Volume changes automatically
    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            let vol = Math.round((Pipewire.defaultAudioSink.audio.volume ?? 0) * 100)
            osdWindow.triggerOSD("󰕾", vol)
        }
    }

    // Visual Card
    Rectangle {
        anchors.top: parent.top
        anchors.fill: parent
        radius: 17
        color: Theme.bg
        border.color: Theme.accent
        border.width: 1
        opacity: osdWindow.isVisible ? 0.73 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 7

            Text {
                text: osdWindow.activeIcon
                color: Theme.accent
                font.pixelSize: 17
                Layout.alignment: Qt.AlignVCenter
            }

            // Progress Bar Track
            Rectangle {
                Layout.fillWidth: true
                height: 6
                radius: 3
                color: Qt.rgba(1, 1, 1, 0.1)

                // Fill Indicator
                Rectangle {
                    width: parent.width * (osdWindow.activeValue / 100)
                    height: parent.height
                    radius: parent.radius
                    color: Theme.accent
                }
            }

            Text {
                text: `${Math.round(osdWindow.activeValue)}%`
                color: Theme.accent
                font.pixelSize: 13
                font.bold: true
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}
