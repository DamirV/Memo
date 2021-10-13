import QtQuick 2.15
import QtQuick.Controls 2.1

Window {
    id: root
    property int newDim

    width: 700
    height: 600
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

        onLeaderMenu: {
            _stackView.push(_leaderMenu)
        }

        onSettingsMenu: {
            _stackView.push(_settingsMenu)
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
            _mainMenu.continueEnabled(true)
        }

        onNewGame4x4: {
            root.newDim = 4
            _game.startNewGame(root.newDim)
            _stackView.push(_game)
            _mainMenu.continueEnabled(true)
        }

        onNewGame6x6: {
            root.newDim = 6
            _game.startNewGame(root.newDim)
            _stackView.push(_game)
            _mainMenu.continueEnabled(true)
        }
    }

    Game{
        id: _game
        visible: false
        anchors.fill: parent
        onBack: {
            _stackView.pop()
            _stackView.pop()
        }

        onEndGame: {
            _mainMenu.continueEnabled(false)
        }

        onSaveLeader: {
            _saveLeaderMenu.startSave(currentScore, level)
            _stackView.push(_saveLeaderMenu)
        }
    }

    SettingsMenu{
        id: _settingsMenu
        visible: false

        onBack: {
            _stackView.pop()
        }
    }

    LeaderMenu{
        id: _leaderMenu
        visible: false
        onBack: {
            _stackView.pop()
        }
    }

    SaveLeaderMenu{
        id: _saveLeaderMenu
        visible: false

        onCancelSave: {
            _stackView.pop()
            _stackView.pop()
            _stackView.pop()
        }

        onCreateSave: {
            _leaderMenu.createSave(value)

            _stackView.pop()
            _stackView.pop()
            _stackView.pop()
        }
    }

}
