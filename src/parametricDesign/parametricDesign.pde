int w = 1500;
int h = 1500;

// Gen Des Loop
int globalX = 0;

// parametrics init
int transparency = 20;
int fillOfBackground = 100;
float xMultiplier1 = 0.001;
float xMultiplier2 = 0.0001;
float xMultiplier3 = 0.00002;
float xMultiplier4 = 0.01;
float yMultiplier1 = 0.001;
float yMultiplier2 = 0.0001;
float yMultiplier3 = 0.00002;
float yMultiplier4 = 0.01;
int pointAmt = 1;
int pointSize = 20;
float randomTimeIncrementor = 20;

// Sliders
Slider transparencySlider;
Slider fillOfBackgroundSlider;
Slider xMultiplier1Slider;
Slider xMultiplier2Slider;
Slider xMultiplier3Slider;
Slider xMultiplier4Slider;
Slider yMultiplier1Slider;
Slider yMultiplier2Slider;
Slider yMultiplier3Slider;
Slider yMultiplier4Slider;
Slider pointAmtSlider;
Slider pointSizeSlider;
Slider randomTimeIncrementorSlider;

// Buttons
Button saveParams;
Button loadParams;
Button getRandomParams;
Button resetLoop;

// CheckBoxes
CheckBox randomMode;
CheckBox randomModeWithoutBackground;

// Separators
Separator separator;

// UI Lists
ArrayList<Slider> sliders = new ArrayList<Slider>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<CheckBox> checkBoxes = new ArrayList<CheckBox>();
ArrayList<Separator> separators = new ArrayList<Separator>();

// savings
JSONObject toSave;

void setup() {
  size(2300,1500);
  // set UI
  setupUI();
}

void draw() {
  // Gen Design
  fill(fillOfBackgroundSlider.getValue(),transparencySlider.getValue());
  noStroke();
  rect(0,0,w,h);
  
  stroke(255);
  // generation of the parametric design x,y values
  ArrayList<PVector> points = new ArrayList<PVector>();
  float amt = pointAmtSlider.getValue();
  for (int i = 1; i <= w; i += (w/amt)) {
    float x = sin(millis()*xMultiplier1Slider.getValue()+(i*xMultiplier4Slider.getValue())+globalX*xMultiplier2Slider.getValue()*sin(millis()*xMultiplier3Slider.getValue())) * w/2 + w/2;
    float y = sin(millis()*yMultiplier1Slider.getValue()+(i*yMultiplier4Slider.getValue())+x*yMultiplier2Slider.getValue()*sin(millis()*yMultiplier3Slider.getValue())) * h/2 + h/2;
    points.add(new PVector(x,y));
  }
  // draw ellipses
  fill(255);
  float size = pointSizeSlider.getValue();
  for (PVector p : points) {
    ellipse(p.x,p.y,size,size);
  }
  // increase global loop
  globalX += 1;
  
  // update random parameters
  if (randomMode.getValue() && globalX % randomTimeIncrementorSlider.getValue() == 0) {
     randomizeParameters();
  }
  
  // UI Background
  fill(100);
  noStroke();
  rect(w,0,width,h);
  // UI update
  for (Slider s : sliders) {
    s.update();
  }
  for (Button b : buttons) {
    b.update();
  }
  for (CheckBox c : checkBoxes) {
    c.update(); 
  }
  // UI show
  for (Slider s : sliders) {
    s.show();
  }
  for (Button b : buttons) {
    b.show();
  }
  for (CheckBox c : checkBoxes) {
    c.show(); 
  }
  for (Separator s : separators) {
    s.show(); 
  }
}

void mousePressed() {
  // UI
  for (Slider s : sliders) {
    s.onMousePressed();
  }
  for (Button b : buttons) {
    b.callOnClick();
  }
  for (CheckBox c : checkBoxes) {
    c.click(); 
  }
}

