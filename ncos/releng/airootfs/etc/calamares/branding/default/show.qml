/* SPDX-FileCopyrightText: no
 * SPDX-License-Identifier: CC0-1.0
 *
 * NCOS install slideshow (slideshowAPI 2).
 * NCOS Nord palette — keep in sync: branding.desc / stylesheet.qss /
 * calamares-sidebar.qml / calamares-navigation.qml
 */
pragma ComponentBehavior: Bound
import QtQuick
import calamares.slideshow 1.0

Presentation {
    id: presentation

    readonly property color bg: "#2E3440"
    readonly property color surface: "#3B4252"
    readonly property color surfaceHi: "#434C5E"
    readonly property color muted: "#4C566A"
    readonly property color textCol: "#D8DEE9"
    readonly property color textHi: "#ECEFF4"
    readonly property color accent: "#88C0D0"
    readonly property color accent2: "#81A1C1"
    readonly property color success: "#A3BE8C"
    readonly property color nordRed: "#BF616A"
    readonly property color nordOrange: "#D08770"
    readonly property color nordYellow: "#EBCB8B"
    readonly property color nordPurple: "#B48EAD"
    readonly property color termBg: "#242933"
    readonly property string monoFont: "FiraCode Nerd Font"

    // Proportional scaling; the Calamares window is 64em x 48em (~4:3).
    readonly property real sc: Math.min(width / 840, height / 520)
    function fs(px) { return Math.max(9, Math.round(px * sc)) }

    loopSlides: true
    mouseNavigation: true

    Rectangle {
        anchors.fill: parent
        color: presentation.bg
        z: -1
    }

    Timer {
        interval: 7000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    // ------------------------------------------------------------------
    // Building blocks
    // ------------------------------------------------------------------

    // Slide with the shared enter animation; slide content becomes
    // children of the animated inner Item via the default property.
    component NcosSlide: Slide {
        id: ncosSlide
        anchors.fill: parent
        default property alias body: inner.data
        Item {
            id: inner
            anchors.fill: parent
            opacity: ncosSlide.visible ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            transform: Translate {
                y: ncosSlide.visible ? 0 : 24
                Behavior on y { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            }
        }
    }

    component SlideHeader: Column {
        property alias text: headerText.text
        spacing: presentation.fs(8)
        Text {
            id: headerText
            color: presentation.accent
            font.pixelSize: presentation.fs(27)
            font.weight: Font.DemiBold
        }
        Rectangle {
            width: presentation.fs(46)
            height: Math.max(2, Math.round(3 * presentation.sc))
            radius: height / 2
            color: presentation.accent
        }
    }

    component Bullet: Row {
        id: bulletRoot
        property alias text: bulletBody.text
        property real bodyWidth: presentation.width * 0.34
        spacing: presentation.fs(10)
        Text {
            text: "•"
            color: presentation.accent
            font.pixelSize: presentation.fs(16)
            font.bold: true
        }
        Text {
            id: bulletBody
            width: bulletRoot.bodyWidth
            color: presentation.textCol
            font.pixelSize: presentation.fs(16)
            wrapMode: Text.WordWrap
        }
    }

    component MockWindow: Rectangle {
        id: mockWin
        property string title: ""
        default property alias contentData: mockBody.data
        color: presentation.termBg
        radius: presentation.fs(8)
        border.color: presentation.muted
        border.width: 1
        clip: true
        Rectangle {
            id: mockBar
            width: parent.width
            height: presentation.fs(22)
            color: presentation.surfaceHi
            radius: mockWin.radius
            Rectangle {
                width: parent.width
                height: parent.radius
                anchors.bottom: parent.bottom
                color: parent.color
            }
            Row {
                anchors.verticalCenter: parent.verticalCenter
                x: presentation.fs(9)
                spacing: presentation.fs(5)
                Rectangle { width: presentation.fs(8); height: width; radius: width / 2; color: presentation.nordRed }
                Rectangle { width: presentation.fs(8); height: width; radius: width / 2; color: presentation.nordYellow }
                Rectangle { width: presentation.fs(8); height: width; radius: width / 2; color: presentation.success }
            }
            Text {
                anchors.centerIn: parent
                text: mockWin.title
                color: presentation.textCol
                font.family: presentation.monoFont
                font.pixelSize: presentation.fs(10)
            }
        }
        Item {
            id: mockBody
            anchors.fill: parent
            anchors.topMargin: mockBar.height + presentation.fs(10)
            anchors.leftMargin: presentation.fs(12)
            anchors.rightMargin: presentation.fs(12)
            anchors.bottomMargin: presentation.fs(10)
        }
    }

    component TermLine: Row {
        id: termLine
        property bool isPrompt: false
        property bool check: false
        property string text: ""
        property color lineColor: presentation.muted
        spacing: presentation.fs(7)
        Text {
            visible: termLine.isPrompt
            text: "❯"
            color: presentation.success
            font.family: presentation.monoFont
            font.pixelSize: presentation.fs(12)
            font.bold: true
        }
        Text {
            text: termLine.text
            color: termLine.isPrompt ? presentation.textHi : termLine.lineColor
            font.family: presentation.monoFont
            font.pixelSize: presentation.fs(12)
        }
        Text {
            visible: termLine.check
            text: "✓"
            color: presentation.success
            font.family: presentation.monoFont
            font.pixelSize: presentation.fs(12)
        }
    }

    component KeyCap: Rectangle {
        property alias text: keyText.text
        color: presentation.surfaceHi
        radius: presentation.fs(4)
        border.color: presentation.muted
        border.width: 1
        height: presentation.fs(20)
        width: keyText.implicitWidth + presentation.fs(14)
        Text {
            id: keyText
            anchors.centerIn: parent
            color: presentation.textHi
            font.family: presentation.monoFont
            font.pixelSize: presentation.fs(11)
        }
    }

    component ShortcutRow: Row {
        id: shortcutRow
        property var keys: []
        property string label: ""
        spacing: presentation.fs(10)
        Row {
            spacing: presentation.fs(4)
            anchors.verticalCenter: parent.verticalCenter
            Repeater {
                model: shortcutRow.keys
                delegate: Row {
                    required property int index
                    required property var modelData
                    spacing: presentation.fs(4)
                    Text {
                        visible: parent.index > 0
                        text: "+"
                        color: presentation.muted
                        font.pixelSize: presentation.fs(11)
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    KeyCap { text: parent.modelData }
                }
            }
        }
        Text {
            text: shortcutRow.label
            color: presentation.textCol
            font.pixelSize: presentation.fs(14)
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    component ThemeSwatch: Column {
        id: themeSwatch
        property color swatchColor
        property string name: ""
        property bool active: false
        spacing: presentation.fs(5)
        Rectangle {
            width: presentation.fs(28)
            height: width
            radius: presentation.fs(6)
            color: themeSwatch.swatchColor
            border.color: themeSwatch.active ? presentation.textHi : "transparent"
            border.width: themeSwatch.active ? 2 : 0
            anchors.horizontalCenter: parent.horizontalCenter
            scale: themeSwatch.active ? 1.15 : 1.0
            Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
        }
        Text {
            text: themeSwatch.name
            color: themeSwatch.active ? presentation.textHi : presentation.muted
            font.pixelSize: presentation.fs(10)
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    component InfoCard: Rectangle {
        id: infoCard
        property string glyph: ""
        property string cardTitle: ""
        property string url: ""
        property string caption: ""
        color: presentation.surface
        radius: presentation.fs(10)
        border.color: presentation.muted
        border.width: 1
        Column {
            anchors.centerIn: parent
            width: parent.width - presentation.fs(20)
            spacing: presentation.fs(8)
            Text {
                text: infoCard.glyph
                color: presentation.accent
                font.family: presentation.monoFont
                font.pixelSize: presentation.fs(28)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: infoCard.cardTitle
                color: presentation.textHi
                font.pixelSize: presentation.fs(16)
                font.weight: Font.DemiBold
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: infoCard.url
                color: presentation.accent2
                font.family: presentation.monoFont
                font.pixelSize: presentation.fs(12)
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: 8
            }
            Text {
                text: infoCard.caption
                color: presentation.textCol
                font.pixelSize: presentation.fs(11)
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
        }
    }

    component Pill: Rectangle {
        property alias text: pillText.text
        color: presentation.surfaceHi
        radius: presentation.fs(5)
        height: presentation.fs(22)
        width: pillText.implicitWidth + presentation.fs(16)
        Text {
            id: pillText
            anchors.centerIn: parent
            color: presentation.textHi
            font.family: presentation.monoFont
            font.pixelSize: presentation.fs(12)
        }
    }

    // ------------------------------------------------------------------
    // Slide 1 — Welcome
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide1
        Column {
            anchors.centerIn: parent
            width: parent.width * 0.8
            spacing: presentation.fs(16)
            Item {
                width: parent.width
                height: presentation.height * 0.32
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height
                    width: height * (16 / 9) + presentation.fs(2)
                    radius: presentation.fs(10)
                    // heading_dark.png has an opaque #1B1B1B background;
                    // matching it makes the rounded card seamless.
                    color: "#1B1B1B"
                    border.color: presentation.surface
                    border.width: 1
                    transform: Translate {
                        SequentialAnimation on y {
                            running: slide1.visible
                            loops: Animation.Infinite
                            NumberAnimation { from: 0; to: 6; duration: 3000; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 6; to: 0; duration: 3000; easing.type: Easing.InOutSine }
                        }
                    }
                    Image {
                        source: "heading_dark.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        anchors.margins: presentation.fs(8)
                    }
                }
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Welcome to NCOS"
                color: presentation.accent
                font.pixelSize: presentation.fs(34)
                font.weight: Font.DemiBold
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "A Nord-themed Arch Linux, ready out of the box."
                color: presentation.textCol
                font.pixelSize: presentation.fs(17)
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Installation is running in the background — enjoy the tour."
                color: presentation.muted
                font.pixelSize: presentation.fs(12)
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.WordWrap
            }
        }
    }

    // ------------------------------------------------------------------
    // Slide 2 — Built on Arch
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide2
        Row {
            anchors.centerIn: parent
            width: presentation.width * 0.88
            spacing: width * 0.04
            Column {
                width: parent.width * 0.46
                anchors.verticalCenter: parent.verticalCenter
                spacing: presentation.fs(14)
                SlideHeader { text: "Built on Arch" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "Rolling release — always current, never reinstall" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "pacman and the yay AUR helper, preinstalled" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "The [ncos] repo keeps NCOS packages updated" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "Timeshift + grub-btrfs snapshots have your back" }
            }
            MockWindow {
                width: parent.width * 0.50
                height: presentation.height * 0.52
                anchors.verticalCenter: parent.verticalCenter
                title: "kitty"
                Column {
                    width: parent.width
                    spacing: presentation.fs(7)
                    TermLine { isPrompt: true; text: "sudo pacman -Syu" }
                    TermLine { text: ":: Synchronizing package databases..." }
                    TermLine { text: " core is up to date"; check: true }
                    TermLine { text: " extra is up to date"; check: true }
                    TermLine { text: " ncos is up to date"; check: true }
                    TermLine { text: ":: Starting full system upgrade..." }
                    Item {
                        id: pacmanBar
                        property real prog: 0
                        width: parent.width
                        height: presentation.fs(16)
                        SequentialAnimation on prog {
                            running: slide2.visible
                            loops: Animation.Infinite
                            NumberAnimation { from: 0; to: 1; duration: 3200; easing.type: Easing.InOutQuad }
                            PauseAnimation { duration: 1000 }
                        }
                        Rectangle {
                            width: parent.width - presentation.fs(44)
                            height: presentation.fs(8)
                            radius: height / 2
                            anchors.verticalCenter: parent.verticalCenter
                            color: presentation.muted
                            Rectangle {
                                width: parent.width * pacmanBar.prog
                                height: parent.height
                                radius: parent.radius
                                color: presentation.accent
                            }
                        }
                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            text: Math.round(pacmanBar.prog * 100) + "%"
                            color: presentation.textCol
                            font.family: presentation.monoFont
                            font.pixelSize: presentation.fs(11)
                        }
                    }
                    TermLine {
                        text: "(132/132) upgrade complete"
                        lineColor: presentation.success
                        opacity: pacmanBar.prog > 0.98 ? 1 : 0.25
                    }
                }
            }
        }
    }

    // ------------------------------------------------------------------
    // Slide 3 — COSMIC desktop & Nord theming
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide3
        property int themeIndex: 0
        readonly property var themeColors: [presentation.accent, presentation.nordRed, presentation.nordPurple, presentation.success]
        readonly property var themeNames: ["nord", "red", "purple", "green"]
        property color themeAccent: themeColors[themeIndex]
        Behavior on themeAccent { ColorAnimation { duration: 450 } }

        Timer {
            interval: 2000
            repeat: true
            running: slide3.visible
            onTriggered: slide3.themeIndex = (slide3.themeIndex + 1) % 4
        }

        Row {
            anchors.centerIn: parent
            width: presentation.width * 0.88
            spacing: width * 0.04
            Column {
                width: parent.width * 0.46
                anchors.verticalCenter: parent.verticalCenter
                spacing: presentation.fs(12)
                Rectangle {
                    id: miniDesktop
                    width: parent.width
                    height: presentation.height * 0.44
                    radius: presentation.fs(8)
                    border.color: presentation.muted
                    border.width: 1
                    clip: true
                    gradient: Gradient {
                        GradientStop { position: 0; color: Qt.darker(slide3.themeAccent, 2.6) }
                        GradientStop { position: 1; color: presentation.termBg }
                    }
                    Rectangle {
                        id: miniPanel
                        x: presentation.fs(6)
                        y: presentation.fs(6)
                        width: parent.width - presentation.fs(12)
                        height: presentation.fs(16)
                        radius: height / 2
                        color: presentation.surface
                        opacity: 0.88
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            x: presentation.fs(8)
                            spacing: presentation.fs(4)
                            Rectangle { width: presentation.fs(6); height: width; radius: width / 2; color: slide3.themeAccent }
                            Rectangle { width: presentation.fs(6); height: width; radius: width / 2; color: presentation.muted }
                            Rectangle { width: presentation.fs(6); height: width; radius: width / 2; color: presentation.muted }
                        }
                        Text {
                            anchors.centerIn: parent
                            text: "12:00"
                            color: presentation.textCol
                            font.pixelSize: presentation.fs(9)
                        }
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: presentation.fs(8)
                            spacing: presentation.fs(4)
                            Rectangle { width: presentation.fs(6); height: width; radius: presentation.fs(2); color: presentation.muted }
                            Rectangle { width: presentation.fs(6); height: width; radius: presentation.fs(2); color: presentation.muted }
                            Rectangle { width: presentation.fs(6); height: width; radius: presentation.fs(2); color: presentation.muted }
                        }
                    }
                    Row {
                        anchors.fill: parent
                        anchors.topMargin: miniPanel.y + miniPanel.height + presentation.fs(6)
                        anchors.leftMargin: presentation.fs(6)
                        anchors.rightMargin: presentation.fs(6)
                        anchors.bottomMargin: presentation.fs(6)
                        spacing: presentation.fs(5)
                        Rectangle {
                            width: (parent.width - parent.spacing) / 2
                            height: parent.height
                            color: presentation.termBg
                            radius: presentation.fs(5)
                            border.color: slide3.themeAccent
                            border.width: 2
                            Behavior on border.color { ColorAnimation { duration: 450 } }
                            Column {
                                x: presentation.fs(8)
                                y: presentation.fs(8)
                                spacing: presentation.fs(6)
                                Text {
                                    text: "❯"
                                    color: slide3.themeAccent
                                    font.family: presentation.monoFont
                                    font.pixelSize: presentation.fs(10)
                                    font.bold: true
                                    Behavior on color { ColorAnimation { duration: 450 } }
                                }
                                Rectangle { width: presentation.fs(60); height: presentation.fs(4); radius: height / 2; color: presentation.muted }
                                Rectangle { width: presentation.fs(44); height: presentation.fs(4); radius: height / 2; color: presentation.muted }
                                Rectangle { width: presentation.fs(52); height: presentation.fs(4); radius: height / 2; color: presentation.muted }
                            }
                        }
                        Rectangle {
                            width: (parent.width - parent.spacing) / 2
                            height: parent.height
                            color: presentation.surface
                            radius: presentation.fs(5)
                            Row {
                                anchors.fill: parent
                                anchors.margins: presentation.fs(8)
                                spacing: presentation.fs(8)
                                Rectangle {
                                    width: presentation.fs(8)
                                    height: parent.height
                                    radius: presentation.fs(2)
                                    color: presentation.surfaceHi
                                }
                                Column {
                                    spacing: presentation.fs(6)
                                    Rectangle { width: presentation.fs(50); height: presentation.fs(4); radius: height / 2; color: presentation.accent2 }
                                    Rectangle {
                                        width: presentation.fs(64); height: presentation.fs(4); radius: height / 2
                                        color: slide3.themeAccent
                                        Behavior on color { ColorAnimation { duration: 450 } }
                                    }
                                    Rectangle { width: presentation.fs(40); height: presentation.fs(4); radius: height / 2; color: presentation.muted }
                                    Rectangle { width: presentation.fs(56); height: presentation.fs(4); radius: height / 2; color: presentation.muted }
                                    Rectangle {
                                        width: presentation.fs(46); height: presentation.fs(4); radius: height / 2
                                        color: slide3.themeAccent
                                        Behavior on color { ColorAnimation { duration: 450 } }
                                    }
                                }
                            }
                        }
                    }
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: presentation.fs(14)
                    Repeater {
                        model: 4
                        delegate: ThemeSwatch {
                            required property int index
                            swatchColor: slide3.themeColors[index]
                            name: slide3.themeNames[index]
                            active: slide3.themeIndex === index
                        }
                    }
                }
            }
            Column {
                width: parent.width * 0.46
                anchors.verticalCenter: parent.verticalCenter
                spacing: presentation.fs(13)
                SlideHeader { text: "COSMIC, Nord everywhere" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "COSMIC desktop with autotiling on by default" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "Four theme variants restyle COSMIC, kitty, VS Code and the wallpaper together" }
                ShortcutRow { x: presentation.fs(26); keys: ["Super", "Shift", "]"]; label: "cycles themes" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "Dark mode and Papirus icons out of the box" }
                Bullet { bodyWidth: parent.width - presentation.fs(26); text: "NCOS Assistant — a built-in local AI applet that answers from the NCOS docs, fully offline" }
            }
        }
    }

    // ------------------------------------------------------------------
    // Slide 4 — Getting started
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide4
        Column {
            anchors.centerIn: parent
            width: presentation.width * 0.88
            spacing: presentation.fs(14)
            SlideHeader { text: "Getting started" }
            Row {
                width: parent.width
                spacing: parent.width * 0.05
                Column {
                    width: parent.width * 0.5
                    spacing: presentation.fs(9)
                    Text {
                        text: "ESSENTIAL SHORTCUTS"
                        color: presentation.muted
                        font.pixelSize: presentation.fs(11)
                        font.letterSpacing: 1.5 * presentation.sc
                    }
                    ShortcutRow { keys: ["Super", "T"]; label: "Terminal (kitty)" }
                    ShortcutRow { keys: ["Super", "C"]; label: "VS Code" }
                    ShortcutRow { keys: ["Super", "F"]; label: "Files" }
                    ShortcutRow { keys: ["Super", "N"]; label: "Neovim" }
                    ShortcutRow { keys: ["Super", "Shift", "W"]; label: "Wallpaper picker" }
                    ShortcutRow { keys: ["Super", "Shift", "]"]; label: "Next theme" }
                }
                MockWindow {
                    width: parent.width * 0.45
                    height: presentation.height * 0.40
                    title: "fastfetch"
                    Column {
                        width: parent.width
                        spacing: presentation.fs(10)
                        Row {
                            spacing: presentation.fs(12)
                            Image {
                                source: "squid.png"
                                width: presentation.fs(56)
                                height: width
                                smooth: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Column {
                                spacing: presentation.fs(4)
                                anchors.verticalCenter: parent.verticalCenter
                                Row {
                                    spacing: presentation.fs(6)
                                    Text { text: "OS:"; color: presentation.accent; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12); font.bold: true }
                                    Text { text: "NCOS Linux"; color: presentation.textCol; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12) }
                                }
                                Row {
                                    spacing: presentation.fs(6)
                                    Text { text: "DE:"; color: presentation.accent; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12); font.bold: true }
                                    Text { text: "COSMIC"; color: presentation.textCol; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12) }
                                }
                                Row {
                                    spacing: presentation.fs(6)
                                    Text { text: "Shell:"; color: presentation.accent; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12); font.bold: true }
                                    Text { text: "fish + starship"; color: presentation.textCol; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12) }
                                }
                                Row {
                                    spacing: presentation.fs(6)
                                    Text { text: "Apps:"; color: presentation.accent; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12); font.bold: true }
                                    Text { text: "Firefox · Code · nvim"; color: presentation.textCol; font.family: presentation.monoFont; font.pixelSize: presentation.fs(12) }
                                }
                            }
                        }
                        Row {
                            spacing: presentation.fs(4)
                            Repeater {
                                model: [presentation.bg, presentation.nordRed, presentation.success, presentation.nordYellow, presentation.accent2, presentation.nordPurple, presentation.accent, presentation.textHi]
                                delegate: Rectangle {
                                    required property var modelData
                                    width: presentation.fs(13)
                                    height: width
                                    radius: presentation.fs(2)
                                    color: modelData
                                }
                            }
                        }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: presentation.fs(8)
                Text {
                    text: "Update anytime:"
                    color: presentation.muted
                    font.pixelSize: presentation.fs(13)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Pill { text: "sudo pacman -Syu"; anchors.verticalCenter: parent.verticalCenter }
                Text {
                    text: "·   AUR:"
                    color: presentation.muted
                    font.pixelSize: presentation.fs(13)
                    anchors.verticalCenter: parent.verticalCenter
                }
                Pill { text: "yay -S <pkg>"; anchors.verticalCenter: parent.verticalCenter }
            }
        }
    }

    // ------------------------------------------------------------------
    // Slide 5 — Community & help
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide5
        Column {
            anchors.centerIn: parent
            width: presentation.width * 0.88
            spacing: presentation.fs(20)
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: presentation.fs(8)
                Text {
                    text: "You're not alone"
                    color: presentation.accent
                    font.pixelSize: presentation.fs(27)
                    font.weight: Font.DemiBold
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle {
                    width: presentation.fs(46)
                    height: Math.max(2, Math.round(3 * presentation.sc))
                    radius: height / 2
                    color: presentation.accent
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: "Docs, downloads and a place to report bugs."
                    color: presentation.muted
                    font.pixelSize: presentation.fs(13)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: presentation.fs(16)
                InfoCard {
                    width: presentation.width * 0.26
                    height: presentation.height * 0.36
                    glyph: "\uf0ac"
                    cardTitle: "Website"
                    url: "exothermic88.github.io"
                    caption: "Guides & news"
                }
                InfoCard {
                    width: presentation.width * 0.26
                    height: presentation.height * 0.36
                    glyph: "\uf09b"
                    cardTitle: "Project"
                    url: "github.com/exothermic88/NCOS"
                    caption: "Source, issues & feature requests"
                }
                InfoCard {
                    width: presentation.width * 0.26
                    height: presentation.height * 0.36
                    glyph: "\uf303"
                    cardTitle: "Arch Wiki"
                    url: "wiki.archlinux.org"
                    caption: "It's Arch underneath — the wiki applies"
                }
            }
        }
    }

    // ------------------------------------------------------------------
    // Slide 6 — Thank you
    // ------------------------------------------------------------------
    NcosSlide {
        id: slide6
        Column {
            anchors.centerIn: parent
            width: presentation.width * 0.7
            spacing: presentation.fs(16)
            Item {
                width: parent.width
                height: presentation.fs(110)
                Image {
                    source: "squid.png"
                    width: presentation.fs(100)
                    height: width
                    smooth: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    SequentialAnimation on y {
                        running: slide6.visible
                        loops: Animation.Infinite
                        NumberAnimation { from: 0; to: 6; duration: 3000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: 6; to: 0; duration: 3000; easing.type: Easing.InOutSine }
                    }
                }
            }
            Text {
                text: "Thank you for choosing NCOS"
                color: presentation.accent
                font.pixelSize: presentation.fs(34)
                font.weight: Font.DemiBold
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                text: "When the installer finishes, reboot and log in with the account you just created. NCOS appears in your GRUB menu automatically."
                color: presentation.textCol
                font.pixelSize: presentation.fs(16)
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Enjoy your new system."
                color: presentation.success
                font.pixelSize: presentation.fs(16)
                font.italic: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // ------------------------------------------------------------------
    // Progress dots
    // ------------------------------------------------------------------
    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 26
        spacing: 10
        z: 10
        Repeater {
            model: presentation.slides.length
            Rectangle {
                id: dot
                required property int index
                width: index === presentation.currentSlide ? 26 : 8
                height: 8
                radius: 4
                color: index === presentation.currentSlide ? presentation.accent : presentation.muted
                Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 250 } }
                MouseArea {
                    anchors.fill: parent
                    onClicked: presentation.currentSlide = dot.index
                }
            }
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }

    function onLeave() {
    }
}
