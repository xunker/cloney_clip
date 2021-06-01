ff = 0.01;

thick = 0.08;

total_h = 1.2;

spring_arc_r = 0.19;

module pads(t=thick) {
  translate([0.1, (1-0.84)/2, 0]) {
    cube([0.41, 0.84, t]);
    translate([0.61, 0, 0]) cube([0.41, 0.84, t]);
    translate([1.22, -(1-0.84)/2, 0]) cube([0.52, 1, t]);
  }
}

module footprint() {
  %color("green") pads(t=ff);
}

module floor() {
 pads(thick);
 translate([0.1, (1-0.64)/2, 0]) {
   cube([2-(0.1+spring_arc_r), 0.64, thick]);
 }
}

module outline() {
 %cube([2, 1, total_h]);
}

module side() {
  cube([1.17, thick, 0.4]);
}


module spring_arc(rot=0, wide=1) {

  translate([0, 0, spring_arc_r]) rotate([-90, rot, 0]) {
    difference() {
      translate([0, 0, ((1-wide)/2)]) difference() {
        cylinder(r=spring_arc_r, h=wide, $fn=16);
        translate([0, 0, -ff]) cylinder(r=thick*1.5, h=wide+(ff*2), $fn=16);
      }
      translate([-spring_arc_r, -spring_arc_r-ff, ((1-wide)/2)-ff]) cube([(spring_arc_r*2)/2, (spring_arc_r*2)+ff, wide+(ff*2)]);
    }
  }
}

// I really should have paid attention to geometry in school
module spring_arm() {
  translate([2-spring_arc_r, 0, 0]) spring_arc();

  translate([0.4, 0, total_h-(spring_arc_r*2)]) spring_arc(rot=260, wide=0.58);

  //upper
  hull() {
    translate([0.4+spring_arc_r/2, (1-0.58)/2, total_h-(spring_arc_r*2)+spring_arc_r]) cube([ff, 0.58, thick]);
    translate([2-spring_arc_r, 0, spring_arc_r+(spring_arc_r/(3.14/2))]) cube([ff, 1, thick]);
  }

  //lower
  hull() {
    translate([0, (1-0.58)/2, 0]) {
      translate([0.4-spring_arc_r, 0, total_h-(spring_arc_r)]) cube([thick, 0.58, ff]);
      translate([0.4*2, 0, thick*1.5]) cube([thick, 0.58, ff]);
    }
  }

}

// footprint();
// outline();
side();
translate([0, 1-thick, 0]) side();
floor();
spring_arm();


