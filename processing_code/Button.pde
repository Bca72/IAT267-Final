class Button {

    int rectX, rectY;      // Position of square button
    int rectWidth, rectHeight;     // Diameter of rect
    color rectColor, textCol;
    color rectHighlight;
    boolean rectOver = false;
    String label;

    Button(int x, int y, int buttonWidth, int buttonHeight, String label) {
        rectColor = color(0);
        textCol = color(255);
        rectHighlight = color(55);
        rectX = x;
        rectY = y;
        rectWidth = buttonWidth;
        rectHeight = buttonHeight;
        this.label = label;
    }
    
    void update() {
        if ( overRect(rectX, rectY, rectWidth, rectHeight) ) {
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
        drawButton();
    
    }
    
    void drawButton(){
        stroke(255);
        rect(rectX, rectY, rectWidth, rectHeight);
        textSize(18);
        fill(textCol);
        text(label, rectX+ 5, rectY+rectWidth/2 + 5);
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
