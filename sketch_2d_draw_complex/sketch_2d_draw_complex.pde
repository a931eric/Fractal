Complex c;

void setup(){
  size(800,800);
  colorMode(HSB);
  translate=new PVector(0,0);
  c=new Complex(-1,0);
}

void draw(){  
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      Complex z0=posToComplex(x,y);
      pixels[x+y*width]=colorAt(z0);
    }
  }
  updatePixels();
}

color colorAt(Complex z){
  int times=20;
  for(int i=0;i<times;i++){
    z=f(z);
  }
  if(!(z.abs()<10))
    return color(255);
  else if (z.abs()==0)
    return color(0);
  else
    return color((int)(z.arg()/2/PI*255+2550)%255,255*exp(-z.abs()),255);
}

Complex f(Complex z){
  //return add(z.power(2),c);
  return add(z,devide(add(z.power(3),-1),mult(z.power(2),-3)));
}

//=================================================================================================================

float scale=0.005;
PVector translate;

Complex posToComplex(float x,float y){
  return new Complex((x-width/2)*scale-translate.x,-(y-height/2)*scale-translate.y);
}
PVector complexToPos(Complex c){
  return new PVector((c.re+translate.x)/scale+width/2,(c.im+translate.y)/scale+height/2);
}

void mouseDragged(){
  translate.add(new PVector((mouseX-pmouseX)*scale,(mouseY-pmouseY)*-scale));
}
void mouseWheel(MouseEvent event) {
  scale*=1+event.getCount()*0.1;
}
void mousePressed(){
  saveFrame("####.png");
}
