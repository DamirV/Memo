import QtQuick 2.15
import QtQuick.Controls 2.1
import MyLeaderBoardModel 1.0

Page {
    id: root
    signal cancelSave
    signal createSave(string value)

    property int score
    property int level

    function startSave(currentScore, currentLevel){
        root.score = currentScore
        root.level = currentLevel
    }

    Button{
       id: _back

       anchors.left: parent.left
       anchors.top: parent.top

       width: 50
       height: 50

       text: qsTr("Back")

       onClicked: {
           root.cancelSave()
           _name.text = ""
       }
    }

    Button{
       id: _accept

       anchors.right: parent.right
       anchors.top: parent.top

       width: 50
       height: 50

       text: qsTr("Accept")

       onClicked: {
           root.createSave(_name.text + " " + root.level + "x" + root.level + ": " + root.score)
           _name.text = ""
       }
    }

    Rectangle{
        id: _rec
        anchors.left: _back.right
        anchors.top: parent.top
        width: parent.width - 100
        height: 50

        Label{
            id: _nameLabel
            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 18
            text: qsTr("Input your name: ")
        }

        TextField{
            id: _name
            anchors.centerIn: parent
            height: 50
            font.bold: true
            font.pixelSize: 30

            focus: true
        }
    }

    Rectangle{
        id: _someInfo

        anchors.top: _rec.bottom
        anchors.horizontalCenter : _rec.horizontalCenter
        anchors.topMargin: 12

        Label{
            id: _info
            anchors.centerIn: parent

            font.pointSize: 18
            text: qsTr("Difficulty level ") + root.level + "x" + root.level + qsTr(", score: ") +  root.score
        }
    }
}

