//LIBRARIES



//GLOBAL VARIABLES
PFont gistUp;
PFont helvetica;
PFont broadway;
PFont bedas;
PFont ostrichSans;
PShape baseMap;
String csv[];
String years[];
String myData[][];
float mx = 29; // mouseX
String lastName = "";
String name;
//SETUP
void setup()
{
  //App size
  size(1600, 1000);
  noLoop();
  
  broadway = loadFont("Broadway-48.vlw");
  bedas = loadFont("BebasNeue-48.vlw");
  helvetica = loadFont("HelveticaNeueLTCom-Th-48.vlw");
  strokeCap( SQUARE );
  
  //load Map
  baseMap = loadShape("WorldMap.svg");
  
  //Link for Data use https://data.nasa.gov/Space-Science/Meteorite-Landings/gh4g-9sfh
  csv = loadStrings("MeteoriteLandings.csv");
  //println(csv); ccan add array to acces the line you want [n]
  
  myData = new String [csv.length][6];
  for(int i=0; i<csv.length; i++)
  {
    myData[i] = csv[i].split(",");
  }
  //println(myData[23][4]);
  smooth();
}


//DRAW
void draw()
{
  background(74, 139, 219);
  shape(baseMap, 0, 0, 1600, 800);
  noStroke();
  
  fill( 74, 139, 219 );
  textFont( broadway, 20 );
  textAlign( LEFT );
  text( "Airburst Data Visualization", 20, 30 );
  textFont( bedas, 16 );
  text( "Meteorite Landings ", 20, 50 );
  textFont( bedas, 17 );
  
  fill( 255, 255, 255 );
  textAlign(CENTER);
  text("Annual Visualization", 1600/2, 830);
  textAlign(LEFT);
  text( "Years", 20, 860 );
  
  for(int i=0; i<myData.length; i++)
  {
     fill(211, 6, 28, 50); //random(0,255)
     noStroke();
     //get  data 
     //println(myData[i][0] + " - " + myData[i][8] );
     float graphLong = map(float(myData[i][8]), -180, 180, 0, 1600);
     float graphLat = map(float(myData[i][7]), 90, -90, 0, 800);
     float markerSize = 0.03*sqrt(float(myData[i][3]))/PI;
     
     //println(graphLong + " / " + graphLat);
     
     //draw marker
     ellipse(graphLong, graphLat, markerSize, markerSize);
     
     textFont( helvetica, 10 );
     
     if(i<20)
     {
       name = myData[i][0];
       if(name != lastName){
         fill(0);
         text(myData[i][0], graphLong + markerSize + 5, graphLat + 5);
         noFill();
         stroke(0);
         line(graphLong+markerSize/2, graphLat, graphLong+markerSize, graphLat);
         
         lastName = name;
       }
       
     }
     

     
  }
  
    for(int i=0; i<myData.length; i += 100)
  {
        //Make line plots data
        String year = myData[i][5];
        years = year.split(" ");
        year = years[0];
        float mass = float(myData[i][3]);
        float x = map(i, 0, 37296, 30, 1550);
        float y = map(float(myData[i][3]), -2, 821, 960, 950);
        
         
        //println(year);
        //println(x + " / " + y);
        
        // Slicing interaction for dates and values
        // Placed here so it goes behind the data lines
        strokeWeight(1);
        if((mx > 30) && (mx < 1500)) {
          line(mx, 990, mx, 880);
    //      if(mx == x) {
          if(abs(mx - x) < 2) {
            fill(255,255,255);
            text(myData[i][5], mx + 6, 815);
    //        text(popularity, mx + 6, 55);
            text(nfp(float(myData[i][3]), 1, 3),mx + 6, 860);
          }
        }  
        
        // Lines and dots
        stroke(211, 6, 28);
        line(x, y, x, 965);
        noStroke();
        fill(211, 6, 28);
        int d = 3;
        ellipse(x, y, d, d);
  }
  
  
      for(int i=1; i<myData.length; i += 1000)
  {
        //Make line plots data
        String year = myData[i][5];
        years = year.split("-");
        //println(myData[i][0]);
        year = years[2];
        String Y[] = year.split(" ");
        year = Y[0];
        float mass = float(myData[i][3]);
        float x = map(i, 0, 37296, 30, 1550);
        float y = map(float(myData[i][3]), -2, 82, 960,950);
        
       println(myData[i][0]+ " / " + myData[i][3]);
        //println(year);
        fill(255,255,255);
         textFont( helvetica, 13 );
        // Dates
        text(year, x, 980);
         
        // Lines and dots for January
        stroke(225,225,255);
        strokeWeight(3);
        strokeCap(SQUARE);
        line(x, y, x, 965);
        noStroke();
  }
  
  
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) {
      mx -= 2;
    } else if (keyCode == RIGHT) {
      mx += 2;
    }
  }
}

void mouseMoved() {
  mx = mouseX;
}
