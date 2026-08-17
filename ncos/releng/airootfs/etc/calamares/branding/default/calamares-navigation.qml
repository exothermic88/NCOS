/* SPDX-FileCopyrightText: no
 * SPDX-License-Identifier: CC0-1.0
 *
 * NCOS Calamares navigation bar.
 * NCOS Nord palette — keep in sync: branding.desc / stylesheet.qss /
 * show.qml / calamares-sidebar.qml
 */
import io.calamares.core 1.0
import io.calamares.ui 1.0
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: navBar
    color: "#2E3440"
    // Calamares reads this height once at load (clamped to [16,64]) and
    // fixes the panel to it; anchors on the root would make it read 0.
    height: 58

    readonly property color surface: "#3B4252"
    readonly property color surfaceHi: "#434C5E"
    readonly property color border_: "#4C566A"
    readonly property color textCol: "#D8DEE9"
    readonly property color accent: "#88C0D0"
    readonly property color accentHov: "#81A1C1"
    readonly property color danger: "#BF616A"

    // ViewManager labels carry QWidget mnemonics ("&Back"); QML Text
    // renders the '&' literally, so strip single '&' and unescape "&&".
    function cleanLabel(s) { return s.replace(/&(.)/g, "$1") }

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 1
        color: navBar.surfaceHi
    }

    component NavButton: Rectangle {
        id: btn
        property alias label: txt.text
        property bool filled: false
        property color fillColor: navBar.accent
        property color hoverFill: navBar.accentHov
        signal activated()

        implicitWidth: Math.max(110, txt.implicitWidth + 44)
        implicitHeight: 38
        radius: height / 2
        border.width: filled ? 0 : 1
        border.color: navBar.border_
        color: !enabled ? (filled ? Qt.darker(fillColor, 1.8) : "transparent")
             : ma.pressed ? (filled ? Qt.darker(fillColor, 1.15) : navBar.surfaceHi)
             : ma.containsMouse ? (filled ? hoverFill : navBar.surface)
             : (filled ? fillColor : "transparent")
        Behavior on color { ColorAnimation { duration: 150 } }
        opacity: enabled ? 1.0 : 0.45

        Text {
            id: txt
            anchors.centerIn: parent
            color: btn.filled ? "#2E3440" : navBar.textCol
            font.pixelSize: 14
            font.weight: btn.filled ? Font.DemiBold : Font.Normal
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: if (btn.enabled) btn.activated()
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 18
        anchors.rightMargin: 18
        spacing: 12

        Item { Layout.fillWidth: true }

        NavButton {
            label: navBar.cleanLabel(ViewManager.backLabel)
            enabled: ViewManager.backEnabled
            visible: ViewManager.backAndNextVisible
            onActivated: ViewManager.back()
        }
        NavButton {
            label: navBar.cleanLabel(ViewManager.nextLabel)
            filled: true
            enabled: ViewManager.nextEnabled
            visible: ViewManager.backAndNextVisible
            onActivated: ViewManager.next()
        }
        Rectangle {
            Layout.preferredWidth: 1
            Layout.preferredHeight: 24
            color: navBar.surfaceHi
        }
        NavButton {
            label: navBar.cleanLabel(ViewManager.quitLabel)
            border.color: Qt.rgba(0.75, 0.38, 0.42, 0.55)
            enabled: ViewManager.quitEnabled
            visible: ViewManager.quitVisible
            onActivated: ViewManager.quit()
        }
    }
}
