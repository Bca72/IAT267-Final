class Button {

    int rectX, rectY;      // Position of square button
    int rectSize = 90;     // Diameter of rect
    color rectColor, textCol;
    color rectHighlight;
    boolean rectOver = false;
    String label;

    Button(int x, String label) {
        rectColor = color(0);
        textCol = color(255);
        rectHighlight = color(51);
        rectX = width/2-rectSize-x;
        rectY = height/2-rectSize/2;
        this.label = label;
    }
    
    void update() {
        if ( overRect(rectX, rectY, rectSize, rectSize) ) {
            rectOver = true;
        }
        else {
            rectOver = false;
        }
        
        if (rectOver) {
            fill(rectHighlight);
        } 
        else {
            fill(rectColor);
        }
        stroke(255);
        rect(rectX, rectY, rectSize, rectSize);
        textSize(18);
        fill(textCol);
        text(label, rectX+ 5, rectY+rectSize/2 + 5);
    
    }
    
    boolean overRect(int x, int y, int width, int height)  {
        if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
            return true;
        } 
        else {
            return false;
        }
    }
    
}