void mouseDragged() {
  // UI
  for (Slider s : sliders) {
    s.onMouseDragged();
  }
}

void mouseReleased() {
  // UI
  for (Slider s : sliders) {
    s.onMouseReleased();
  }
}

void setupUI() {
  // Sliders
  
  transparencySlider = new Slider(w+50, w+750, 75, 0, 100, transparency,"Transparency of Background", false);
  fillOfBackgroundSlider = new Slider(w+50, w+750, 165, 0, 200, fillOfBackground,"Fill of Background", false);
  xMultiplier1Slider = new Slider(w+50, w+750, 255, 0, 0.01, xMultiplier1,"x-Multiplier 1");
  xMultiplier2Slider = new Slider(w+50, w+750, 345, 0, 0.001, xMultiplier2,"x-Multiplier 2");
  xMultiplier3Slider = new Slider(w+50, w+750, 435, 0, 0.001, xMultiplier3,"x-Multiplier 3");
  xMultiplier4Slider = new Slider(w+50, w+750, 525, 0, 0.02, xMultiplier4,"x-Multiplier 4");
  yMultiplier1Slider = new Slider(w+50, w+750, 615, 0, 0.01, yMultiplier1,"y-Multiplier 1");
  yMultiplier2Slider = new Slider(w+50, w+750, 705, 0, 0.001, yMultiplier2,"y-Multiplier 2");
  yMultiplier3Slider = new Slider(w+50, w+750, 795, 0, 0.001, yMultiplier3,"y-Multiplier 3");
  yMultiplier4Slider = new Slider(w+50, w+750, 885, 0, 0.02, yMultiplier4,"y-Multiplier 4");
  pointAmtSlider = new Slider(w+50, w+750, 975, 1, 100, pointAmt,"Amount of points",false);
  pointSizeSlider = new Slider(w+50, w+750, 1065, 1, 50, pointSize,"Size of points",false);
  randomTimeIncrementorSlider = new Slider(w+50, w+750, 1300, 1, 1000, randomTimeIncrementor,"Number of Frames for random Parameters",false);
  
  sliders.add(transparencySlider);
  sliders.add(fillOfBackgroundSlider);
  sliders.add(xMultiplier1Slider);
  sliders.add(xMultiplier2Slider);
  sliders.add(xMultiplier3Slider);
  sliders.add(xMultiplier4Slider);
  sliders.add(yMultiplier1Slider);
  sliders.add(yMultiplier2Slider);
  sliders.add(yMultiplier3Slider);
  sliders.add(yMultiplier4Slider);
  sliders.add(pointAmtSlider);
  sliders.add(pointSizeSlider);
  sliders.add(randomTimeIncrementorSlider);
  
  // CheckBoxes
  
  randomMode = new CheckBox(new PVector(w+50,1225),"Random Mode");
  randomModeWithoutBackground = new CheckBox(new PVector(w+50,1225),"w/o Background");
  
  checkBoxes.add(randomMode);
  
  // Buttons
  
  saveParams = new Button(new PVector(w+50,1370));
  loadParams = new Button(new PVector(w+425,1370));
  getRandomParams = new Button(new PVector(w+50, 1155));
  resetLoop = new Button(new PVector(w+425, 1155));
  
  saveParams.setLabel("Save");
  loadParams.setLabel("Load");
  getRandomParams.setLabel("Randomize");
  resetLoop.setLabel("Reset Loop");
  
  saveParams.onClick(new ICallback() {
    public void run() {
       // create object to save
       toSave = new JSONObject();
       toSave.setFloat("transparency",transparencySlider.getValue());
       toSave.setFloat("fillOfBackground",fillOfBackgroundSlider.getValue());
       toSave.setFloat("xMultiplier1",xMultiplier1Slider.getValue());
       toSave.setFloat("xMultiplier2",xMultiplier2Slider.getValue());
       toSave.setFloat("xMultiplier3",xMultiplier3Slider.getValue());
       toSave.setFloat("xMultiplier4",xMultiplier4Slider.getValue());
       toSave.setFloat("yMultiplier1",yMultiplier1Slider.getValue());
       toSave.setFloat("yMultiplier2",yMultiplier2Slider.getValue());
       toSave.setFloat("yMultiplier3",yMultiplier3Slider.getValue());
       toSave.setFloat("yMultiplier4",yMultiplier4Slider.getValue());
       toSave.setFloat("pointAmt",pointAmtSlider.getValue());
       toSave.setFloat("pointSize",pointSizeSlider.getValue());
       // open selection and save it
       selectInput("Save parameters", "saveToSelectedFile");
    }
  });
  loadParams.onClick(new ICallback() {
    public void run() {
       selectInput("Choose a p3pd File to load", "loadParams");
    }
  });
  getRandomParams.onClick(new ICallback() {
    public void run() {
       randomizeParameters();
    }
  });
  resetLoop.onClick(new ICallback() {
    public void run() {
      globalX = 0;
    }
  });
  
  resetLoop.setHeight(30);
  resetLoop.setLabelSize(20);
  getRandomParams.setHeight(30);
  getRandomParams.setLabelSize(20);
  
  buttons.add(saveParams);
  buttons.add(loadParams);
  buttons.add(getRandomParams);
  buttons.add(resetLoop);
  
  // Separators
  
  separator = new Separator(w,1140,800);
  
  separators.add(separator);
}

