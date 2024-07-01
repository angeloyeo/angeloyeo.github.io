var scl
var vertices_original = [[]]
var faces = [[]]
var tex
var signature
var texVol
var texVolReal

var slider11
var slider12
var slider13
var slider21
var slider22
var slider23
var slider31
var slider32
var slider33

var img
var mtx = [[]]
var permute_mtx = [[]]
var myFont

function preload(){
     img = loadImage('https://raw.githubusercontent.com/antimatter15/cameraman/master/cameraman.png')
     myFont = loadFont('https://fonts.gstatic.com/s/roboto/v30/KFOmCnqEu92Fr1Mu4mxM.woff');

}
function setup() {
     createCanvas(320, 320, WEBGL);
     setAttributes('antialias', true)
     // my function
     vertices_original = [
          [-1, -1, -1], // Vertex 1
          [1, -1, -1],  // Vertex 2
          [1, 1, -1],   // Vertex 3
          [-1, 1, -1],  // Vertex 4
          [-1, -1, 1],  // Vertex 5
          [1, -1, 1],   // Vertex 6
          [1, 1, 1],    // Vertex 7
          [-1, 1, 1]    // Vertex 8
     ]

     faces = [
          [1, 2, 3, 4],  // Face 1
          [2, 6, 7, 3],  // Face 2
          [5, 1, 4, 8],  // Face 3
          [4, 3, 7, 8],  // Face 4
          [5, 6, 2, 1],   // Face 5
          [6, 5, 8, 7],  // Face 6 Top
          ]

     scl = width / 8

     // 글씨 쓰기
     // tex = createP()
     // tex.style('font-size', '15px')
     // tex.position(width/4, 0)
     // katex.render('f(x,y) = 4 - x^2 - y^2', tex.elt)

     slider11 = createSlider(0, 2, 1, 0.1)
     slider12 = createSlider(-2, 2, 0, 0.1)
     slider13 = createSlider(-2, 2, 0, 0.1)
     slider21 = createSlider(-2, 2, 0, 0.1)
     slider22 = createSlider(0, 2, 1, 0.1)
     slider23 = createSlider(-2, 2, 0, 0.1)
     slider31 = createSlider(-2, 2, 0, 0.1)
     slider32 = createSlider(-2, 2, 0, 0.1)
     slider33 = createSlider(0, 2, 1, 0.1)

     slider11.size(80)
     slider12.size(80)
     slider13.size(80)
     slider21.size(80)
     slider22.size(80)
     slider23.size(80)
     slider31.size(80)
     slider32.size(80)
     slider33.size(80)

     slider11.position(0, height)
     slider12.position(width/3, height)
     slider13.position(2*width/3, height)
     slider21.position(0, height + 15)
     slider22.position(width/3, height + 15)
     slider23.position(2*width/3, height + 15)
     slider31.position(0, height + 30)
     slider32.position(width/3, height + 30)
     slider33.position(2*width/3, height + 30)


     // 서명 쓰기
     signature = createP()
     signature.style('font-size', '10px')
     signature.position(width*0.7, height*0.88)
     katex.render('(c) 공돌이의 수학정리노트', signature.elt)
     
     tex = createSpan()
}


