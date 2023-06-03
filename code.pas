# pascal-sudoky
program SudokuSolver;

const
  SIZE = 9;

type
  Grid = array[1..SIZE, 1..SIZE] of Integer;

var
  SudokuGrid: Grid;

procedure InitializeGrid;
var
  i, j: Integer;
begin
  for i := 1 to SIZE do
    for j := 1 to SIZE do
      SudokuGrid[i, j] := 0;
end;

procedure PrintGrid;
var
  i, j: Integer;
begin
  for i := 1 to SIZE do
  begin
    for j := 1 to SIZE do
      write(SudokuGrid[i, j], ' ');
    writeln;
  end;
end;

function IsValidMove(num, row, col: Integer): Boolean;
var
  i, j, startRow, startCol: Integer;
begin
  // Check if the number already exists in the row
  for j := 1 to SIZE do
    if SudokuGrid[row, j] = num then
      Exit(False);
  
  // Check if the number already exists in the column
  for i := 1 to SIZE do
    if SudokuGrid[i, col] = num then
      Exit(False);
  
  // Check if the number already exists in the 3x3 grid
  startRow := (row - 1) div 3 * 3 + 1;
  startCol := (col - 1) div 3 * 3 + 1;
  
  for i := startRow to startRow + 2 do
    for j := startCol to startCol + 2 do
      if SudokuGrid[i, j] = num then
        Exit(False);
  
  // If all checks pass, the move is valid
  Exit(True);
end;

function SolveSudoku: Boolean;
var
  row, col, num: Integer;
begin
  for row := 1 to SIZE do
    for col := 1 to SIZE do
      if SudokuGrid[row, col] = 0 then
      begin
        for num := 1 to SIZE do
        begin
          if IsValidMove(num, row, col) then
          begin
            SudokuGrid[row, col] := num;
            
            if SolveSudoku then
              Exit(True);
            
            SudokuGrid[row, col] := 0;  // Backtrack
          end;
        end;
        
        Exit(False);  // No valid number found
      end;
  
  Exit(True);  // All cells are filled
end;

begin
  InitializeGrid;
  
  // Fill in your Sudoku grid here (0 for empty cells)
  // Example:
  SudokuGrid[1, 1] := 5;
  SudokuGrid[1, 2] := 3;
  // ...
  
  writeln('Sudoku grid:');
  PrintGrid;
  
  if SolveSudoku then
  begin
    writeln('Solved Sudoku:');
    PrintGrid;
  end
  else
    writeln('No solution found.');
  
  readln;
end.
