int edge=5;
int NUM=5000;
int speed=2;
float[] x=new float[NUM];
float[] y=new float[NUM];
float[] r=new float[NUM];
float[] theta=new float[NUM];
float[] fixed_x=new float[NUM];
float[] fixed_y=new float[NUM];
float[] fixed_hue=new float[NUM];
int nan=1000;
float hue=0;
 
void setup(){
  size(400,400);
  colorMode(HSB);
  for(int i=0;i<NUM;i++){
  r[i]=random(50,200);
  theta[i]=random(0,2*PI);
  x[i]=int(width/2+r[i]*cos(theta[i]));
  y[i]=int(width/2+r[i]*sin(theta[i]));
  }
  fixed_hue[0]=hue;
  fixed_x[0]=width/2;
  fixed_y[0]=height/2;
  for(int i=1;i<NUM;i++){
    fixed_x[i]=nan;
    fixed_y[i]=nan;
  }
  noStroke();
}
 
void draw(){
  background(0);
  Disp_Move_Molecular();
  Disp_Fixed_Molecular();
  CheckHit();
}
 
void Disp_Move_Molecular(){
  fill(255);
  for(int i=0;i<NUM;i++){
   if(x[i]!=nan){
    theta[i]=random(0,2*PI);
    x[i]+= speed*cos(theta[i]);
    y[i]+= speed*sin(theta[i]);
      ellipse(x[i],y[i],edge,edge);
    }
  }
}
 
void Disp_Fixed_Molecular(){
   for(int i=0;i<NUM;i++){
     if(fixed_x[i]!=nan){
       fill(fixed_hue[i],255,255);
       ellipse(fixed_x[i],fixed_y[i],edge,edge);
     }
      
  }
}
 
void CheckHit(){
   for(int i=0;i<NUM;i++){
     if(x[i]!=nan){
       for(int j=0;j<NUM;j++){
         if(fixed_x[j]!=nan){
           if(distance(i,j)<=edge){
             fixed_x[i]=x[i];
             fixed_y[i]=y[i];
             x[i]=nan;
             y[i]=nan;
             hue+=0.1;
             if(hue>255){
               hue=0;
             }
             fixed_hue[i]=hue;
           }
         }
       }
     }
  }
}
 
float distance(int i,int j){
  float d;
  d=sq(x[i]-fixed_x[j])+sq(y[i]-fixed_y[j]);
  return sqrt(d);
}
