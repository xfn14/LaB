class Grape{
    constructor(){
        this.r = 100;
        this.x = 50;
        this.y = height - this.r;
        this.vy = 0;
        this.gravity = 0.7;
    }

    jump(){
        if(this.y == height - this.r){
            this.vy = -20;
        }
    }

    hits(larva){
        return collideRectRect(this.x, this.y, this.r, this.r, larva.x, larva.y, larva.r, larva.r);
    }

    move(){
        this.y += this.vy;
        this.vy += this.gravity;
        this.y = constrain(this.y, 0, height - this.r);
    }

    show(){
        image(grapeImg, this.x, this.y, this.r, this.r);
    }
}