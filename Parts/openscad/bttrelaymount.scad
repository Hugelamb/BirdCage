w = 80.32;
h = 36.19;
d = 6;
hspace = 74.17;
hs2 = hspace/2;
vspace = 29.21;
vs2 = vspace/2;
hole_size = 4.7;
_mountCenter = [w/2,h/2];
standoff_x = 6.15;
standoff_h = 2; // Standoff Height above mount top surface
filletRadius=3.5;
// holePlacements = [LL,UL,UR,LR]
holePlacements = [[(_mountCenter[0]-hs2),(_mountCenter[1]-vs2)],[(_mountCenter[0]-hs2),(_mountCenter[1]+vs2)],[(_mountCenter[0]+hs2),(_mountCenter[1]+vs2)],[(_mountCenter[0]+hs2),(_mountCenter[1]-vs2)]];

difference () { 
    union () {
        filletedCube(w,h,d,radius=filletRadius,height=d,center = false);
        //cube([w,h,d]);
        placeArraycube(holePlacements,standoff_x,6.98,standoff_h,d,radius=filletRadius);
    }
for (a = [0 : len(holePlacements) - 1 ])
{
    point=holePlacements[a];
    translate([point[0],point[1],0])
    {
        cylinder(d=hole_size,h=d+10);
    }
}
}

module placeArraycube(array,cx,cy,cz,zArray = 0,radius = 1) {
for (a = [0 : len(array) - 1 ])
    {
        point=array[a];
 cornerboolArray = [ for (i = [0 : len(array) - 1]) if (a == i) 1 else 0];
        translate([point[0],point[1],zArray]) 
        {
            filletedCube(cx,cy,cz,center = true,se=cornerboolArray[3],ne=cornerboolArray[2],nw=cornerboolArray[1],sw=cornerboolArray[0],radius=radius);
        }
    }
}


module roundedRectangle(size, radius, ne=1,nw=1, se=1, sw=1,center=true)
{
//local variables
x = size[0];
y = size[1];

//If center is false, we need to translate
if (center)
{
hull()
{
    // place 4 circles in the corners, with the given radius
    if(sw==1) {translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(r=radius);}

    if(se==1) {translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(r=radius);}

    if (nw==1) {translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(r=radius);}

    if(ne==1) {translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(r=radius);}
    
     if(nw==0) {translate([-x/4,y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(ne==0) {translate([x/4,y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(se==0) {translate([x/4,-y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(sw==0) {translate([-x/4,-y/4, 0])
     square([x/2,y/2],center=true);}   
}
}
else
{
translate([x/2,y/2,0])
hull()
{
    // place 4 circles in the corners, with the given radius
    if(sw==1) {translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(r=radius);}

    if(se==1) {translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(r=radius);}

    if (nw==1) {translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(r=radius);}

    if(ne==1) {translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(r=radius);}
    
     if(nw==0) {translate([-x/4,y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(ne==0) {translate([x/4,y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(se==0) {translate([x/4,-y/4, 0])
     square([x/2,y/2],center=true);}
     
     if(sw==0) {translate([-x/4,-y/4, 0])
     square([x/2,y/2],center=true);}   
}
}
}

module filletedCube (cx,cy,cz,ne=1,nw=1,se=1,sw=1,center = true,radius=1,height) {
    linear_extrude(height = cz) {
        roundedRectangle([cx,cy],radius=radius,center = center,ne=ne,nw=nw,se=se,sw=sw);
    }
}

$fa = 1;
$fn = 1000;