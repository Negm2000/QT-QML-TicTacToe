import QtQuick

Window {
    property bool player: true
    visible: true
    visibility: "Maximized"
    title: qsTr("Tic Tac Toes: Player " + (player ? 1:2) + " turn");
    id: root
    color: "red"

    Grid {
        id: board
        property int gridSz: 5
        columns: gridSz
        rows: gridSz
        spacing: 2
        focus: true
        Keys.onEscapePressed: root.close()
        // Populate grid
        Repeater{
            model: board.gridSz * board.gridSz
            Rectangle {
                color: "#1c1c1c"
                width: root.width/board.gridSz; height: root.height/board.gridSz
                property bool isClicked: false
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        player = parent.isClicked? player : !player;
                        parent.isClicked = true
                    }
                }
                Text{
                    text: parent.isClicked? text : player? "O" : "X"
                    font.pixelSize: parent.width/2
                    anchors.centerIn: parent
                    color:"#C0C0C0";
                    visible: parent.isClicked
                }
            }
        }
    }
}
