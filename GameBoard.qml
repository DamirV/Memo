import QtQuick 2.0
import MyGameBoardModel 1.0

GridView {
    id: root

    model: GameBoardModel{
        id: _model
    }

    interactive: false

    cellWidth: width / root.model.dimension
    cellHeight: height / root.model.dimension

    delegate: Item{
        width: root.cellWidth
        height: root.cellHeight

       Card{
           id: _card
           status: statusTip

           width: root.cellWidth
           height: root.cellHeight

           MouseArea{
               id: _mouseArea
               anchors.fill: parent
               onClicked: {
                   root.model.onCardClicked(index)
                   //_anim.start()
               }
           }

           RotationAnimation on rotation {
                id: _anim
                target: _card
                running: false
                from: 0
                to: 360
                duration: 100
           }
       }
    }
}
