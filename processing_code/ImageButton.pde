class ImageButton {

    int x, y;      // Position of square button
    int buttonWidth, buttonHeight;
    PImage img;
    
    ImageButton(int x, int y, String imgPath) {      
        this.x = x;
        this.y = y;
        img = loadImage(imgPath);
        buttonWidth = img.width;
        buttonHeight = img.height;
    }
    ImageButton(int x, int y, int buttonWidth, int buttonHeight, String imgPath) {     
        this.x = x;
        this.y = y;
        img = loadImage(imgPath);
        img.resize(buttonWidth, buttonHeight);
        this.buttonWidth = buttonWidth;
        this.buttonHeight = buttonHeight;
    }
    
    void update() {
        drawButton();
    }
    
    void drawButton(){
        image(img, x, y);
    }
        
    
    boolean mouseOver() {
        if (mouseX >= x && mouseX <= x+buttonWidth && mouseY >= y && mouseY <= y+buttonHeight) {
            return true;
        } 
        else {
            return false;
        }
    }
    
    void setImage(String imgPath) {
        img = loadImage(imgPath);   
    }
    
}
