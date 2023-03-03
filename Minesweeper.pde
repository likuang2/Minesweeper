import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  mines = new ArrayList <MSButton>();
  // make the manager
  Interactive.make( this );
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int i = 0; i < buttons.length; i++)
  {
    for (int j = 0; j < buttons[i].length; j++)
    {
      buttons[i][j]= new MSButton(i, j);
    }
  }

  setMines();
}

public void setMines()
{
  for (int i = 0; i < 35; i++) {
    int randRow = (int)(Math.random() * 20);
    int randCol = (int)(Math.random() * 20);
    if (!mines.contains(buttons[randRow][randCol]))
    {
      mines.add(buttons[randRow][randCol]);
    }
    else {
      i--;
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int j = 0; j < NUM_COLS; j++) {
      if (buttons[i][j].clicked == false) {
        return false;
      }
    }
  }
  return true;
}

public void displayLosingMessage()
{
  //your code here

  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      if (!buttons[i][j].clicked&&mines.contains(buttons[i][j])) {
        buttons[i][j].flagged=false;
        buttons[i][j].clicked=true;
        buttons[9][5].setLabel("Y");
        buttons[9][6].setLabel("o");
        buttons[9][7].setLabel("u");
        buttons[9][8].setLabel(" ");
        buttons[9][9].setLabel("B");
        buttons[9][10].setLabel("o");
        buttons[9][11].setLabel("o");
        buttons[9][12].setLabel("m");
        buttons[9][13].setLabel("e");
        buttons[9][14].setLabel("d");
      }
    }
  }
}
public void displayWinningMessage()
{
  buttons[9][5].setLabel("Y");
  buttons[9][6].setLabel("o");
  buttons[9][7].setLabel("u");
  buttons[9][8].setLabel(" ");
  buttons[9][9].setLabel("W");
  buttons[9][10].setLabel("i");
  buttons[9][11].setLabel("n");
  buttons[9][12].setLabel("!");
  buttons[9][13].setLabel(":");
  buttons[9][14].setLabel("(");
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && r < NUM_ROWS && c < NUM_COLS && c >= 0) {
    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (isValid(row, col+1)&&mines.contains(buttons[row][col+1])) {
    numMines++;
  }
  if (isValid(row-1, col+1)&&mines.contains(buttons[row-1][col+1])) {
    numMines++;
  }
  if (isValid(row-1, col)&&mines.contains(buttons[row-1][col])) {
    numMines++;
  }
  if (isValid(row-1, col-1)&&mines.contains(buttons[row-1][col-1])) {
    numMines++;
  }
  if (isValid(row, col-1)&&mines.contains(buttons[row][col-1])) {
    numMines++;
  }
  if (isValid(row+1, col-1)&&mines.contains(buttons[row+1][col-1])) {
    numMines++;
  }
  if (isValid(row+1, col)&&mines.contains(buttons[row+1][col])) {
    numMines++;
  }
  if (isValid(row+1, col+1)&&mines.contains(buttons[row+1][col+1])) {
    numMines++;
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT)
    {
      if (flagged) {
        flagged = false;
        clicked = false;
      } else {
        flagged = true;
        
      }
   } else if (mines.contains(this))
      {
        displayLosingMessage();
      } if (countMines(myRow, myCol)>0)
      {
        setLabel(new String() + (countMines(myRow, myCol)));
      } else
      { 
        if (isValid(myRow, myCol-1) == true && buttons[myRow][myCol-1].clicked == false) {
          buttons[myRow][myCol-1].mousePressed();
        }
        if (isValid(myRow+1, myCol-1) == true && buttons[myRow+1][myCol-1].clicked == false) {
          buttons[myRow+1][myCol-1].mousePressed();
        }
        if (isValid(myRow+1, myCol) == true && buttons[myRow+1][myCol].clicked == false) {
          buttons[myRow+1][myCol].mousePressed();
        } 
        if (isValid(myRow+1, myCol+1) == true && buttons[myRow+1][myCol+1].clicked==false) {
          buttons[myRow+1][myCol+1].mousePressed();
        }  
        if (isValid(myRow, myCol+1) == true && buttons[myRow][myCol+1].clicked == false) {
          buttons[myRow][myCol+1].mousePressed();
        }
        if (isValid(myRow-1, myCol+1)== true && buttons[myRow-1][myCol+1].clicked == false) {
          buttons[myRow-1][myCol+1].mousePressed();
        }  
        if (isValid(myRow-1, myCol) == true && buttons[myRow-1][myCol].clicked == false) {
          buttons[myRow-1][myCol].mousePressed();
        }          
        if (isValid(myRow-1, myCol-1) == true && buttons[myRow-1][myCol-1].clicked == false) {
          buttons[myRow-1][myCol-1].mousePressed();
        }
      }
    }

    public void draw () 
    {    
      if (flagged)
        fill(0);
      else if ( clicked && mines.contains(this) ) 
        fill(255, 0, 0);
      else if (clicked)
        fill( 200 );
      else 
      fill( 100 );

      rect(x, y, width, height);
      fill(0);
      text(myLabel, x+width/2, y+height/2);
    }

    public void setLabel(String newLabel)
    {
      myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
      myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
      return flagged;
    }
  }
