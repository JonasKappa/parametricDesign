class CheckBox {
  boolean checked = false, over = false;
  PVector pos;
  float cb_width = 30, radius = 5, line_thickness = 4, line_offset = 6;
  String label;
  
  public CheckBox(PVector position, String label) {
    pos = position;
    this.label = label;
  }
  
  public CheckBox(PVector position, String label, boolean checked) {
    pos = position;
    this.label = label;
    this.checked = checked;
  }
  
  public void show() {
    if (over) fill(200);
    else fill(255);
     
    rect(pos.x, pos.y, cb_width, cb_width, radius);
    if (checked) {
      stroke(50);
      strokeWeight(line_thickness);
      
      float lo = line_offset;
      
      line(pos.x+lo, pos.y+lo, pos.x+cb_width-lo, pos.y+cb_width-lo);
      line(pos.x+lo, pos.y+cb_width-lo, pos.x+cb_width-lo, pos.y+lo);
      
      strokeWeight(1);
    }
    textSize(20);
    fill(230);
    textAlign(LEFT, CENTER);
    text(label, pos.x + cb_width + 8, pos.y + cb_width/2 - 4);
  }
  
  private boolean onCheckBox() {
    float mX = mouseX;
    float mY = mouseY;
    return (mX > pos.x && mX < pos.x + cb_width && mY > pos.y && mY < pos.y + cb_width);
  }
  
  public void update() {
    if (onCheckBox()) {
      over = true;
    } else {
      over = false;
    }
  }
  
  public void click() {
    if (over) checked = !checked; 
  }
  
  public boolean getValue() {
    return checked; 
  }
  
}
