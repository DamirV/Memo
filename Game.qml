import QtQuick 2.15
import QtQuick.Controls 2.1

Page{
    id: root

    signal back
    signal endGame
    signal saveLeader(int currentScore, int level)

    visible: true
    title: qsTr("Memo")

    function startNewGame(_newDim){
        _gameInfo.scoreText = qsTr("Score: ")
        _gameBoard.model.generateModel(_newDim)
    }

    function continueGame(){
        _gameBoard.model.loadGame()
    }

    function checkSave(){
        return _gameBoard.model.checkSave()
    }

    GameInfo{
        id: _gameInfo
        newWidth: parent.width
        anchors.top: parent.top

        score: _gameBoard.model.score

        onBack: {
            root.back()
            _gameInfo.scoreText = qsTr("Score: ")
            _gameInfo.saveButtonVisable = false
            _gameBoard.model.saveGame()
        }

        onSaveScore: {
            saveLeader(currentScore, _gameBoard.model.dimension)
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
            _gameInfo.scoreText = qsTr("The game is over, your score: ")
            _gameInfo.saveButtonVisable = true
            root.endGame()
        }
    }
}