function draw() {
     background(255);
     // orbitControl()
     // scale(1, -1)
     rotateX(PI/4)
     // rotateZ(-millis()/5000)
     rotateZ(PI/4)

     plotAxes()

     mtx = math.matrix([
          [slider11.value(), -slider12.value(), slider13.value()],
          [-slider21.value(), slider22.value(), -slider23.value()],
          [slider31.value(), -slider32.value(), slider33.value()]
     ])
     let str_mtx = 
     'A = \\begin{bmatrix} ' + slider11.value() + ' & ' + slider12.value() + ' & ' + slider13.value() + 
     '\\\\'  + slider21.value() + ' & ' + slider22.value() + ' & ' + slider23.value() + 
     '\\\\'  + slider31.value() + ' & ' + slider32.value() + ' & ' + slider33.value() + 
     ' \\end{bmatrix}'
     
     tex.style('font-size', '15px')
     tex.position(width * 2/ 3, 0)
     katex.render(str_mtx , tex.elt)
     // mtx = math.matrix([
     //      [2, 1, 0],
     //      [1, 2, 0],
     //      [0, 0, 1]
     // ])
     // mtx._data[0][1] = -1 * mtx._data[0][1]
     // mtx._data[1][0] = -1 * mtx._data[1][0]
     // mtx._data[1][2] = -1 * mtx._data[1][2]
     // mtx._data[2][1] = -1 * mtx._data[2][1]
     // mtx = math.multiply(mtx, permute_mtx)

     vertices_original_transposed = math.transpose(vertices_original)
     let vertices_new = math.transpose(math.multiply(mtx, vertices_original_transposed))
     vertices_new = vertices_new.toArray()
     plotTheBox(vertices_new)

}

function plotTheBox(vertices){
     my_color = color(100, 50, 100);
     my_color.setAlpha(50)
     fill(my_color)
     stroke(0)
     // noStroke()

     for(var idx_faces = 0; idx_faces < faces.length-1; idx_faces++){
          let temp = faces[idx_faces] // [1, 2, 3, 4]
          beginShape() 
          for (var idx_vertices = 0; idx_vertices < 4; idx_vertices++){
               let k = temp[idx_vertices]
               let x = vertices[k-1][0]
               let y = vertices[k-1][1]
               let z = vertices[k-1][2]
               vertex(x*scl, y*scl, z*scl)
          }
          endShape(CLOSE)
     }
     push()
     // 뚜껑은 그림으로 대체
     texture(img)
     textureMode(NORMAL)
     let temp = faces[faces.length-1]
     let temp2 = [ // img warping에 사용
          [0, 0],
          [1, 0],
          [1, 1],
          [0, 1]
     ]
     beginShape() 
     for (var idx_vertices = 0; idx_vertices < 4; idx_vertices++){
          let k = temp[idx_vertices]
          let x = vertices[k-1][0]
          let y = vertices[k-1][1]
          let z = vertices[k-1][2]
          vertex(x*scl, y*scl, z*scl, temp2[idx_vertices][0], temp2[idx_vertices][1])
     }
     endShape(CLOSE)
     pop()

}

function linspace(stt, end, steps){
     var res = []
     for(i=stt; i<=end; i+=((end-stt)/(steps-1))){
          res.push(
               i
          )
     }
     res.push(end)
     return res
}

function plotAxes(){
     let stt = -3
     let end = 3

     push()

     stroke(0)
     // x axis
     line(stt * scl, 0, 0, end * scl, 0, 0)
     // y axis
     line(0, stt * scl, 0, 0, end * scl, 0)
     // z axis
     line(0, 0, -3 * scl, 0, 0, 3 * scl)
     fill(0)
     textFont(myFont);

     // xtick 그려주기
     for(let i = stt; i<=end; i++){
          line(i * scl, -0.1 * scl, 0, i * scl, 0.1 * scl, 0)
          text(i, i * scl, 0.3 * scl);
     }
     text('x-axis', 2.5 * scl, -0.3*scl)
     // ytick 그려주기
     for(let i = stt; i<=end; i++){
          line(-0.1 * scl, i * scl, 0, 0.1 * scl, i * scl, 0)
          text(-i, 0.3 * scl, i * scl);
     }
     text('y-axis', 0.3*scl, -2.5*scl)
     // ztick 그려주기
     for(let i = stt; i<=end; i++){
          line(-0.1 * scl, 0, i*scl, 0.1 * scl, 0, i*scl)
          // push()
          // translate(0, 0, i * scl)
          // text(i, 0.3 * scl, 0.3 * scl);
          // pop()
     }
     pop()
}

