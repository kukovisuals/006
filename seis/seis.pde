import com.jogamp.opengl.GL2;
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.dwgl.DwGLTexture;
import com.thomasdiewald.pixelflow.java.imageprocessing.DwShadertoy;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;


  DwPixelFlow context;
  DwShadertoy toy;

  DwGLTexture tex_0 = new DwGLTexture();

  public void settings() {
    size(1280, 720, P2D);
    // fullScreen(P2D);
    smooth(0);
  }
  
  public void setup() {
    surface.setResizable(true);
    context = new DwPixelFlow(this);
    context.print();
    context.printGL();
    
    toy = new DwShadertoy(context, "data/sickLava.frag");

    // load assets
    PImage img0 = loadImage("data/noise.jpg");
    
    // create textures
    tex_0.resize(context, GL2.GL_RGBA8, img0.width, img0.height, GL2.GL_RGBA, GL2.GL_UNSIGNED_BYTE, GL2.GL_LINEAR, GL2.GL_MIRRORED_REPEAT, 4,1);
    
    // copy images to textures
    DwFilter.get(context).copy.apply(img0, tex_0);
    
    // mipmap
    DwShadertoy.setTextureFilter(tex_0, DwShadertoy.TexFilter.MIPMAP);
    // noCursor();
    frameRate(60);
  }

  public void draw() {
    
    toy.set_iChannel(0, tex_0);
    toy.apply(this.g);
     
    String txt_fps = String.format(getClass().getSimpleName()+ "   [size %d/%d]   [frame %d]   [fps %6.2f]", width, height, frameCount, frameRate);
    surface.setTitle(txt_fps);
    // saveFrame("data/vid/voronoi-#####.png");
  }
