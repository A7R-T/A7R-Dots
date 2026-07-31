// modules/ControlCenter.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import "../theme"

PanelWindow {
    id: controlCenterWindow
    property bool isOpen: false

    visible: isOpen
    color: "transparent"

    // Wayland layer positioning
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "a7r-control-center"

    anchors {
        top: true
        bottom: true
        left: true
    }
    
    // Position slightly below top bar
    margins.top: 17
    margins.left: 17

    width: 470

    // Main Flyout Card Background
    Rectangle {
        id: cont
        anchors.fill: parent
        color: "transparent"
        border.color: Theme.accent
        border.width: 1
        radius: 17
        Rectangle {
          anchors.fill: parent
          radius: 17
          color: "#121F2A"
          opacity: 0.37
        }

        ColumnLayout {
            id: mainColumn
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 17
            spacing: 17

            // ----------------------------------------------------
            // 1. HEADER & POWER ACTIONS
            // ----------------------------------------------------
            ColumnLayout {
                Layout.topMargin: 37

                Text {
                    text: "A7R Control Center"
                    color: Theme.accent
                    font.pixelSize: 17
                    font.bold: true
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                // Power Action Buttons
                Row {
                    anchors.centerIn: parent
                    Layout.topMargin: 37
                    spacing: 7

                    // Sleep
                    Rectangle {
                        width: 73; height: 73; radius: 7
                        color: sleepMouse.containsMouse ? Theme.surface : "transparent"
                        Text { text: "󱋑"; anchors.centerIn: parent; font.pixelSize: 37; color: Theme.accent}
                        MouseArea {
                            id: sleepMouse; anchors.fill: parent; hoverEnabled: true
                            onClicked: execProc.exec(["systemctl","suspend"])
                        }
                    }

                    // Lock
                    Rectangle {
                        width: 73; height: 73; radius: 7
                        color: lockMouse.containsMouse ? Theme.surface : "transparent"
                        Text { text: ""; anchors.centerIn: parent; font.pixelSize: 37; color: Theme.accent}
                        MouseArea {
                            id: lockMouse; anchors.fill: parent; hoverEnabled: true
                            onClicked: execProc.exec(["hyprlock"])
                        }
                    }

                    // Logout
                    Rectangle {
                        width: 73; height: 73; radius: 7
                        color: logoutMouse.containsMouse ? Theme.surface : "transparent"
                        Text { text: "󰍃"; anchors.centerIn: parent; font.pixelSize: 37; color: Theme.text }
                        MouseArea {
                            id: logoutMouse; anchors.fill: parent; hoverEnabled: true
                            onClicked: execProc.exec(["hyprctl", "dispatch", "exit"])
                        }
                    }

                    // Reboot
                    Rectangle {
                        width: 73; height: 73; radius: 7
                        color: rebootMouse.containsMouse ? Theme.surface : "transparent"
                        Text { text: "󰜉"; anchors.centerIn: parent; font.pixelSize: 37; color: Theme.text }
                        MouseArea {
                            id: rebootMouse; anchors.fill: parent; hoverEnabled: true
                            onClicked: execProc.exec(["systemctl", "reboot"])
                        }
                    }

                    // Power Off
                    Rectangle {
                        width: 73; height: 73; radius: 7
                        color: powerMouse.containsMouse ? Theme.surface : "transparent"
                        Text { text: "󰐥"; anchors.centerIn: parent; font.pixelSize: 37; color: "#E06C75" }
                        MouseArea {
                            id: powerMouse; anchors.fill: parent; hoverEnabled: true
                            onClicked: execProc.exec(["systemctl", "poweroff"])
                        }
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.surface }

            // ----------------------------------------------------
            // 2. AUDIO / VOLUME CONTROLLER
            // ----------------------------------------------------

            PwObjectTracker {
                objects: [ Pipewire.defaultAudioSink ]
            }

            ColumnLayout {
                spacing: 17


                RowLayout {

                    Text { 
                        text: "󰕾 Volume"; 
                        color: Theme.text; 
                        font.pixelSize: 13; 
                        font.bold: true; 
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Item { Layout.fillWidth: true }

                    Text { 
                        text: Math.round(volSlider.value) + "%"; 
                        color: Theme.accent; 
                        font.pixelSize: 13; 
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                // Volume Slider Control
                Rectangle {
                    id: sliderTrack
                    Layout.fillWidth: true
                    height: 17
                    radius: 7
                    color: Theme.surface

                    Rectangle {
                        height: parent.height
                        width: parent.width * (volSlider.value / 150)
                        color: Theme.accent
                        radius: 5
                    }

                    Item {
                        id: volSlider
                        
                        // Bind Pipewire volume directly (0.0 to 1.5 mapped to 0 to 150%)
                        property real value: (Pipewire.defaultAudioSink?.audio?.volume ?? 0.5) * 100
                        anchors.fill: parent

                        MouseArea {
                            anchors.fill: parent
                            onPositionChanged: mouse => updateVol(mouse.x)
                            onPressed: mouse => updateVol(mouse.x)

                            function updateVol(posX) {
                                // Calculate percentage (0 to 150)
                                let pct = Math.max(0, Math.min(150, (posX / parent.width) * 150))
                                
                                // Set Pipewire volume directly (convert 0-150% back to 0.0 - 1.5 scale)
                                if (Pipewire.defaultAudioSink?.audio) {
                                    Pipewire.defaultAudioSink.audio.volume = pct / 100
                                }
                            }
                        }
                    }
                }
            }


            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.surface }

            // ----------------------------------------------------
            // 3. MPRIS MEDIA PLAYER CARD
            // ----------------------------------------------------
                ColumnLayout {
                  Mplay{}
                }
            Rectangle { Layout.fillWidth: true; height: 1; color: Theme.surface }
        }
    }

    // Process Runner for System & Volume Execution
    Process {
        id: execProc
        function exec(cmd) {
            command = cmd
            running = true
        }
    }
}
