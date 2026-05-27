base_mesh = "motctlBasev3.stl";
operator_mesh = "../3D_Printer_Parts/openconnectMotorCtlBackerv4neg.stl";
transform_units = "mm"; // ["mm", "grid"]
/* Operator Body transforms */
x_transform = 0; // .001
y_transform = 0; // .001
z_transform = -2.72;// 0.001
x_rotation = 0; // 0.001 
y_rotation = 0; // 0.001
z_rotation = 180; // 0.001


// End customizer fields
grid_scaler = transform_units == "mm" ? 1 : 28; // scale by this amount
xt = x_transform * grid_scaler;
yt = y_transform * grid_scaler;
zt = z_transform * grid_scaler;
xr = x_rotation ;
yr = y_rotation ;
zr = z_rotation ;

module mcBase()
    mirror([0,0,1]) import(base_mesh); 
    
module ocNeg()  
    translate([xt,yt,zt]) rotate([xr,yr,zr]) import(operator_mesh);

//difference () {import("motctlBasev2.stl");import("../3D_Printed_Parts/openconnectMotorCtlBackerv4neg.stl");};
//mcBase();
//ocNeg();
difference () {mcBase();ocNeg(); }

