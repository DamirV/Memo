import QtQuick 2.15
import QtQuick.Controls 2.1

Rectangle{
    id: root
    property int newWidth: 100
    property int score: 0
    property string mainText: ""
    signal back

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

    Label{
        id: _scoreLabel

        anchors.horizontalCenter: parent.horizontalCenter

        font.pointSize: 25
        text: root.mainText
    }

    Label{
        id: _score

        anchors.left: _scoreLabel.right

        font.pointSize: 25
        text: score
    }
}
