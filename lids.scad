include <BOSL2/std.scad>
include <BOSL2/threading.scad>
include <BOSL2/shapes2d.scad>

lid_type = "ngon"; // [ngon, star]
ngon_points = 4;
ngon_radius = 30;
star_points = 10;
star_inner_radius = 21.5;
use_moon = false;
moon_depth = 0.5;

/* [Hidden] */
cube_size = 50;
screw_diameter = 39.5;
screw_depth = 16;
screw_pitch = 4;
lid_depth = 20;
moon_radius = (screw_diameter-10)/2;
    
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

module moon()
{
    moon_shift = moon_radius/1.25;
    translate([moon_shift/4, 0, 0])
    difference()
    {
        circle(r=moon_radius);
        translate([moon_shift, 0, 0])
            circle(r=moon_radius);
    }
}

//moon();


difference()
{
    if (lid_type == "star")
    {
        star_lid(star_points);
    }
    else if (lid_type == "ngon")
    {
        ngon_lid(ngon_points, ngon_radius);
    }
    
    if (use_moon)
    {
        translate([0, 0, lid_depth-moon_depth])
            #linear_extrude(moon_depth)
                moon();
    }
}