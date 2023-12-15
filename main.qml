import QtQuick
import QtQuick.Controls

Window {
    property bool player: true
    visible: true
    visibility: "Maximized"
    title: qsTr("Tic Tac Toes: Player " + (player ? 1:2) + " turn");
    id: root
    color: board.gridSz === 0 ? "#1C1C1C" : "red"

    Dialog {
        id: dialog
        title: "Select grid size"
        standardButtons: Dialog.Ok | Dialog.Cancel
        visible: true
        anchors.centerIn: parent
        height:240; width:480
        onAccepted: board.gridSz = optionSlider.value
        onRejected: board.gridSz = 3
        onClosed: board.makeMagicSquare(cells)

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
        readonly property int magicSum: (gridSz * (gridSz*gridSz + 1))/2
        columns: gridSz
        rows: gridSz
        spacing: 2
        focus: true
        Keys.onEscapePressed: root.close()

        function toIdx(row,col){return (row*gridSz + col);}

        // Magic Squares Algorithm
        function makeMagicSquare(grid){
            let n = 1;
            let row = Math.floor(gridSz/2), col = gridSz - 1;
            grid.itemAt(toIdx(row,col)).magicNumber = n++;
            row--;col++;

            while(n <= gridSz*gridSz){
                // Magic square rules
                if (row === -1 && col === gridSz) {row = 0; col-=2; continue;}
                if (row < 0) {row = gridSz - 1; continue;}
                if (col === gridSz) {col = 0; continue;}
                if (grid.itemAt(toIdx(row,col)).magicNumber > 0){row++; col-=2; continue;}

                // Populate the grid
                let cellIdx = toIdx(row,col);
                grid.itemAt(cellIdx).magicNumber = n++;
                row--;col++;
            }
        }

        // Create the grid
        Repeater {
            id: cells
            model: board.gridSz * board.gridSz
            Rectangle {
                color: "#1c1c1c"
                width: root.width/board.gridSz; height: root.height/board.gridSz
                property bool isClicked: false
                property bool occupyingPlayer: false // false is X, true is O
                property int magicNumber: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        player = parent.isClicked? player : !player;
                        parent.isClicked = true
                    }
                }

                Text {
                    text: parent.isClicked? text : player? "O" : "X"
                    onTextChanged: parent.occupyingPlayer = player
                    font.pixelSize: parent.width/2
                    anchors.centerIn: parent
                    color:"#C0C0C0";
                    visible: parent.isClicked
                }

                Text{
                    text: parent.magicNumber
                    anchors.fill: parent
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: parent.width/12
                    color: "#C0C0C0"
                }
            }
        }
    }
}

