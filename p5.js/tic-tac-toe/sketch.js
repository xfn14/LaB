var resetButton;
var canvas;
var resultText;


let board = [
  ['', '', ''],
  ['', '', ''],
  ['', '', '']
];

let w;
let h;

let ai = 'X';
let human = 'O';
let currentPlayer = human;

function setup() {
    resetButton = createButton('RESET', 5);
    canvas = createCanvas(400, 400);
    resultText = createP('');

    w = width / 3;
    h = height / 3;

    resetButton.mouseReleased(reset);

    randomPlayer = floor(random(2));
    currentPlayer = (randomPlayer == 0) ? human : ai;
    if(currentPlayer == ai) playAI();
}

function reset(){
    board = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
    ];

    randomPlayer = floor(random(2));
    currentPlayer = (randomPlayer == 0) ? human : ai;
    resultText.html('');
    loop();
    if(currentPlayer == ai) playAI();
    console.log(randomPlayer);
    console.log(currentPlayer);
}

function win_line(l1, l2, l3){
    return l1 == l2 && l2 == l3 && l3 != '';
}
  
function checkWinner(){
    let winner = null;
  
    // Horizontal
    for(let i = 0; i < 3; i++){
        if(win_line(board[i][0], board[i][1], board[i][2])){
            winner = board[i][0];
        }
    }
  
    // Vertical
    for(let i = 0; i < 3; i++){
        if(win_line(board[0][i], board[1][i], board[2][i])){
            winner = board[0][i];
        }
    }
  
    // Diagonal
    if (win_line(board[0][0], board[1][1], board[2][2])) {
        winner = board[0][0];
    }else if (win_line(board[2][0], board[1][1], board[0][2])) {
        winner = board[2][0];
    }

    let openSpots = 0;
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (board[i][j] == '') {
                openSpots++;
            }
        }
    }
  
    if (winner == null && openSlots() == 0) {
        return 'tie';
    } else {
        return winner;
    }
}

function openSlots(){
    let openSpots = 0;
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (board[i][j] == '') {
                openSpots++;
            }
        }
    }
    return openSpots;
}

function mousePressed() {
    if (currentPlayer == human) {
        let x = floor(mouseX / w);
        let y = floor(mouseY / h);
  
        // Check valid spot
        if(x < 0 || x > 2 || y < 0 || y > 2) return;
        if (board[x][y] == '') {
            board[x][y] = human;
            currentPlayer = ai;
            if(openSlots() == 0) return;
            playAI();
        }
    }
}

function draw() {
    background(255);
    strokeWeight(4);

    line(w, 0, w, height);
    line(w * 2, 0, w * 2, height);
    line(0, h, width, h);
    line(0, h * 2, width, h * 2);

    for (let j = 0; j < 3; j++) {
        for (let i = 0; i < 3; i++) {
            let x = w * i + w / 2;
            let y = h * j + h / 2;
            let spot = board[i][j];
            textSize(32);
            let r = w / 4;
            if (spot == human) {
                noFill();
                ellipse(x, y, r * 2);
            } else if (spot == ai) {
                line(x - r, y - r, x + r, y + r);
                line(x + r, y - r, x - r, y + r);
            }
        }
    }

    let result = checkWinner();
    if (result != null) {
        noLoop();
        resultText.style('font-size', '32pt');
        if (result == 'tie') {
            resultText.html('Tie!');
        } else {
            resultText.html(`${result} wins!`);
        }
    }
}