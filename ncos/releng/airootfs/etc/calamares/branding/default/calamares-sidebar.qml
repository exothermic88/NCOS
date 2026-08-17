/* SPDX-FileCopyrightText: no
 * SPDX-License-Identifier: CC0-1.0
 *
 * NCOS Calamares sidebar.
 * NCOS Nord palette — keep in sync: branding.desc / stylesheet.qss /
 * show.qml / calamares-navigation.qml
 */
import io.calamares.core 1.0
import io.calamares.ui 1.0
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: sideBar
    anchors.fill: parent
    color: Branding.styleString(Branding.SidebarBackground)

    readonly property color surface: "#3B4252"
    readonly property color border_: "#434C5E"
    readonly property color muted: "#4C566A"
    readonly property color accent: "#88C0D0"
    readonly property color success: "#A3BE8C"
    readonly property color textCol: Branding.styleString(Branding.SidebarText)
    readonly property color textOnAccent: Branding.styleString(Branding.SidebarTextCurrent)
    readonly property color pill: Branding.styleString(Branding.SidebarBackgroundCurrent)

    Rectangle {
        anchors.right: parent.right
        width: 1
        height: parent.height
        color: sideBar.border_
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 6

        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            source: "file:" + Branding.imagePath(Branding.ProductLogo)
            sourceSize.width: 72
            sourceSize.height: 72
            fillMode: Image.PreserveAspectFit
        }
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Branding.string(Branding.VersionedName)
            color: sideBar.accent
            font.pixelSize: 18
            font.bold: true
        }
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 18
            // Calamares' YAML loader coerces "2.0" to the double 2 and
            // hands back "2"; restore the dropped ".0" for X.0 versions.
            text: {
                const v = Branding.string(Branding.Version)
                return v.includes(".") ? v : v + ".0"
            }
            color: sideBar.muted
            font.pixelSize: 11
            font.letterSpacing: 2
            font.capitalization: Font.AllUppercase
        }

        Repeater {
            model: ViewManager
            delegate: Rectangle {
                id: stepItem
                required property int index
                required property string display
                readonly property bool isCurrent: index === ViewManager.currentStepIndex
                readonly property bool isComplete: index < ViewManager.currentStepIndex

                Layout.fillWidth: true
                implicitHeight: 38
                radius: height / 2
                color: isCurrent ? sideBar.pill : "transparent"
                Behavior on color { ColorAnimation { duration: 250; easing.type: Easing.OutCubic } }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    spacing: 10
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: stepItem.isComplete ? "✓" : "•"
                        color: stepItem.isComplete ? sideBar.success
                             : stepItem.isCurrent ? sideBar.textOnAccent : sideBar.muted
                        font.pixelSize: 14
                        font.bold: stepItem.isComplete
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: stepItem.width - 52
                        text: stepItem.display
                        color: stepItem.isCurrent ? sideBar.textOnAccent : sideBar.textCol
                        opacity: stepItem.isComplete ? 0.55 : 1.0
                        Behavior on opacity { NumberAnimation { duration: 250 } }
                        font.pixelSize: 14
                        font.weight: stepItem.isCurrent ? Font.DemiBold : Font.Normal
                        elide: Text.ElideRight
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 26
            radius: 13
            color: debugArea.containsMouse ? sideBar.surface : "transparent"
            visible: debug.enabled
            Text {
                anchors.centerIn: parent
                text: qsTr("Show debug information")
                color: sideBar.muted
                font.pixelSize: 10
            }
            MouseArea {
                id: debugArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: debug.toggle()
            }
        }
    }
}
