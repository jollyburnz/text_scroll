import themidibus.*;

MidiBus myBus;
OPC opc;
PFont f;
PShader blur;
float color1, color2, color3, colortext1, colortext2, colortext3;
float spacing, offsetX, offsetY, distance, rotation;


void setup()
{
  size(600, 200, P2D);

  // Horizontal blur, from the SepBlur Processing example
  blur = loadShader("blur.glsl");
  blur.set("blurSize", 5);
  blur.set("sigma", 8.0f);
  blur.set("horizontalPass", 1);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
  //
  // Create the font
  f = createFont("Futura", 30);
  textFont(f);
}

void scrollMessage(String s, float speed)
{
  int x = int( width + (millis() * -speed) % (textWidth(s) + width) );
  text(s, x, 120);  
}

void draw()
{
  background(color1, color2, color3);
  
  spacing = 3;
  offsetX = 50;
  offsetY = 8;
  distance = 1.3; //poop
  rotation = 0;
  
  opc.ledGrid(0, 64, 8, width/2+offsetX*distance, height/2+offsetY, spacing, spacing, rotation, false);
  //opc.ledGrid(512, 64, 8, width/2+offsetX*distance+mouseX, height/2+offsetY+spacing*8+mouseY, spacing, spacing, rotation, false);
  opc.ledGrid(512, 64, 8, width/2+offsetX-spacing*64*distance, height/2+offsetY, spacing, -spacing, rotation, false);

  fill(colortext1, colortext2, colortext3);
  //scrollMessage("@conartistnyc @conartistnyc @conartistnyc @conartistnyc @conartistnyc @conartistnyc @conartistnyc", 0.1);
  scrollMessage("CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    CON ARTIST COLLECTIVE    ", 0.1);

  
  filter(blur);
  opc.setColorCorrection(3.0, 0.5, 0.5, 0.5);
}

void controllerChange(int channel, int number, int value) {
  //controllerValue = value;
  println(channel);
  println(number);
  println(value);
  if(number == 20){
    color1 = value/127.0*255;
    println(color1);
  } else if (number == 21) {
    color2 = value/127.0*255;
    println(color2);
  } else if (number == 22) {
    color3 = value/127.0*255;
    println(color3);
  } else if (number == 23) {
    spacing = value/25.0;
  } else if (number == 24) {
    colortext1 = value/127.0*255;
  } else if (number == 25) {
    colortext2 = value/127.0*255;
  } else if (number == 26) {
    colortext3 = value/127.0*255;
  }
}
