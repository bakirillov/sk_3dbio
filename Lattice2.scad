//Parameters
number = 10;
height = 3;
radius = 1;
max_x = 48;
max_y = 48;

$fn = 19;

//Stand
module stand()
    translate([-25,-25,0]) {
        minkowski()
            {
                cube([50,50,1]);
                cylinder(r=2,h=3);
            }
    }


//Base lattice
module base_lattice(max_x,max_y,height,radius,number)
    linear_extrude(height=height)
        difference(){
            square([max_x,max_y]);
            number2 = ceil(max_y/max_x*number);
            for(i=[0:number], j=[0:2*number2])
                translate(
                    [(i+(j%2)/2)*max_x/number, j*max_x/number/2]
                )
                    rotate(45)
                    square(
                        max_x/number/sqrt(2)-radius,
                        center=true
                    );
        }

//Lattice
union() {
    difference() {
        union() {
            for(i=[0:16])
                translate([-24,-24,-2*i]) {
                    base_lattice(
                        max_x,max_y,height,radius,number
                    );
                }
            }
        union() {
            translate([0,-25,0]) {
                for(i=[0:6], j=[0:10])
                    rotate([0,90,0])
                        translate([5*i,5*j,-25])
                            cylinder(50,1,1);
            }
        }
        union() {
            translate([-25,0,0]) {
                for(i=[0:6], j=[0:10])
                    rotate([90,90,0])
                        translate([5*i,5*j,-25])
                            cylinder(50,1,1);
            }
        }
    }
    stand();
}
        
