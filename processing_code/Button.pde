class Button {

    int x, y;      // Position of square button
    int buttonWidth, buttonHeight;     // size of button
    color rectColor;
    String label;

    Button(int x, int y, int buttonWidth, int buttonHeight, String label) {
        rectColor = color(225);
        this.x = x;
        this.y = y;
        this.buttonWidth = buttonWidth;
        this.buttonHeight = buttonHeight;
        this.label = label;
    }
    
    void update() {
        drawButton();
    
    }
    
    void drawButton(){
        fill(rectColor);
        rect(x, y, buttonWidth, buttonHeight);
        textSize(18);
        fill(0);
        text(label, width/2, y);
    }
        
    
    boolean mouseOver() {
        if (mouseX >= x && mouseX <= x+buttonWidth && mouseY >= y && mouseY <= y+buttonHeight) {
            return true;
        } 
        else {
            return false;
        }
    }
    
}
