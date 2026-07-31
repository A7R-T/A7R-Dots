import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "../theme"

PanelWindow {
    id: launcherWindow
    property bool isOpen: false

    visible: isOpen
    color: "transparent"

    // Wayland layer positioning
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "a7r-launcher"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Centered modal layout
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // Backdrop click-to-close
    MouseArea {
        anchors.fill: parent
        onClicked: launcherWindow.isOpen = false
    }

    // Main Modal Card
    Rectangle {
        id: mainCard
        width: 570
        height: 430
        anchors.centerIn: parent

        color: "transparent"
        border.color: Theme.accent
        border.width: 1
        radius: 17
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "#121F2A"
            opacity: 0.37 // Adjust background transparency here without affecting text/icons
        }
        // Prevent click-through closing when clicking inside card
        MouseArea { anchors.fill: parent }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 17
            spacing: 13

            // ----------------------------------------------------
            // 1. SEARCH INPUT
            // ----------------------------------------------------
            Rectangle {
                Layout.fillWidth: true
                height: 45
                color: Theme.surface
                radius: 7
                border.color: searchInput.activeFocus ? Theme.accent : "transparent"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 13
                    anchors.rightMargin: 13
                    spacing: 10

                    Text {
                        text: "󰍉"
                        color: Theme.accent
                        font.pixelSize: 18
                    }

                    TextField {
                        id: searchInput
                        Layout.fillWidth: true
                        placeholderText: "Type to search..."
                        placeholderTextColor: "#5c6370"
                        color: Theme.text
                        font.pixelSize: 15
                        font.bold: true
                        focus: true
                        background: null

                        onTextChanged: {
                            appList.currentIndex = appList.count > 0 ? 0 : -1
                        }

                        // Keyboard Navigation Rules
                        Keys.onPressed: event => {
                            if (event.key === Qt.Key_Escape) {
                                launcherWindow.isOpen = false
                                event.accepted = true
                            } else if (event.key === Qt.Key_Down) {
                                if (appList.currentIndex < appList.count - 1) appList.currentIndex++
                                event.accepted = true
                            } else if (event.key === Qt.Key_Up) {
                                if (appList.currentIndex > 0) appList.currentIndex--
                                event.accepted = true
                            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                launchSelected()
                                event.accepted = true
                            }
                        }
                    }
                }
            }

            // ----------------------------------------------------
            // 2. FILTERED RESULTS LIST
            // ----------------------------------------------------
            ListView {
                id: appList
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 5

                // Helper JS array filter over Quickshell DesktopEntries
                model: {
                    const query = searchInput.text.trim().toLowerCase()
                    const allApps = DesktopEntries.applications.values
                    
                    if (query === "") return allApps
                    
                    return allApps.filter(app => {
                        const nameMatch = app.name && app.name.toLowerCase().includes(query)
                        const commentMatch = app.comment && app.comment.toLowerCase().includes(query)
                        const genericMatch = app.genericName && app.genericName.toLowerCase().includes(query)
                        return nameMatch || commentMatch || genericMatch
                    })
                }

                delegate: Rectangle {
                    id: delegateItem
                    required property var modelData
                    required property int index

                    width: appList.width
                    height: 45
                    radius: 7
                    color: ListView.isCurrentItem ? Theme.surface : "transparent"
                    border.color: ListView.isCurrentItem ? Theme.accent : "transparent"
                    border.width: ListView.isCurrentItem ? 1 : 0

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: appList.currentIndex = index
                        onClicked: launchSelected()
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 13
                        anchors.rightMargin: 13
                        spacing: 13

                        // App Icon
                        IconImage {
                            source: Quickshell.iconPath(modelData.icon, true)
                            Layout.preferredWidth: 24
                            Layout.preferredHeight: 24
                        }

                        // App Title
                        Text {
                            text: modelData.name
                            color: Theme.text
                            font.pixelSize: 14
                            font.bold: ListView.isCurrentItem
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }

                        // Generic Subtitle/Category hint
                        Text {
                            text: modelData.genericName || ""
                            color: "#5c6370"
                            font.pixelSize: 11
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }

    // Execution helper
    function launchSelected() {
        if (appList.currentItem && appList.currentItem.modelData) {
            appList.currentItem.modelData.execute()
            launcherWindow.isOpen = false
            searchInput.text = ""
        }
    }

    // Reset state whenever window toggles open
    onIsOpenChanged: {
        if (isOpen) {
            searchInput.text = ""
            searchInput.forceActiveFocus()
            appList.currentIndex = 0
        }
    }
}
