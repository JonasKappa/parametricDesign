class Point {
  PVector pos,vel,acc,dest;
  boolean snap = true;
  int snap_distance = 1;
  float dest_mass = 1;
  float mass, G;
  
  public Point(PVector pos, float mass, float G) {
    this.mass = mass;
    this.G = G;
    this.pos = pos;
    this.vel = new PVector(0,0);
    this.acc = new PVector(0,0);
  }
  
  public void applyDestination(PVector dest) {
    if (snap) {
       PVector force = PVector.sub(dest,this.pos);
       this.vel = force;
       this.vel.setMag(this.vel.mag()*0.5);
    }
    this.dest = dest;
  }
  
  public void setSnap(boolean snap) {
    this.snap = snap; 
  }
  
  public void show(float size) {
    fill(255);
    ellipse(pos.x,pos.y,size,size);
    //fill(255,0,0);
    //noStroke();
    //ellipse(dest.x,dest.y,8,8);
  }
  
  public void update() {
    if (snap) {
      this.pos = this.dest; 
    } else {
      PVector force = PVector.sub(this.dest,this.pos);
      float distance = force.mag();
      if (distance < this.snap_distance) {
        this.snap_distance = 1;
        this.dest_mass = 100;
        this.snap = true;
        this.pos = this.dest;
        this.vel = force;
        this.vel.setMag(this.vel.mag()*1E-2);
      } else {
        this.snap_distance++;
        this.dest_mass++;
        //distance = constrain(distance, 5, 50);
        float strength = (this.G * dest_mass * this.mass * distance) * 1E-6;
        force.setMag(strength);
        PVector f = PVector.div(force, this.mass);
        this.acc.add(f);
        this.vel.add(this.acc);
        this.pos.add(this.vel);
      }
    }
    this.acc.mult(0);
  }
}