void randomizeParameters() {
  transparencySlider.randomizeValue();
  fillOfBackgroundSlider.randomizeValue();
  xMultiplier1Slider.randomizeValue();
  xMultiplier2Slider.randomizeValue();
  xMultiplier3Slider.randomizeValue();
  xMultiplier4Slider.randomizeValue();
  yMultiplier1Slider.randomizeValue();
  yMultiplier2Slider.randomizeValue();
  yMultiplier3Slider.randomizeValue();
  yMultiplier4Slider.randomizeValue();
  pointAmtSlider.randomizeValue();
  pointSizeSlider.randomizeValue();
}

void saveToSelectedFile(File selection) {
  if (selection == null) return;
  String path = selection.getAbsolutePath();
  String suffix;
  String ext = path.substring(path.length() - 5, path.length());
  if (selection.exists()) {
    if (ext.equals(".p3pd")) {
      suffix = ""; 
    } else {
      suffix = "_new.p3pd"; 
    }
  } else {
    if (ext.equals(".p3pd")) {
      suffix = ""; 
    } else {
      suffix = ".p3pd"; 
    }
  }
  saveJSONObject(toSave, selection.getAbsolutePath()+suffix);
}

void loadParams(File selection) {
  if (selection == null) return;
  String path = selection.getAbsolutePath();
  String ext = path.substring(path.length() - 5, path.length());
  if (!ext.equals(".p3pd")) return;
  if (!selection.exists()) return;
  JSONObject json = loadJSONObject(path);
  transparencySlider.setValue(json.getFloat("transparency"));
  fillOfBackgroundSlider.setValue(json.getFloat("fillOfBackground"));
  xMultiplier1Slider.setValue(json.getFloat("xMultiplier1"));
  xMultiplier2Slider.setValue(json.getFloat("xMultiplier2"));
  xMultiplier3Slider.setValue(json.getFloat("xMultiplier3"));
  xMultiplier4Slider.setValue(json.getFloat("xMultiplier4"));
  yMultiplier1Slider.setValue(json.getFloat("yMultiplier1"));
  yMultiplier2Slider.setValue(json.getFloat("yMultiplier2"));
  yMultiplier3Slider.setValue(json.getFloat("yMultiplier3"));
  yMultiplier4Slider.setValue(json.getFloat("yMultiplier4"));
  pointAmtSlider.setValue(json.getFloat("pointAmt"));
  pointSizeSlider.setValue(json.getFloat("pointSize"));
  globalX = 0;
}
