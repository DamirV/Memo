import QtQuick 2.15
import QtQuick.Controls 2.1

Page{
    id: root

    signal back

    width: 640
    height: 480
    visible: true
    title: qsTr("Memo")

    function startNewGame(_newDim){
        _gameInfo.mainText = qsTr("Score: ")
        _gameBoard.startNewGame(_newDim)
    }

    GameInfo{
        id: _gameInfo
        newWidth: parent.width
        anchors.top: parent.top

        score: _gameBoard.model.score

        onBack: {
            root.back()
            _gameInfo.endGameText = qsTr("Score: ")
        }
    }

    GameBoard{
        id: _gameBoard
        anchors.fill: parent
        anchors.topMargin: _gameInfo.height

        Component.onCompleted: {
            _gameBoard.model.endGame.connect(endGame)
        }

        function endGame() {
            console.log("end game")
            _gameInfo.mainText = qsTr("The game is over, your score: ")
        }
    }
}
