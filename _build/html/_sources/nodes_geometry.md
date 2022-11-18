# Geometry nodes

Geometry nodes are the backbone of a model. They determine what can move and what can not. If the model is an animal, then the geometry nodes are the joints and bones.

## Frame

The first and most important geometry node is the `Frame` node, short for Axis-Frame. The frame node represents something rigid such as a bone, a ship or a crane boom. Mathematically the frame node is a 3d reference frame with an origin and an orientation.
The frame node has six degrees of freedom which can be enabled or disabled individually. This defines if and how it can move. It may also be connected to an other frame node. In that case the position, orientation and degrees of freedom are defined relative to that other frame.

More info and examples: Modeling basics / geometry


**Properties**

The parent of an frame determines if the frame node is connected to another node. If a frame does not have a parent then it is defined relative to the global axis system.

The position of a frame determines the position of the origin of the axis system relative to its parent.
The rotation of a frame determines the rotation. 

Both position and rotation are 3d vectors. All components of the position and rotation vector can individually be set to “fixed” or “free”. If a component is “free” then the frame can move in this degree of freedom. When solving statics the solver will determine a value for this component such that the system is in equilibrium.

For example defining the position as (free, 0, 23) results in a frame at elevation 23 and y=0 that can slide in the x-direction.
Defining both the position and rotation as (free, free, free) means a frame that is completely free to move.

**3D rotations**

Unlike in 2d, 3D rotations can suffer from many definition issues such as order of rotations and gimbal locks. DAVE uses a mathematically sound definition of rotation: the rotation vector.

The 3d rotation vector defines the rotation. The length of the vector is the rotation in degrees, the direction of the vector is the axis of rotation. Imagine the rotation vector as a hinge. The direction of the vector is the axis of the hinge (like in a door), the magnitude is the angle it makes.
A rotation of (10,0,0) is a rotation of 10 degrees about the x-axis.  A rotation of (5,0,5) is a rotation of 7.07 degrees about the (1,0,1) axis.

Some typical joints can be defined as follows:
Ball-joint: rotation = (free, free, free) 
Hinge-joint about x : rotation = (free, 0 ,0) 
Hinge-joint about y : rotation = (0, free ,0) 
Hinge-joint about z : rotation = (0 ,0, free) 

A rotation of (free, free, 0) defines a rotation vector located in the xy plane: A rotation about an horizontal axis.

For all these joints the non-free component is zero. It is mathematically possible to allow a non-zero value for one of the other components but it is difficult to interpret what is means. Try to imagine what a rotation vector of (free, free ,10) is. 
One may think for a moment that this is a good way to define a vessel that can roll (x=free) and pitch (y=free) but has a fixed heading of 10 degrees. But is not. It is a rotation with a minimum of 10 degrees about and axis that is at least a little vertical and uhm…. Well, not very practical.
Therefore the following limitation is applied: if one or two degrees of freedom of the rotation are free, then the other component is 0. This is enforced when solving.

So how to define a vessel that can roll and pitch but has a fixed, non-zero heading? Simple: break up the rotation is different parts. First make a frame with rotation = (0,0,10) which defines the heading. Then make a second frame with rotation = (free, free, 0) and connect that to the first one.

And this is how to make a hinge about an direction of (1,2,3) : First make a frame node with its rotation set to (1,2,3), then place a second axis-frame node with (free, 0, 0) on top of it.

Stack axis-frame nodes to define rotations about directions other than the principal ones

DAVE allows us to get/set the rotations and positions using either the local or global reference frames. Setting one will also update the other. In the end the local position and rotation are used in combination with the degrees of freedom.

