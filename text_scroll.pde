OPC opc;
PFont f;
PShader blur;

void setup()
{
  size(800, 200, P2D);

  // Horizontal blur, from the SepBlur Processing example
  blur = loadShader("blur.glsl");
  blur.set("blurSize", 5);
  blur.set("sigma", 8.0f);
  blur.set("horizontalPass", 1);

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  float spacing = 5;
  float offsetX = 0;
  float offsetY = -20;
  float distance = 1; //poop
  float rotation = 0;
  
  opc.ledGrid(0, 64, 8, width/2+offsetX-spacing*8*distance, height/2+offsetY, spacing, spacing, rotation, false);
  opc.setColorCorrection(3.0, 0.9, 0.9, 0.9);
  // Create the font
  f = createFont("Futura", 50);
  textFont(f);
}

void scrollMessage(String s, float speed)
{
  int x = int( width + (millis() * -speed) % (textWidth(s) + width) );
  text(s, x, 100);  
}

void draw()
{
  background(0);
  
  fill(255, 255, 255);
  scrollMessage("#VETTERYKINGDOM", 0.2);
  
  filter(blur);
}