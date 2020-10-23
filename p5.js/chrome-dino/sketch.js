var canvas;

let grapeImg;
let backgroundImg;
let larvaImg;

let grape;
let larvas = [];

function preload(){
    grapeImg = loadImage('resources/grape.png');
    larvaImg = loadImage('resources/larva.png');
}

function setup(){
    let halfWindowWidth = windowWidth / 2;
    let halfWindowHeight = windowHeight / 2;
    
    canvas = createCanvas(1000, 500);
    canvas.position(halfWindowWidth - width / 2,  halfWindowHeight - height / 2);

    grape = new Grape();
}

function draw(){
    if(random(1) < 0.01){
        larvas.push(new Larva());
    }

    background(0);

    grape.show();
    grape.move();

    for(let larva of larvas){
        larva.show();
        larva.move();
        if(grape.hits(larva)){
            console.log('game over');
            noLoop();
        }
    }
}

function mousePressed(){
    grape.jump();
}

function keyPressed(){
    if(key == ' '){
        grape.jump();
    }
}
