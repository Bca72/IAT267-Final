class ImageButton {

    int x, y;      // Position of square button
    PImage img;
    
    ImageButton(int x, int y, String imgPath) {      
        this.x = x;
        this.y = y;
        img = loadImage(imgPath);
    }
    ImageButton(int x, int y, int buttonWidth, int buttonHeight, String imgPath) {     
        this.x = x;
        this.y = y;
        img = loadImage(imgPath);
        img.resize(buttonWidth, buttonHeight);
    }
    
    void update() {
        drawButton();
    }
    
    void drawButton(){
        image(img, x, y);
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
