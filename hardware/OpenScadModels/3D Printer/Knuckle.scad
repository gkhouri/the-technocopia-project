use <Parameters.scad>
use <Vitamins/BallBearing.scad>
use <Vitamins/Zrod.scad>
use <Vitamins/PlasticScrew.scad>

$fn=100;

height=ZrodSpacing();
Bdiam=BallBearingDiam();

//this creates the perpendicular bearing rest.
module BearingRecess(){

difference(){
	cylinder(BallBearingHeight()*2.5,Bdiam/1.25,Bdiam/1.25);  
	translate([0,0,BallBearingHeight()/2]){
		cylinder(BallBearingHeight()*2.5,(Bdiam/2)+1+3dPrinterTolerance(),(Bdiam/2)+1+3dPrinterTolerance());
	}
	translate([-BallBearingHeight()*4,-Bdiam/2,Bdiam/2]){
		cube([BallBearingHeight()*8,BallBearingHeight()*6,Bdiam]);
	}
//Below creates the notch for the bearing cover. in the future change the dimensions to parameterize with the cover.
	translate([-BallBearingHeight()*2,-Bdiam/2,BallBearingHeight()*1.6]){
		rotate([45,0,0]){
			cube([BallBearingHeight()*4,BallBearingHeight()/2,BallBearingHeight()/2]);
		}	
	}
}
}
module hole(){

cylinder(ScrewLength(),ScrewDiameter()/2,ScrewDiameter()/2);
}

module BearingHole(){

cylinder(BallBearingHeight()+10,BallBearingInnerDiam(),BallBearingInnerDiam());
}

module KnuckleShaft(){
	
difference()	{	
	rotate([90,0,0]){
		translate([0,0,-height+Bdiam]){
			cylinder(height,Bdiam/2,Bdiam/2);
		}
	}
	rotate([90,0,0]){
		translate([-height/2,-height,-height/2-Bdiam-2]){
			cube([height,height,height+2*Bdiam]);
		}
	}
	translate	([0,height*.4,-Bdiam/12]){
		hole();
	}
	translate([0,-height*.1,-Bdiam/12]){
		hole();
	}
}
}

//KnuckleShaft();
//translate([0,-height/1.8,0]){
BearingRecess();
//}

//translate([0,0,20]){
