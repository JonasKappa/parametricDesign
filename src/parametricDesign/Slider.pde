class Slider {
  float slider_width = 60, slider_height = 20, value, posx, posy, xoff;
  float min, max;
  boolean continuos = true;
  PVector start, end;
  boolean over = false, locked = false;
  String name;
  
  public Slider(float s, float e, float y, float min, float max, float val, String n) {
    name = n;
    start = new PVector(s,y);
    end = new PVector(e,y);
    value = val;
    this.min = min;
    this.max = max;
    posx = getXofValue() - slider_width / 2;
    posy = start.y - slider_height / 2;
  }
  
  public Slider(float s, float e, float y, float min, float max, float val, String n, boolean c) {
    name = n;
    start = new PVector(s,y);
    end = new PVector(e,y);
    value = val;
    this.min = min;
    this.max = max;
    posx = getXofValue() - slider_width / 2;
    posy = start.y - slider_height / 2;
    continuos = c;
  }
  
  public float getValue() {
    return value; 
  }
  
  public void setValue(float value) {
    this.value = value;
  }
  
  private float getXofValue() {
    return start.x + value * (end.x - start.x) / max;
  }
  
  private void XtoValue(float x) {
    value = constrain(((x - start.x)*max)/(end.x-start.x),min,max);
    if (!continuos) {
      value = round(value); 
    }
  }
  
  public void show() {
    // line
    fill(0);
    stroke(0);
    line(start.x,start.y,end.x,end.y);
    // check if mouse is hovering over slider
    if (over) {
      fill(200);
    } else {
      fill(255);
    }
    // slider
    rect(posx, posy, slider_width, slider_height);
    
    // min and max
    textSize(16);
    fill(230);
    textAlign(RIGHT, CENTER);
    text((int)max, end.x, end.y+slider_height);
    textAlign(LEFT, CENTER);
    text((int)min, start.x, start.y+slider_height);
    
    // name and value
    String v = ""+value;
    if (!continuos) {
      v = ""+(int)value;
    }
    text(name + ": "+v, start.x, start.y-slider_height - 4);
  }
  
  private void update() {
    if (!locked) {
      if (onSlider()) {
        over = true;
      } else {
        over = false;
      }
    }
    posx = getXofValue() - slider_width / 2;
  }
  
  private boolean onSlider() {
    float mX = mouseX;
    float mY = mouseY;
    return (mX > posx && mX < posx + slider_width && mY > posy && mY < posy + slider_height);
  }
  
  public void onMousePressed() {
    if (over) {
      locked = true; 
      xoff = mouseX - getXofValue();
    }
  }
  
  public void onMouseDragged() {
    if (locked) {
      XtoValue(mouseX-xoff);
    }
  }
  
  public void onMouseReleased() {
    locked = false; 
  }
}
