import QtQuick 2.15
import QtQuick.Controls 2.1

Rectangle{
    id: root
    property int newWidth: 100
    property int score: 0
    property string scoreText: ""
    property bool saveButtonVisable: false

    signal back
    signal saveScore(int currentScore)

    width: newWidth
    height: _backButton.height

    Button{
        id: _backButton

        anchors.left: root.left

        height: 50
        width: 50

        text: qsTr("Back")

        onClicked: root.back()
    }

    Button{
        id: _saveButton
        visible: saveButtonVisable
        enabled: saveButtonVisable
        anchors.right: root.right

        height: 50
        width: 100

        text: qsTr("Save score")

        onClicked: {
            root.saveScore(score)
            saveButtonVisable = false
        }

    }

    Label{
        id: _scoreLabel
        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: 25
        text: root.scoreText
    }

    Label{
        id: _score
        anchors.left: _scoreLabel.right

        font.pointSize: 25
        text: root.score
    }
}
