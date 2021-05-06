class Button {
  float btn_width = 325, btn_height = 80, btn_radius = 5;
  PVector pos; // top left corner
  boolean over = false;
  String label = "";
  int label_size = 30;
  ICallback cb = null;
  
  public Button(PVector pos) {
    this.pos = pos;
  }
  
  public void setWidth(float w) {
    btn_width = w; 
  }
  
  public void setHeight(float h) {
    btn_height = h; 
  }
  
  public void setLabelSize(int s) {
    label_size = s; 
  }
  
  public void setLabel(String l) {
    this.label = l;
  }
  
  public void onClick(ICallback c) {
    this.cb = c; 
  }
  
  public void callOnClick() {
    if (over && this.cb != null) {
      this.cb.run(); 
    }
  }
  
  public void show() {
    // check if mouse is hovering over button
    if (over) {
      fill(200);
    } else {
      fill(255);
    }
    noStroke();
    rect(pos.x, pos.y, btn_width, btn_height, btn_radius);
    
    textSize(label_size);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, pos.x + btn_width/2, pos.y + btn_height/2);
  }
  
  public void update() {
    if (onButton()) {
      over = true;
    } else {
      over = false;
    }
  }
  
  private boolean onButton() {
    float mX = mouseX;
    float mY = mouseY;
    return (mX > pos.x && mX < pos.x + btn_width && mY > pos.y && mY < pos.y + btn_height);
  }
}
