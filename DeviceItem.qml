import QtQuick 2.0

Rectangle {
    id: deviceItem
    width: parent.width
    height: 80
    radius: 14
    color: "#1c2f47"

    border.color: "#27476a"
    border.width: 1

    property string name
    property string signal
    property string battery

    signal pairClicked(string deviceName)

    /* ICON */
    Rectangle {
        width: 44
        height: 44
        radius: 10
        color: "#2a4163"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
    }

    /* TEXT COLUMN */
    Column {
        anchors.left: parent.left
        anchors.leftMargin: 80
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Text {
            text: name
            color: "white"
            font.pixelSize: 16
            font.bold: true
        }

        Text {
            text: signal + " • " + battery
            color: "#7f96b3"
            font.pixelSize: 13
        }
    }

    /* PAIR BUTTON — PROPERLY ANCHORED */
    Rectangle {
        width: 84
        height: 36
        radius: 18

        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        gradient: Gradient {
            GradientStop { position: 0; color: "#6d6dfb" }
            GradientStop { position: 1; color: "#8a66ff" }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                pairClicked(deviceItem.name)
            }
        }

        Text {
            anchors.centerIn: parent
            text: "Pair"
            color: "white"
            font.pixelSize: 14
            font.bold: true
        }
    }
}
