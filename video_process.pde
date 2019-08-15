import processing.video.*;

Capture video;
color track_col;
int count=0;

ArrayList<PVector> path;

int x=0;
int p_x,p_y;
int t_x,t_y;


PImage prev;


int threshold=30;
boolean allow=false;


           
           
void setup(){
  size(640,480);
   path=new ArrayList<PVector>();
  video=new Capture(this,640,480,30);
  video.start();
  //prev=createImage(video.width,video.height,RGB);
  loadPixels();
  
 
}
void draw(){
  //video.loadPixels();
 // prev.loadPixels();
  if(!allow)
{image(video,0,0,width,height);

//image(video,width,0,-width,height);
}
else{
pushMatrix();
 scale(-1.0, 1.0);
 
 image(video,-video.width,0);
 popMatrix();
 //image(video,0,0,width,height);
 
 }

                       
                       
if(allow){
  p_x=0;
  p_y=0;
  count=0;

  float d=100000;
  for(int y=0;y<video.height;y++){
           for(int x=0;x<video.width;x++){
                       int loc=x+y*width;
                       color current_col=video.pixels[loc];
                      // color prev_col=prev.pixels[loc];

                       
                       float r1=red(current_col);
                       float g1=green(current_col);
                       float b1=blue(current_col);
                       
    
                       float r2=red(track_col);
                       float g2=green(track_col);
                       float b2=blue(track_col);
                       
                       //float r3=red(prev_col);
                       //float g3=green(prev_col);
                       //float b3=blue(prev_col);
                       
                       d=distSq(r1,g1,b1,r2,g2,b2);
                       
                       //d=distSq(r1,g1,b1,r3,g3,b3);
                       
                       
                       if(d<threshold*threshold){
                        
                        
                         p_x+=x;
                         p_y+=y;
                        count++;
                        //pixels[loc]=color(255);
                        
                        
                      }
                      //else{
                      //  pixels[loc]=color(0);
                      //}
                         
                       }
                  }
                  
                  //updatePixels();
                
                
              if(count>0){
                           
                                      noStroke();
                                      
                                    fill(255,0,0);
                                    
                                    p_x/=count;
                                   p_x=video.width-1-p_x;
                                    p_y/=count;
                                           path.add(new PVector(p_x,p_y));
                                    // ellipse(p_x,p_y,20,20);
                                    //println(worldRecord);
                      }
                  else{
                          path.clear(); }
              
              //prev_x=p_x;
              //prev_y=p_y;
            
          }
          
           stroke(250,0,0,180);
           noFill();
            beginShape();
            for(PVector pos: path){
              strokeWeight(6);
              vertex(pos.x,pos.y);
              //fill(255,100,0);
              //ellipse(pos.x,pos.y,10,10);
            }
            endShape();
   
  }
  
  void captureEvent(Capture video){
    //pushMatrix();
 //scale(-1.0, 1.0);
 //image(video,-video.width,0);
   // prev.copy(video,-video.width,0,video.width,video.height,0,0,prev.width,prev.height);
    //prev.copy(video,0,0,640,480,0,0,prev.width,prev.height);
    //popMatrix();
  
 //   prev.updatePixels();
    
    
    
    video.read();}
    
    
    void mousePressed(){
      stroke(255);
      //t_x=mouseX;
      //t_y=mouseY;
      
      int loc=mouseY*video.width+mouseX;
      
     track_col=video.pixels[loc];
     // ellipse(mouseX,mouseY,10,10);
     println("track"+red(track_col)+" "+green(track_col)+" "+blue(track_col));
      allow=true;
      
      path.clear();
    }
    
    float distSq(float x1,float y1,float z1,float x2,float y2,float z2){
      float d=(x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1);
      return d;}
    
    
