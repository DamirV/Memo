import QtQuick 2.15
import QtQuick.Controls 2.1

Page {
    id: root
    signal newGame2x2
    signal newGame4x4
    signal newGame6x6
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
       id: _newGame2x2

       anchors.top: parent.top
       anchors.horizontalCenter: parent.horizontalCenter

       width: parent.width/2
       height: 50

       text: qsTr("New Game 2x2")

       onClicked: {
           root.newGame2x2()
       }
    }

    Button{
        id: _newGame4x4

        anchors.top: _newGame2x2.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: _newGame2x2.width
        height: 50

        text: qsTr("New Game 4x4")

        onClicked: {
            root.newGame4x4()
        }
    }

    Button{
        id: _newGame6x6

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: _newGame4x4.bottom

        width: _newGame2x2.width
        height: 50

        text: qsTr("New Game 6x6")

        onClicked: {
            root.newGame6x6()
        }
    }
}

