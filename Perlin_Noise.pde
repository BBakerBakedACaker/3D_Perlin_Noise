/* Author: Brandon Baker
*
*
*  Purpose:
*  This project is to demonstrate a built in "Noise" function withing processing.
*  The noise function allows for a gradual transition between random values which 
*  will be visualized in 3D with this program.
*
*/

//Creating Global Variables for the Project.
//These variables can be accessed by other functions.
int cols, rows;
//This will create a size for the shapes that will make up the rows and columns.
int scale = 20;
//Global width and Height values for the grid that will be created. 
int w = 2000;
int h = 1600;

//This will allow the mesh to appear to move by shifting values towards the screen.
float move = 0;

//This is the grid 2D array.
float[][] grid;

//Function that initializes variables to be used in Project.
void setup()  {
  //Creating the size of the window.
  size(1000,800,P3D);
  
  //Creating the number of columns and rows and assigning that to the 2D grid array
  cols = w / scale;
  rows = h / scale;
  
  //Assigning the column and row values to the 2D grid array
  grid = new float[cols][rows];
}

//Function that enables you to add things to the screen.
void draw(){
  
  //This initializes the move variable to a negative value which 
  //will cause the grid to move towards the screen.
  move -= 0.01;
  
  //Setting y_offset equal to move. This will cause the origin point of the grid to constantly change
  //which causes the grid to appear to move towards you. 
  float y_offset = move;
    
  //Setting Background Color.
  background(79,91,102);
  
  //Setting color of the grid.
  stroke(192,197,206);
  
  //A built in function that causes the shape not to be filled in.
  noFill();
  
  //Moving the top left corner of the grid to the middle of the screen.
  translate(width/2,height/2);
  
  //Rotating about the x axis. 
  //This causes the grid to tilt and look 3D.
  rotateX(PI/3);
  
  //Moving the grid back to center after rotating about the x axis. 
  translate(-w/2,-h/2);
  
  //This loop creates the grid with the colums and rows and adds it to the screen. 
  for(int y = 0; y < rows - 1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++){
      vertex(x*scale, y*scale, grid[x][y]);
      vertex(x*scale, (y+1)*scale, grid[x][y+1]);
    }
    endShape();
  }
  
  //This loop will implement 3D Perlin noise, which is a gradual function based on previous values. 
  //This will cause the grid to look like it is moving towards you because the y_offset value is
  //changing constnatly which causes the origin point to shift.
  for(int y = 0; y < rows; y++){
    float x_offset = 0;
    for(int x = 0; x < cols; x++){
      grid[x][y] = map(noise(x_offset,y_offset), 0, 1, -150, 150);
      x_offset += 0.1;
    }
    y_offset += 0.1;
  }
}