There are a some  read-only convenience properties to get the orientation of a frame using common definitions: heel, trim, heading, tilt. These are derived from the global rotation.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
inertia |  | The linear inertia of the axis in [mT] Aka: "Mass"<br>        - used only for dynamics|
inertia_position |  | The position of the center of inertia. Aka: "cog" [m,m,m] (local axis)<br>        - used only for dynamics<br>        - defined in local axis system|
inertia_radii |  | The radii of gyration of the inertia [m,m,m] (local axis)<br><br>        Used to calculate the mass moments of inertia via<br><br>        Ixx = rxx^2 * inertia<br>        Iyy = rxx^2 * inertia<br>        Izz = rxx^2 * inertia<br><br>        Note that DAVE does not directly support cross terms in the interia matrix of an axis system. If you want to<br>        use cross terms then combine multiple axis system to reach the same result. This is because inertia matrices with<br>        diagonal terms can not be translated.<br>        |
fixed |  | Determines which of the six degrees of freedom are fixed, if any. (x,y,z,rx,ry,rz).<br>        True means that that degree of freedom will not change when solving statics.<br>        False means a that is may be changed in order to find equilibrium.<br><br>        These are the expressed on the coordinate system of the parent (if any) or the global axis system (if no parent)<br><br>        See Also: set_free, set_fixed<br>        |
x |  | The x-component of the position vector (parent axis) [m]|
y |  | The y-component of the position vector (parent axis) [m]|
z |  | The z-component of the position vector (parent axis) [m]|
position |  | Position of the axis (parent axis) [m,m,m]<br><br>        These are the expressed on the coordinate system of the parent (if any) or the global axis system (if no parent)|
rx |  | The x-component of the rotation vector [degrees] (parent axis)|
ry |  | The y-component of the rotation vector [degrees] (parent axis)|
rz |  | The z-component of the rotation vector [degrees], (parent axis)|
rotation |  | Rotation of the axis about its origin (rx,ry,rz).<br>        Defined as a rotation about an axis where the direction of the axis is (rx,ry,rz) and the angle of rotation is |(rx,ry,rz| degrees.<br>        These are the expressed on the coordinate system of the parent (if any) or the global axis system (if no parent)|
parent |  | Determines the parent of the axis. Should either be another axis or 'None'<br><br>        Other axis may be refered to by reference or by name (str). So the following are identical<br><br>            p = s.new_axis('parent_axis')<br>            c = s.new_axis('child axis')<br><br>            c.parent = p<br>            c.parent = 'parent_axis'<br><br>        To define that an axis does not have a parent use<br><br>            c.parent = None<br><br>        |
gx |  | The x-component of the global position vector [m] (global axis )|
gy |  | The y-component of the global position vector [m] (global axis )|
gz |  | The z-component of the global position vector [m] (global axis )|
global_position |  | The global position of the origin of the axis system  [m,m,m] (global axis)|
grx |  | The x-component of the global rotation vector [degrees] (global axis)|
gry |  | The y-component of the global rotation vector [degrees] (global axis)|
grz |  | The z-component of the global rotation vector [degrees] (global axis)|
tilt_x | Read-only | Tilt percentage. This is the z-component of the unit y vector [%].<br><br>        See Also: heel<br>        |
heel | Read-only | Heel in degrees. SB down is positive [deg].<br>        This is the inverse sin of the unit y vector(This is the arcsin of the tiltx)<br><br>        See also: tilt_x<br>        |
tilt_y | Read-only | Tilt percentage. This is the z-component of the unit -x vector [%].<br>        So a positive rotation about the y axis results in a positive tilt_y.<br><br>        See Also: trim<br>        |
trim | Read-only | Trim in degrees. Bow-down is positive [deg].<br><br>        This is the inverse sin of the unit -x vector(This is the arcsin of the tilt_y)<br><br>        See also: tilt_y<br>        |
heading | Read-only | Direction (0..360) [deg] of the local x-axis relative to the global x axis. Measured about the global z axis<br><br>        heading = atan(u_y,u_x)<br><br>        typically:<br>            heading 0  --> local axis align with global axis<br>            heading 90 --> local x-axis in direction of global y axis<br><br><br>        See also: heading_compass<br>        |
heading_compass | Read-only | The heading (0..360)[deg] assuming that the global y-axis is North and global x-axis is East and rotation accoring compass definition|
global_rotation |  | Rotation [deg,deg,deg] (global axis)|
global_transform | Read-only | Read-only: The global transform of the axis system [matrix]|
connection_force | Read-only | The forces and moments that this axis applies on its parent at the origin of this axis system. [kN, kN, kN, kNm, kNm, kNm] (Parent axis)<br><br>        If this axis would be connected to a point on its parent, and that point would be located at the location of the origin of this axis system<br>        then the connection force equals the force and moment applied on that point.<br><br>        Example:<br>            parent axis with name A<br>            this axis with name B<br>            this axis is located on A at position (10,0,0)<br>            there is a Point at the center of this axis system.<br>            A force with Fz = -10 acts on the Point.<br><br>            The connection_force is (-10,0,0,0,0,0)<br><br>            This is the force and moment as applied on A at point (10,0,0)<br><br><br>        |
connection_force_x | Read-only | The x-component of the connection-force vector [kN] (Parent axis)|
connection_force_y | Read-only | The y-component of the connection-force vector [kN] (Parent axis)|
connection_force_z | Read-only | The z-component of the connection-force vector [kN] (Parent axis)|
connection_moment_x | Read-only | The mx-component of the connection-force vector [kNm] (Parent axis)|
connection_moment_y | Read-only | The my-component of the connection-force vector [kNm] (Parent axis)|
connection_moment_z | Read-only | The mx-component of the connection-force vector [kNm] (Parent axis)|
applied_force | Read-only | The force and moment that is applied on origin of this axis [kN, kN, kN, kNm, kNm, kNm] (Global axis)|
ux | Read-only | The unit x axis [m,m,m] (Global axis)|
uy | Read-only | The unit y axis [m,m,m] (Global axis)|
uz | Read-only | The unit z axis [m,m,m] (Global axis)|
equilibrium_error | Read-only | The unresolved force and moment that on this axis. Should be zero when in equilibrium  (applied-force minus connection force, Parent axis)|



## Circles and points

Points and circles are helpers. They define locations (points) or circular geometry (circles) that can be used by other nodes such as cables.

### Point

Points are locations or attachment points. They can be located on a frame, but can also be defined  globally. In that case they fixed in space.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
x |  | x component of local position [m] (parent axis)|
y |  | y component of local position [m] (parent axis)|
z |  | z component of local position [m] (parent axis)|
position |  | Local position [m,m,m] (parent axis)|
applied_force_and_moment_global | Read-only | Applied force and moment on this point [kN, kN, kN, kNm, kNm, kNm] (Global axis)|
gx |  | x component of position [m] (global axis)|
gy |  | y component of position [m] (global axis)|
gz |  | z component of position [m] (global axis)|
global_position |  | Global position [m,m,m] (global axis)|

### Circle

A circle is a disk or hole. A circle is located on a point. It has a diameter/radius and a direction.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
axis |  | Direction of the sheave axis (x,y,z) in parent axis system.<br><br>        Note:<br>            The direction of the axis is also used to determine the positive direction over the circumference of the<br>            circle. This is then used when cables run over the circle or the circle is used for geometric contacts. So<br>            if a cable runs over the circle in the wrong direction then a solution is to change the axis direction to<br>            its opposite:  circle.axis =- circle.axis. (another solution in that case is to define the connections of<br>            the cable in the reverse order)<br>        |
radius |  | Radius of the circle [m]|
global_position | Read-only | Returns the global position of the center of the sheave.<br><br>        Note: this is the same as the global position of the parent point.<br>        |

## Geometric-Contact

Geometric contact can be used to model contact bewteen circlular objects (bars) or circular holes. Examples are a shackle pin 
in a padeye hole (pin-hole connection) or a shackle pin against the bow of another shackle (bar-bar connection).

This is a rigid and unbreakable connection constructed by a clever combination of frames. This means that it is not a connection
with a stiffness (the contact is infinitely stiff). It also means that a geometric contact creates a parent-child relation between the two
connected frames.


    A GeometricContact can be used to construct geometric connections between circular members:
        - 	steel bars and holes, such as a shackle pin in a padeye (pin-hole)
        -	steel bars and steel bars, such as a shackle-shackle connection


    Situation before creation of geometric contact:

    Axis1
        Point1
            Circle1
    Axis2
        Point2
            Circle2

    Create a geometric contact with Circle1 and parent and Circle2 as child

    Axis1
        Point1              : observed, referenced as parent_circle_parent
            Circle1         : observed, referenced as parent_circle

        _axis_on_parent                 : managed
            _pin_hole_connection        : managed
                _connection_axial_rotation : managed
                    _axis_on_child      : managed
                        Axis2           : managed    , referenced as child_circle_parent_parent
                            Point2      : observed   , referenced as child_circle_parent
                                Circle2 : observed   , referenced as child_circle







    
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
child |  | The Circle that is connected to the GeometricContact [Node]<br><br>        See Also: parent<br>        |
parent |  | The Circle that the GeometricConnection is connected to [Node]<br><br>        See Also: child<br>        |
swivel |  | Swivel angle between parent and child objects [degrees]|
swivel_fixed |  | Allow parent and child to swivel relative to eachother [boolean]|
rotation_on_parent |  | Angle between the line connecting the centers of the circles and the axis system of the parent node [degrees]|
fixed_to_parent |  | Allow rotation around parent [boolean]<br><br>        see also: rotation_on_parent|
child_rotation |  | Angle between the line connecting the centers of the circles and the axis system of the child node [degrees]|
child_fixed |  | Allow rotation of child relative to connection, see also: child_rotation [boolean]|
inside |  | Type of connection: True means child circle is inside parent circle, False means the child circle is outside but the circumferences contact [boolean]|