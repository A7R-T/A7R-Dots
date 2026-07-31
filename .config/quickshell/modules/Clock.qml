// modules/Clock.qml
import QtQuick
import "../theme"

Text {
    text: Qt.formatDateTime(new Date(), "hh:mm AP")
    color: Theme.accent
    font.pixelSize: 13
    font.bold: true

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh:mm AP")
    }
}
