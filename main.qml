import QtQuick 2.15
import QtQuick.Controls 2.1

Window {
    id: root
    property int newDim

    width: 640
    height: 480
    visible: true
    title: qsTr("Memo")

    StackView{
        id: _stackView
        anchors.fill: parent
        initialItem: _mainMenu
    }

    MainMenu{
        id: _mainMenu

        Component.onCompleted: {
            _mainMenu.continueEnabled(_game.checkSave())
        }

        onNewGame: {
            _stackView.push(_newGameMenu)
        }

        onContinueGame:{
            _game.continueGame()
            _stackView.push(_game)
        }
    }

    NewGameMenu{
        id: _newGameMenu
        visible: false

        onBack: {
            _stackView.pop()
        }

        onNewGame2x2: {
            root.newDim = 2
            _game.startNewGame(root.newDim)
            _stackView.push(_game)
        }

        onNewGame4x4: {
            root.newDim = 4
            _game.startNewGame(root.newDim)
            _stackView.push(_game)
        }

        onNewGame6x6: {
            root.newDim = 6
            _game.startNewGame(root.newDim)
            _stackView.push(_game)
        }
    }

    Game{
        id: _game
        visible: false

        onBack: {
            _stackView.pop()
            _stackView.pop()
        }
    }

}
