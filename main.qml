import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    width: 1000
    height: 800

    gradient: Gradient {
        GradientStop { position: 0; color: "#0b1624" }
        GradientStop { position: 1; color: "#13263f" }
    }

    // ---------------- STATE ----------------

    property bool scanning: false
    property int deviceIndex: 0
    property var deviceList: []

    property bool showNotification: false
    property bool connecting: false
    property bool connected: false
    property string currentDevice: ""

    // ---------------- SCAN ----------------

    function startScan() {
        deviceList = []
        deviceIndex = 0
        scanning = true
        loadTimer.start()
    }

    function stopScan() {
        scanning = false
        loadTimer.stop()
    }

    function connectDevice(name) {
        if (connecting) return

        currentDevice = name
        connecting = true
        connected = false
        showNotification = true
        connectTimer.start()
    }

    Timer {
        id: loadTimer
        interval: 900
        repeat: true

        onTriggered: {
            if (!scanning) return

            var devices = [
                {name:"MoFo Collector Pro", signal:"Strong", battery:"85%"},
                {name:"MoFo Mini V2", signal:"Medium", battery:"45%"},
                {name:"MoFo Elite Edition", signal:"Weak", battery:"92%"}
            ]

            if (deviceIndex >= devices.length) {
                scanning = false
                return
            }

            deviceList = deviceList.concat([devices[deviceIndex]])
            deviceIndex++
        }
    }

    Timer {
        id: connectTimer
        interval: 2000
        repeat: false
        onTriggered: {
            connecting = false
            connected = true
        }
    }

    // ---------------- MAIN UI ----------------

    Column {
        anchors.centerIn: parent
        width: 760
        spacing: 40

        // HEADER
        Column {
            width: parent.width
            spacing: 16

            Rectangle {
                width: 72
                height: 72
                radius: 36
                anchors.horizontalCenter: parent.horizontalCenter

                gradient: Gradient {
                    GradientStop { position: 0; color: "#5b8cff" }
                    GradientStop { position: 1; color: "#38d39f" }
                }

                Text {
                    anchors.centerIn: parent
                    text: "⌁"
                    color: "white"
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Text {
                text: "Connect Your MoFo Device"
                color: "#5da9ff"
                font.pixelSize: 34
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Let's get your collectable device paired and ready for action"
                color: "#9bb3d4"
                font.pixelSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // DEVICE CARD
        Rectangle {
            width: parent.width
            height: 180 + deviceList.length * 90
            radius: 20
            color: "#162537"
            border.color: "#1e3a5f"
            border.width: 1

            Column {
                anchors.fill: parent

                // HEADER BAR
                Rectangle {
                    width: parent.width
                    height: 80
                    color: "transparent"

                    Text {
                        text: "Device Discovery"
                        color: "white"
                        font.pixelSize: 20
                        font.bold: true
                        anchors.left: parent.left
                        anchors.leftMargin: 32
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        width: 160
                        height: 40
                        radius: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 32
                        anchors.verticalCenter: parent.verticalCenter

                        gradient: Gradient {
                            GradientStop { position: 0; color: "#6d6dfb" }
                            GradientStop { position: 1; color: "#8a66ff" }
                        }
                            
                            
                            MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onEntered: parent.opacity = 0.85
                            onExited: parent.opacity = 1

                            onClicked: scanning ? stopScan() : startScan()
                        }


                        Text {
                            anchors.centerIn: parent
                            text: scanning ? "Stop Scanning" : "Start Scanning"
                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#1e3a5f"
                }

                Column {
                    width: parent.width
                    spacing: 18
                    anchors.top: parent.top
                    anchors.topMargin: 100

                    Text {
                        visible: deviceList.length === 0
                        text: scanning ?
                              "Scanning for nearby devices..." :
                              "No devices found yet. Start scanning."
                        color: "#7f96b3"
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Repeater {
                        model: deviceList

                        Rectangle {
                            width: parent.width - 64
                            height: 80
                            radius: 14
                            color: "#1e2f45"
                            anchors.horizontalCenter: parent.horizontalCenter

                            // DEVICE NAME
                            Text {
                                text: modelData.name
                                color: "white"
                                font.pixelSize: 16
                                font.bold: true
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.top: parent.top
                                anchors.topMargin: 18
                            }

                            // SIGNAL + BATTERY (SPACED PROPERLY)
                            Row {
                                spacing: 14
                                anchors.left: parent.left
                                anchors.leftMargin: 20
                                anchors.top: parent.top
                                anchors.topMargin: 44

                                Rectangle {
                                    height: 24
                                    radius: 12
                                    width: signalText.width + 18

                                    color: modelData.signal === "Strong" ? "#1f5f4a"
                                         : modelData.signal === "Medium" ? "#5f4f1f"
                                         : "#5f1f2f"

                                    Text {
                                        id: signalText
                                        anchors.centerIn: parent
                                        text: modelData.signal.toLowerCase() + " signal"
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: modelData.signal === "Strong" ? "#3ddc97"
                                             : modelData.signal === "Medium" ? "#f4c430"
                                             : "#ff6b6b"
                                    }
                                }

                                Text {
                                    text: "▢ " + modelData.battery
                                    color: "#9bb3d4"
                                    font.pixelSize: 13
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            // PAIR BUTTON
                            Rectangle {
                                width: 100
                                height: 40
                                radius: 20
                                anchors.right: parent.right
                                anchors.rightMargin: 20
                                anchors.verticalCenter: parent.verticalCenter

                                gradient: Gradient {
                                    GradientStop { position: 0; color: "#6d6dfb" }
                                    GradientStop { position: 1; color: "#8a66ff" }
                                }
                                
                                
                                  MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                enabled: !connecting

                                onEntered: parent.opacity = 0.85
                                onExited: parent.opacity = 1

                                onClicked: connectDevice(modelData.name)
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
                    }
                }
            }
        }
    }

 // ---------------- FINAL STABLE NOTIFICATION ----------------

Rectangle {
    id: notificationBar
    width: 760
    height: 100
    radius: 18

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 40

    visible: showNotification
    opacity: showNotification ? 1 : 0
    y: showNotification ? 0 : 30

    Behavior on opacity { NumberAnimation { duration: 250 } }
    Behavior on y { NumberAnimation { duration: 300 } }

    gradient: Gradient {
        GradientStop { position: 0; color: "#1c3652" }
        GradientStop { position: 1; color: "#1f4d5f" }
    }

    border.color: "#2e6c7a"
    border.width: 1

    // LEFT SIDE CONTENT
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 24
        anchors.verticalCenter: parent.verticalCenter
        spacing: 18

        Rectangle {
            width: 48
            height: 48
            radius: 12

            gradient: Gradient {
                GradientStop { position: 0; color: "#5b8cff" }
                GradientStop { position: 1; color: "#38d39f" }
            }

            Text {
                anchors.centerIn: parent
                text: connected ? "✓" : "..."
                color: "white"
                font.pixelSize: 22
                font.bold: true
            }
        }

        Column {
            spacing: 6

            Text {
                text: connecting ?
                      "Connecting to " + currentDevice + "..." :
                      "Device Paired Successfully!"
                color: "white"
                font.pixelSize: 16
                font.bold: true
            }

            Text {
                text: connecting ?
                      "Please wait while connection is established" :
                      "Your MoFo device is now connected and ready"
                color: "#9bb3d4"
                font.pixelSize: 13
            }
        }
    }

    // RIGHT SIDE CONTINUE BUTTON (ABSOLUTE POSITIONED)
    Rectangle {
    id: continueBtn
    width: 120
    height: 40
    radius: 20
    visible: connected

    anchors.right: parent.right
    anchors.rightMargin: 24
    anchors.verticalCenter: parent.verticalCenter

    property bool hovered: false

    gradient: Gradient {
        GradientStop { position: 0; color: continueBtn.hovered ? "#34e0ad" : "#2bd19f" }
        GradientStop { position: 1; color: continueBtn.hovered ? "#28c792" : "#22b884" }
    }

    border.color: continueBtn.hovered ? "#52f5c4" : "transparent"
    border.width: continueBtn.hovered ? 1 : 0

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: continueBtn.hovered = true
        onExited: continueBtn.hovered = false
        onClicked: showNotification = false
    }

    Text {
        anchors.centerIn: parent
        text: "Continue"
        color: "white"
        font.pixelSize: 14
        font.bold: true
    }
}

}
}
