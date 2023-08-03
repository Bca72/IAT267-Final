class Button {

    int rectX, rectY;      // Position of square button
    int rectWidth, rectHeight;     // Diameter of rect
    color rectColor;
    String label;

    Button(int x, int y, int buttonWidth, int buttonHeight, String label) {
        rectColor = color(225);
        rectX = x;
        rectY = y;
        rectWidth = buttonWidth;
        rectHeight = buttonHeight;
        this.label = label;
    }
    
    void update() {
        drawButton();
    
    }
    
    void drawButton(){
        fill(rectColor);
        rect(rectX, rectY, rectWidth, rectHeight);
        textSize(18);
        fill(0);
        text(label, width/2, rectY);
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
