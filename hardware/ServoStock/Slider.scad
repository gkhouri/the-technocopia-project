use <Parameters.scad>
use <../Vitamins/Structural/LinearBearings/LM8UU_Linear_Bearing_Vitamin.scad>
use <../Vitamins/Fasteners/ScrewsAsBolts/High_Low_Screw_As_Bolt_Vitamin.scad>
use <../Vitamins/Kinematics/Belts/OneFifthinXLTimingBelt.scad>
use <../Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../Vitamins/Structural/RodEnds/RodEnd_Vitamin.scad>

use <RodEndClips.scad>
use <Pulley.scad>

function BearingGripDiam()= LM8UULinearBearingDiam()+PlasticWidth()*2;
function SliderHeight()= LM8UULinearBearingHeight()+PlasticWidth()*2;
function GripWidth()= PlasticWidth();
function FlareLength()= (RodEndSpacing()-ZrodSpacing())/2-LM8UULinearBearingDiam()/2+PlasticWidth()/2; 

function BeltClipLength()=StandardServoCylinderHeight()+PulleyBeltOffset()+2XLBeltWidth();

$fn=100;

module TaperedCylinder()
{
	cylinder(PlasticWidth()+2, LM8UULinearBearingDiam()/2.2, LM8UULinearBearingDiam()/1.9);	
}


module LinearBearingGrip()
{
	union()
	{
		difference()
		{
			cylinder(SliderHeight(), BearingGripDiam()/2, BearingGripDiam()/2);
			translate([0,0,PlasticWidth()])
			{
				#LM8UUBearing();
			}
			translate([0,0,PlasticWidth()+LM8UULinearBearingHeight()-1])
			{
				TaperedCylinder();
			}
			translate([0,0,PlasticWidth()+1])
			{
				mirror([0,0,1])
				{
					TaperedCylinder();
				}
			}
			translate([-BearingGripDiam()/2+LM8UULinearBearingDiam()/4,LM8UULinearBearingDiam()/3,-1])
			{
				cube([LM8UULinearBearingDiam(), LM8UULinearBearingDiam(), SliderHeight()+2]);
			}
		}
	difference()
	{
		union()
		{
			translate([LM8UULinearBearingDiam()/2.67,LM8UULinearBearingDiam()/3,0])
			{
				cube([PlasticWidth(), LM8UULinearBearingDiam()/1.2, SliderHeight()]);
			}
			translate([-LM8UULinearBearingDiam()/1.55,LM8UULinearBearingDiam()/3,0])
			{
				cube([PlasticWidth(), LM8UULinearBearingDiam()/1.2, SliderHeight()]);
			}
		}
		translate([LM8UULinearBearingDiam()-PlasticWidth()-HiLoBoltLength(), LM8UULinearBearingDiam()/2+PlasticWidth(),SliderHeight()/2])
		{
			rotate([0,-90,0])
			{
				#HiLoBolt();
			}
		}
	}
	}
}

module BeltClip()
{
	translate([-PulleyInnerDiam()/2-2XLBeltGripHeight()+2XLBeltGripHeight()/2,BeltClipLength()/2,SliderHeight()/2])
	{
		difference()
		{
			cube([2XLBeltGripHeight()*3.5, BeltClipLength(), SliderHeight()], center=true);
			translate([0,BeltClipLength()/2-2XLBeltSlotWidth()+.12,SliderHeight()+1])
			{
				rotate([0,90,0])
				{
					2XLTimingBeltSlot();
				}
			}
		}
	}
}





module SliderBase()
{
	union()
	{
		translate([LM8UULinearBearingDiam()/2+1,PlasticWidth()/2-GripWidth(),0])
		{
			cube([ZrodSpacing()-LM8UULinearBearingDiam()-2,GripWidth(),SliderHeight()]);
		}
		translate([0,PlasticWidth()/2,0])
		{
		LinearBearingGrip();				
		}
		translate([ZrodSpacing(),PlasticWidth()/2,0])
		{
			mirror([1,0,0])
			{
				LinearBearingGrip();
			}				
		}
	}
}

module Flare()
{
	translate([-LM8UULinearBearingDiam()/2-FlareLength()-PlasticWidth()/2-1,-PlasticWidth()/2,0])
	{
		cube([FlareLength()+PlasticWidth()/2,PlasticWidth()*1.5,RodEndTopWidth()]);
	}
}




//%cube(size=[RodEndSpacing(), RodEndSpacing(), 20,], center=true);


module Slider()
{
	union()
	{
		translate([-ZrodSpacing()/2,-PlasticWidth()/2,0])
		{
			SliderBase();			
			Flare();
			mirror([1,0,0])
			{
				translate([-ZrodSpacing(),0,0])
				{
					Flare();
				}
			}
		}
	BeltClip();
	translate([0,-PlasticWidth(),0])
	{
		RodEndClips();
	}
	}
}

Slider();

//to check if pulley lines up
//use <../Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
//translate([0,StandardServoCylinderHeight(),0])
//	rotate([-90,0,0])
//		{
//		servo_pulley(true);
//		}
