.pragma library

function toIdx(row,col,gridSz){return (row*gridSz + col);}

// Magic Squares Algorithm
function makeMagicSquare(grid,gridSz){
    let n = 1;
    let row = Math.floor(gridSz/2), col = gridSz - 1;
    grid.itemAt(toIdx(row,col,gridSz)).magicNumber = n++;
    row--;col++;

    while(n <= gridSz*gridSz){
        // Magic square rules
        if (row === -1 && col === gridSz) {row = 0; col-=2; continue;}
        if (row < 0) {row = gridSz - 1; continue;}
        if (col === gridSz) {col = 0; continue;}
        if (grid.itemAt(toIdx(row,col,gridSz)).magicNumber > 0){row++; col-=2; continue;}

        // Populate the grid
        let cellIdx = toIdx(row,col,gridSz);
        grid.itemAt(cellIdx).magicNumber = n++;
        row--;col++;
    }
}

function isGameover(grid,gridSz){
    if (!gridSz) return false;
    let magicSum = (gridSz * (gridSz**2 + 1))/2
    let principal = 0, secondary = 0;
    // Initialize arrays to hold row and column sums
    let rowSums = new Array(gridSz).fill(0);
    let colSums = new Array(gridSz).fill(0);

    for (let row = 0; row < gridSz; row++)
    {
        for (let col = 0; col < gridSz; col++)
        {
            if(!grid.itemAt(toIdx(row,col,gridSz))) continue;
            let cell = grid.itemAt(toIdx(row,col,gridSz));
            if (!cell.isClicked) continue;
            let playerWeightedCellValue = (cell.occupyingPlayer + 1) * cell.magicNumber;
            rowSums[row] += playerWeightedCellValue;
            colSums[col] += playerWeightedCellValue;

            if (row === col)
                principal += playerWeightedCellValue;

            if ((row + col) === (gridSz - 1))
                secondary += playerWeightedCellValue;
        }
    }
    if(principal === magicSum || secondary === magicSum) {console.log("X wins"); return true;}
    if(principal === magicSum*2 || secondary === magicSum*2)  {console.log("O wins"); return true;}
    for(let idx = 0; idx<gridSz; idx++){
        let rowSum = rowSums[idx]
        let colSum = colSums[idx]
        if(rowSum === magicSum || colSum === magicSum)    {console.log("X wins"); return true;}
        if(rowSum === magicSum*2 || colSum === magicSum*2)  {console.log("O wins"); return true;}
    }

    return false;
}
