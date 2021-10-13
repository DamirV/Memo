import QtQuick 2.15
import QtQuick.Controls 2.1

Page {
    id: root

    signal newGame
    signal continueGame
    signal settingsMenu
    signal leaderMenu

    function continueEnabled(value){
        _continue.enabled = value
    }

    Button{
       id: _newGame

       anchors.top: parent.top
       anchors.horizontalCenter: parent.horizontalCenter

       width: parent.width/2
       height: 50
       text: qsTr("New Game")

       onClicked: {
           root.newGame()
       }
    }

    Button{
        id: _continue

        enabled: false

        anchors.top: _newGame.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: _newGame.width
        height: 50

        text: qsTr("Continue")

        onClicked: {
            root.continueGame()
        }
    }

    Button{
        id: _leaderMenu

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: _continue.bottom

        width: _newGame.width
        height: 50

        text: qsTr("Leaderboard")

        onClicked: {
            root.leaderMenu()
        }
    }
}

