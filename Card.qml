import QtQuick 2.0

Rectangle {
    id: root

    property string status: ""
    radius: 15
    border{
        color: "black"
        width: 1
    }

    Image {
        id: name
        anchors.fill: parent

        source: "images/images/" + root.status + ".png"

    }
}
