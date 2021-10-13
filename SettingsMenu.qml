import QtQuick 2.15
import QtQuick.Controls 2.1

Page {
    id: root
    signal back

    Button{
       id: _back

       anchors.left: parent.left
       anchors.top: parent.top

       width: 50
       height: 50

       text: qsTr("Back")

       onClicked: {
           root.back()
       }
    }

    Button{
       id: _ru

       anchors.top: parent.top
       anchors.horizontalCenter: parent.horizontalCenter

       width: parent.width/2
       height: 50

       text: qsTr("Russian")

       onClicked: {
            myTra
       }
    }

    Button{
        id: _en

        anchors.top: _ru.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width/2
        height: 50

        text: qsTr("English")

        onClicked: {

        }
    }

}

