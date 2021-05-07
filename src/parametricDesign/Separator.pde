class Separator {
  PVector pos;
  float s_length;
  
  public Separator(float x, float y, float l) {
    pos = new PVector(x,y);
    s_length = l;
  }
  
  public void show() {
    stroke(230);
    line(pos.x, pos.y, pos.x+s_length, pos.y);
  }
}
