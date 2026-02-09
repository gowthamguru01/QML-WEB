import QtQuick 2.0

Rectangle {
    width: 900
    height: 600
    color: "#0f0f0f"

    Rectangle {
        width: 440
        height: 360
        radius: 18
        color: "#1b1b1b"
        border.color: "#2a2a2a"
        border.width: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -40

        Column {
            spacing: 14
            anchors.fill: parent
            anchors.margins: 24

            Text {
                text: "MoFo Companion Lite"
                color: "white"
                font.pixelSize: 22
                font.bold: true
            }

            Text {
                text: "A lightweight AI companion interface"
                color: "#a1a1a1"
                font.pixelSize: 13
                wrapMode: Text.WordWrap
            }

            Rectangle {
                width: parent.width
                height: 42
                radius: 8
                color: "#111111"
                border.color: "#2f2f2f"

                TextInput {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "white"
                    font.pixelSize: 14
                    placeholderText: "Type your message..."
                    placeholderTextColor: "#6b6b6b"
                }
            }

            Rectangle {
                width: parent.width
                height: 42
                radius: 8
                color: "#2563eb"

                Text {
                    anchors.centerIn: parent
                    text: "Send"
                    color: "white"
                    font.pixelSize: 15
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("Send clicked")
                }
            }
        }
    }
}
