import QtQuick 2.0
import MyModel 1.0

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
           status: statusTip

           width: root.cellWidth
           height: root.cellHeight

           MouseArea{
               anchors.fill: parent
               onClicked: {
                   root.model.onCardClicked(index)
               }
           }
       }
    }
}
