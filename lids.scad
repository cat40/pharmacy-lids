include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/shapes2d.scad>

lid_type = "ngon"; // [ngon, star]
ngon_points = 4;
ngon_radius = 30;
star_points = 10;
star_inner_radius = 21.5;

/* [Hidden] */
cube_size = 50;
screw_diameter = 39.5;
screw_depth = 16;
screw_pitch = 4;
lid_depth = 20;

$fn = 256;

module threads()
{
    trapezoidal_threaded_rod(screw_diameter, screw_depth, screw_pitch, internal=true);
}

module star_lid(number_of_points=6)
{
    difference()
    {
        linear_extrude(lid_depth)
            star(n=number_of_points, or=star_inner_radius+5, ir=star_inner_radius);
        translate([0, 0, screw_depth/2])
            #threads();
    }
}

module ngon_lid(number_of_sides=6, radius=25)
{
    difference()
    {
        linear_extrude(lid_depth)
            regular_ngon(number_of_sides, radius);
        translate([0, 0, screw_depth/2])
            #threads();
    }
}



//star_lid(10);
//ngon_lid(3, radius=43);
//ngon_lid(4, radius=30);
//ngon_lid(5, radius=26);
//ngon_lid(6, radius=25);
//ngon_lid(7, radius=23);
//ngon_lid(8, radius=23);
//ngon_lid(9, radius=23);
if (lid_type == "star")
{
    star_lid(star_points);
}
else if (lid_type == "ngon")
{
    ngon_lid(ngon_points, ngon_radius);
}