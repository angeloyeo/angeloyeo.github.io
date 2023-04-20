let A = [],
     x = [],
     y = [],
     Ax = [],
     Ay = [];

let scl;
let extraCanvas;
// var myP;

function setup() {
     createCanvas(350, 350);
     extraCanvas = createGraphics(350, 350);
     // myP = createP('$$\\begin{bmatrix}0.25 & 0.75\\\\ 1 & 0.5\\end{bmatrix}$$');
     // myP.style('color','white')

     A = math.matrix([
          [0.25, 0.75],
          [1, 0.5]
     ])
     // A = math.matrix([[2, 1], [1, 2]])
     let xx = random(1) * 2 - 1;
     x = math.matrix([
          [xx],
          [sqrt(1 - xx * xx)]
     ])
     y = math.multiply([
          [0, -1],
          [1, 0]
     ], x) // 90도 양의 방향으로 회전한 것.

     scl = width / 4;
     extraCanvas.background(0)
     slider1 = createSlider(0, 2 * PI + 0.01, 0, 0.01);
     slider1.position(0, height + 10)

}

function draw() {
     background(0);
     x = math.matrix([
          [cos(slider1.value())],
          [sin(slider1.value())]])

     y = math.multiply(
          [
               [0, -1],
               [1, 0]
          ], x
     )

     image(extraCanvas, 0, 0)
     plotAxis();
     Ax = math.multiply(A, x);
     Ay = math.multiply(A, y)

     drawDots();
     drawArrow(0, 0, x._data[0][0], x._data[1][0], 66, 135, 245)
     drawArrow(0, 0, Ax._data[0][0], Ax._data[1][0], 245, 135, 66)
     
     drawArrow(0, 0, y._data[0][0], y._data[1][0], 66, 135, 245)
     drawArrow(0, 0, Ay._data[0][0], Ay._data[1][0], 245, 135, 66)

     textOnArrow();
     fill(255);
     textAlign(CENTER);
     textSize(12);
     text('Make Ax and Ay meet at right angles.', width / 2, height * 0.875)

     textSize(12)
     textAlign(RIGHT)
     text('(c) 공돌이의 수학정리노트', width * 0.95, height * 0.95)
     // myP.position(width * 0.8, height * 0.1)
}

function textOnArrow() {
     push();
     translate(width / 2, height / 2);
     // scale(1, -1)
     fill(255);
     textSize(13);
     text('x', x._data[0][0] * 0.5 * scl, -x._data[1][0] * 0.5 * scl);
     text('Ax', Ax._data[0][0] * 0.5 * scl, -Ax._data[1][0] * 0.5 * scl);

     text('y', y._data[0][0] * 0.5 * scl, -y._data[1][0] * 0.5 * scl);
     text('Ay', Ay._data[0][0] * 0.5 * scl, -Ay._data[1][0] * 0.5 * scl);
     pop();
}

function plotAxis() {
     push();
     stroke(200);
     strokeWeight(2);
     line(width / 2, 0, width / 2, height);
     line(0, height / 2, width, height / 2);
     pop();

     push();
     translate(width / 2, height / 2);
     scale(1, -1);
     stroke(150);
     strokeWeight(0.5);
     // vertical lines
     for (let i = -1; i <= 1; i++) {
          line(i * scl, -height / 2, i * scl, height / 2)
     }

     for (let i = -1; i <= 1; i++) {
          line(-width / 2, i * scl, width / 2, i * scl)
     }

     pop();

}

function drawArrow(x1, y1, x2, y2, c1, c2, c3) {
     push();
     translate(width / 2, height / 2)
     scale(1, -1)
     strokeWeight(2)
     stroke(c1, c2, c3);
     fill(c1, c2, c3)
     line(x1 * scl, y1 * scl, x2 * scl, y2 * scl); //draw a line beetween the vertices
     let offset = 16 / 480 * width

     let angle = atan2(y1 - y2, x1 - x2); //gets the angle of the line
     translate(x2 * scl, y2 * scl); //translates to the destination vertex
     rotate(angle - HALF_PI); //rotates the arrow point
     triangle(
          -offset * 0.5, offset,
          offset * 0.5, offset,
          0, 0); //draws the arrow point as a triangle
     pop();
}

function drawDots() {
     extraCanvas.push();
     extraCanvas.noStroke();
     extraCanvas.translate(width / 2, height / 2);
     extraCanvas.scale(1, -1)
     extraCanvas.fill(66, 135, 245)
     extraCanvas.ellipse(x._data[0][0] * scl, x._data[1][0] * scl, 3)
     extraCanvas.fill(245, 135, 66)
     extraCanvas.ellipse(Ax._data[0][0] * scl, Ax._data[1][0] * scl, 3)
     
     extraCanvas.fill(66, 135, 245)
     extraCanvas.ellipse(y._data[0][0] * scl, y._data[1][0] * scl, 3)
     extraCanvas.fill(245, 135, 66)
     extraCanvas.ellipse(Ay._data[0][0] * scl, Ay._data[1][0] * scl, 3)
     extraCanvas.pop();
}