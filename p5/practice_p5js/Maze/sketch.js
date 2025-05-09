var rows, cols
var grid = []
var w = 10

var current

var stack = []

function setup() {
  createCanvas(400, 400);
  
  rows = floor(height / w)
  cols = floor(width / w)
  
  for (var j = 0; j < rows; j++){
    for (var i = 0; i < cols; i++){
      grid.push(new Cell(i,j))
    }
  }

  current = grid[0]
//   frameRate(5)
}

function draw() {
  background(55);
  for (var i =0; i < grid.length; i ++){
       grid[i].show()
  }

  current.visited = true
  current.highlight()

  // Step 1

  var next = current.checkNeighbors()

  if (next) {
     next.visited = true
     // Step 2
     stack.push(current)

     // Step 3
     removeWalls(current, next)

     // Step 4
     current = next;
  } else if (stack.length > 0) {
     current = stack.pop()
  }

//   for (var i =0; i < stack.length; i ++) {
//        fill(255, 0, 0)
//        rect(stack[i].i * w + w*0.1, stack[i].j * w + w*0.1, w * 0.8, w * 0.8)
//   }

}

function index(i,j){

     if (i < 0 ||  j < 0 || i > cols -1 || j > rows - 1){
          return -1;
     }

     return i + j * cols
}
class Cell {
     constructor(i, j) {
          this.i = i;
          this.j = j;
          this.walls = [true, true, true, true] // Top, Right, Bottom, Left
          this.visited = false

     }
     
     show() {
          var x = this.i * w;
          var y = this.j * w;
          stroke(255);
          if (this.walls[0]) {
               line(x, y, x + w, y);
          }
          if (this.walls[1]) {
               line(x + w, y, x + w, y + w);
          }
          if (this.walls[2]) {
               line(x + w, y + w, x, y + w);
          }
          if (this.walls[3]) {
               line(x, y + w, x, y);
          }
          
          if (this.visited){
               noStroke()
               fill(255, 0, 255, 100)
               rect(x, y, w, w)
          }

     }

     checkNeighbors(){
          var neighbors = []

          var top    = grid[index(this.i  , this.j-1)]
          var right  = grid[index(this.i+1, this.j)]
          var bottom = grid[index(this.i  , this.j+1)]
          var left   = grid[index(this.i-1, this.j)]

          if (top && !top.visited){
               neighbors.push(top)
          }
          
          if (right && !right.visited){
               neighbors.push(right)
          }
          
          if (bottom && !bottom.visited){
               neighbors.push(bottom)
          }
          
          if (left && !left.visited){
               neighbors.push(left)
          }

          if (neighbors.length> 0){
               var r = floor(random(0, neighbors.length))
               return neighbors[r]
          } else {
               return undefined
          }
     }

     highlight(){
          var x = this.i * w;
          var y = this.j * w;

          noStroke()
          fill(255,0, 255)
          rect(x, y, w, w)
     }


}

function removeWalls(a, b) {
     var x = a.i - b.i;

     if (x == 1){
          a.walls[3] = false
          b.walls[1] = false
     } else if (x == -1){
          a.walls[1] = false
          b.walls[3] = false
     } 

     var y = a.j - b.j;

     if (y == 1){
          a.walls[0] = false
          b.walls[2] = false
     } else if (y == -1){
          a.walls[2] = false
          b.walls[0] = false
     } 


}