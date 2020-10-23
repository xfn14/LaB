function setup() {
    createCanvas(400, 400);
    angleMode(DEGREES);
}

function draw() { 
    //background(75);
    background(255);
    translate(200, 200);
    rotate(-90);

    let hours = hour();
    let minutes = minute();
    let seconds = second();

    strokeWeight(8);
    noFill();

    stroke(0, 0, 0);
    let seconds_angle = map(seconds, 0, 60, 0, 360);
    arc(0, 0, 300, 300, 0, seconds_angle);

    stroke(0, 170, 0);
    let minutes_angle = map(minutes, 0, 60, 0, 360);
    arc(0, 0, 280, 280, 0, minutes_angle);

    stroke(170, 0, 170);
    let hours_angle = map(hours % 12, 0, 12, 0, 360);
    arc(0, 0, 260, 260, 0, hours_angle);

    //fill(255);
    //noStroke();
    //text(hr + ":" + mn + ":" + sc, 10, 200);
}