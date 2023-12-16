import QtQuick
import QtQuick.Controls
import "grid_functions.js" as GridFuncs
Window {
    property bool player: true // true = X, false =  O
    visible: true
    visibility: "Maximized"
    title: "Tic Tac Toes: Player " + (player ? "X":"O") + " turn"
    id: root
    color: "red"

    Dialog {
        id: gameover
        title: "Winner Winner Chicken Dinner"
        standardButtons: Dialog.Ok
        visible: GridFuncs.isGameover(cells,board.gridSz)
        anchors.centerIn: parent
        height:240; width:480
        onAccepted: root.close()
        modal: true
        Overlay.modal: Rectangle {
            color: "#1C1C1C"
        }
        Text {
            text: (player? "O": "X") + " Wins!"
            font.pixelSize: parent.width/5
            font.family: "Roboto"
            font.bold: true
            anchors.centerIn: parent
        }
    }

    Dialog {
        id: dialog
        title: "Grid Size"
        standardButtons: Dialog.Ok | Dialog.Cancel
        visible: true
        anchors.centerIn: parent
        height:240; width:480
        onAccepted: board.gridSz = optionSlider.value
        onRejected: board.gridSz = root.close()
        onClosed: GridFuncs.makeMagicSquare(cells,board.gridSz)
        modal: true
        Overlay.modal: Rectangle {
            color: "#1C1C1C"
        }

        Slider {
            id: optionSlider
            from: 3
            to: 21
            value:3
            anchors.centerIn: parent
            stepSize: 2
            width: dialog.width/1.5
        }

        Text {
            text: optionSlider.value + "x" + optionSlider.value
            font.pixelSize: dialog.width/32
            anchors.left: optionSlider.right
            anchors.top: optionSlider.bottom
        }
    }

    Grid {
        id: board
        property int gridSz: 0
        property bool isGameOver: false
        columns: gridSz
        rows: gridSz
        spacing: 2
        focus: true
        Keys.onEscapePressed: root.close()


        // Create the grid
        Repeater {
            id: cells
            model: board.gridSz**2
            Rectangle {
                property bool isClicked: false
                property bool occupyingPlayer: false // false is X, true is O
                property int magicNumber: 0
                color: "#1c1c1c"
                width: root.width/board.gridSz; height: root.height/board.gridSz

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        player = parent.isClicked? player : !player;
                        parent.isClicked = true
                    }
                }


                Text{
                    text: parent.magicNumber
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: parent.width/12
                    color: "#C0C0C0"
                }

                Text {
                    text: parent.isClicked? text : player? "O" : "X"
                    onTextChanged: {
                        parent.occupyingPlayer = player;
                    }
                    font.pixelSize: parent.width/2
                    anchors.centerIn: parent
                    color:"#C0C0C0";
                    visible: parent.isClicked

                }

            }
        }
    }
}

