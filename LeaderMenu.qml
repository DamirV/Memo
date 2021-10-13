import QtQuick 2.15
import QtQuick.Controls 2.1
import MyLeaderBoardModel 1.0

Page {
    id: root
    signal back

    function createSave(value){
        _listView.model.addLeader(value)
    }

    Button{
       id: _back

       anchors.left: parent.left
       anchors.top: parent.top
       z: 1
       width: 50
       height: 50

       text: qsTr("Back")

       onClicked: {
           root.back()
       }
    }

    Rectangle{
        id: _board
        anchors.fill: parent

        ListView{
            id: _listView
            model: LeaderBoardModel{
                id: _model
            }

            anchors.fill: parent

            delegate: Item {
                id: item
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100
                height: 40

                Text {
                    anchors.fill: parent
                    anchors.margins: 2
                    font.pointSize: 25
                    text: display
                }
            }

        }
    }
}

