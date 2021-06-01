// starting from top of data sheet drawing to bottom

piston_d = 0.042 * 25.4;
neck_d = 0.059 * 25.4;

shoulder_d = 0.064 * 25.4;
trunk_d = neck_d; // not marked on data sheet, assumed
smd_flange_d = 0.072 * 25.4;


piston_h = 0.024 * 25.4; // max stroke, mid stroke is half
neck_h = 0.6128;
shoulder_h = 0.2;
trunk_h = 0.028 * 25.4;
smd_flange_h = 0.016 * 25.4;

ff = 0.01;

$fn=32;

translate([0, 0, 0]) cylinder(d=smd_flange_d, h=smd_flange_h+ff);
translate([0, 0, smd_flange_h]) cylinder(d=trunk_d, h=trunk_h+ff);
translate([0, 0, smd_flange_h + trunk_h]) cylinder(d1=shoulder_d, d2=neck_d, h=shoulder_h+ff);
translate([0, 0, smd_flange_h + trunk_h + shoulder_h]) cylinder(d=neck_d, h=neck_h+ff);
translate([0, 0, smd_flange_h + trunk_h + shoulder_h + neck_h]) {
  hull() {
    cylinder(d=piston_d, h=piston_h/2);
    translate([0, 0, piston_h/2]) sphere(d=piston_d);
  }
}
