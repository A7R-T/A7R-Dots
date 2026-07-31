// modules/Bar.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import "../theme"

PanelWindow {
    id: barWindow
    signal toggleControlCenter()
    
    required property var screenTarget
    screen: screenTarget

    anchors {
        top: true
        left: true
        right: true
    }
    height: 37
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "quickshell-bar"
    exclusiveZone: 25

    Item {
        anchors.fill: parent
        anchors.leftMargin: 25
        anchors.rightMargin: 25

        // Left section
        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 17

            Rectangle {
                width: 7
                height: 17
                color: Theme.accent
                radius: 3
                anchors.verticalCenter: parent.verticalCenter
                border.color: Theme.accent
                border.width: 3
            }

            Item {
                id: controlCenterButton
                width: 37
                height: 37
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    anchors.fill: parent
                    radius: 7
                    color: mouseArea.containsMouse ? Theme.surface : "transparent"
                }

                Image {
                    anchors.centerIn: parent
                    width: 30
                    height: 30
                    source: "../assets/A7R.png" // Relative path to your SVG/PNG
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        barWindow.toggleControlCenter()
                    }
                }
            }

            Clock {
                anchors.verticalCenter: parent.verticalCenter
            }
        }


        // Center section
        Row {
          anchors.centerIn: parent
          anchors.verticalCenter: parent.verticalCenter
          spacing: 17

          Rectangle {
              width: 7
              height: 17
              color: Theme.accent
              radius: 3
              anchors.verticalCenter: parent.verticalCenter
              border.color: Theme.accent
              border.width: 3
          }

          Workspaces {
              anchors.verticalCenter: parent.verticalCenter
          }

          Rectangle {
              width: 7
              height: 17
              color: Theme.accent
              radius: 3
              anchors.verticalCenter: parent.verticalCenter
              border.color: Theme.accent
              border.width: 3
          }
        }

        // Right section
        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: 17

          WindowTitle {
              anchors.verticalCenter: parent.verticalCenter
          }

          Text {
              text: "A7R-OS"
              color: Theme.accent
              font.pixelSize: 13
              font.bold: true
              anchors.verticalCenter: parent.verticalCenter
          }


          Rectangle {
              width: 7
              height: 17
              color: Theme.accent
              radius: 3
              anchors.verticalCenter: parent.verticalCenter
              border.color: Theme.accent
              border.width: 3
          }
        }
    }
}
