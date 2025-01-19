import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    property color backgroundColor: "#2f3541"
    property color accentColor: "#81a1c1"
    property color textColor: "#d8dee9"

    Timer {
        id: advanceTimer
        interval: 5000 // Time in milliseconds for each slide
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    function nextSlide() {
        console.log("Advancing to the next slide");
        presentation.goToNextSlide();
    }

    // Slide 1
    Slide {
        anchors.fill: parent

        Rectangle {
            id: slide1Background
            color: presentation.backgroundColor
            anchors.fill: parent
        }

        Text {
            id: slide1Title
            text: "Welcome to NCOS Installer"
            color: presentation.accentColor
            font.pixelSize: 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -20
            anchors.top: parent.top
            anchors.topMargin: 50
        }

        Text {
            id: slide1Subtitle
            text: "Your seamless Arch Linux experience starts here."
            color: presentation.textColor
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: slide1Title.bottom
            anchors.topMargin: 20
        }

        Image {
            id: slide1Image
            source: "heading_dark.png" // Replace with your image path
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            height: parent.height * 0.4
        }
    }

    // Slide 2
    Slide {
        anchors.fill: parent

        Rectangle {
            id: slide2Background
            color: presentation.backgroundColor
            anchors.fill: parent
        }

        Text {
            id: slide2Title
            text: "Powerful Features"
            color: presentation.accentColor
            font.pixelSize: 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -30
            anchors.top: parent.top
            anchors.topMargin: 50
        }

        Text {
            id: slide2Content
            text: "• Lightweight Cosmic desktop environment\n• Pre-configured tools for developers\n• Secure and fast installation process"
            color: presentation.textColor
            font.pixelSize: 20
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: slide2Title.bottom
            anchors.topMargin: 20
            width: parent.width * 0.8
        }
    }

    // Slide 3
    Slide {
        anchors.fill: parent

        Rectangle {
            id: slide3Background
            color: presentation.backgroundColor
            anchors.fill: parent
        }

        Text {
            id: slide3Title
            text: "Thank You for Choosing NCOS"
            color: presentation.accentColor
            font.pixelSize: 32
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
        }

        Text {
            id: slide3Content
            text: "We aim to make Linux accessible, efficient, and enjoyable."
            color: presentation.textColor
            font.pixelSize: 20
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: slide3Title.bottom
            anchors.topMargin: 20
        }

        Image {
            id: slide3Image
            source: "Heading.png" // Replace with your image path
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            height: parent.height * 0.4
        }
    }

    function onActivate() {
        console.log("Slideshow activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("Slideshow deactivated");
    }
}
