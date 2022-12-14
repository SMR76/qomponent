// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Item {
    id: control

    property alias delay: timer.interval
    property alias text: tooltiptext.text
    property alias font: tooltiptext.font
    property alias contentItem: tooltiptext

    onVisibleChanged: {
        timer.restart();
    }

    Timer {
        id: timer
        interval: 500
        running: control.visible

        onTriggered: {
            let coord = mapToGlobal(0, 0);
            win.x = Math.min(coord.x + 5, Screen .width - win.width - 10);
            win.y = Math.min(coord.y, Screen.height - win.height - 10);
        }
    }

    Window {
        id: win
        width: tooltiptext.width
        height: tooltiptext.height
        visible: control.visible && !timer.running;
        color: 'transparent'
        flags: Qt.FramelessWindowHint | Qt.WindowTransparentForInput

        Rectangle {
            anchors.fill: parent
            color: '#f8f9fa'
            border { color: '#e9ecef'; width: 1 }
            radius: 2
            Text {
                id: tooltiptext
                text: ''
                color: 'gray'
                padding: 5
                font.pixelSize: 10
            }
        }
    }
}
