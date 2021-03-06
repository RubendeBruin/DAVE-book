### Node property reference


#### Axis

Axis

Axes are the main building blocks of the geometry. They have a position and an rotation in space. Other nodes can be placed on them.
Axes can be nested by parent/child relationships meaning that an axis can be placed on an other axis.
The possible movements of an axis can be controlled in each degree of freedom using the "fixed" property.

Axes are also the main building block of inertia.
Dynamics are controlled using the inertia properties of an axis: inertia [mT], inertia_position[m,m,m] and inertia_radii [m,m,m]


Notes:
 - circular references are not allowed: It is not allowed to place a on b and b on a


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
inertia |  | The linear inertia of the axis in [mT] Aka: "Mass"<br>        - used only for dynamics |
inertia_position |  | The position of the center of inertia. Aka: "cog" [m,m,m] (local axis)<br>        - used only for dynamics<br>        - defined in local axis system|
inertia_radii |  | The radii of gyration of the inertia [m,m,m] (local axis)<br><br>        Used to calculate the mass moments of inertia via<br><br>        Ixx = rxx^2 * inertia<br>        Iyy = rxx^2 * inertia<br>        Izz = rxx^2 * inertia<br><br>        Note that DAVE does not directly support cross terms in the interia matrix of an axis system. If you want to<br>        use cross terms then combine multiple axis system to reach the same result. This is because inertia matrices with<br>        diagonal terms can not be translated.<br>        |
fixed |  | Determines which of the six degrees of freedom are fixed, if any. (x,y,z,rx,ry,rz).<br>        True means that that degree of freedom will not change when solving statics.<br>        False means a that is may be changed in order to find equilibrium.<br><br>        These are the expressed on the coordinate system of the parent (if any) or the global axis system (if no parent)<br><br>        See Also: set_free, set_fixed<br>        |
x |  | The x-component of the position vector (parent axis) [m]|
y |  | The y-component of the position vector (parent axis) [m]|
z |  | The y-component of the position vector (parent axis) [m]|
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
applied_force | Read-only | The force and moment that is applied on origin of this axis [kN, kN, kN, kNm, kNm, kNm] (Global axis)<br>        |
ux | Read-only | The unit x axis [m,m,m] (Global axis)|
uy | Read-only | The unit y axis [m,m,m] (Global axis)|
uz | Read-only | The unit z axis [m,m,m] (Global axis)|
equilibrium_error | Read-only | The unresolved force and moment that on this axis. Should be zero when in equilibrium  (applied-force minus connection force, Parent axis)<br>        |
#### BallastSystem
A BallastSystem

The position of the axis system is the reference position for the tanks.

Tanks can be added using new_tank()


technical notes:
- System is similar to the setup of RigidBody, but without the Axis
- The class extends Poi, but overrides some of its properties
- Update nees to be called to update the weight and cog


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
parent |  | Determines the parent of the node. Should be an axis or None|
position |  | Position of the origin of the ballast system. (Parent axis) [m,m,m]|
name |  | |
cogx | Read-only | X position of combined CoG of all tank contents in the ballast-system. (local coordinate) [m]|
cogy | Read-only | Y position of combined CoG of all tank contents in the ballast-system. (local coordinate) [m]|
cogz | Read-only | Z position of combined CoG of all tank contents in the ballast-system. (local coordinate) [m]|
cog | Read-only | Combined CoG of all tank contents in the ballast-system. (local coordinate) [m,m,m]|
weight | Read-only | Total weight of all tank fillings in the ballast system [mT]|
#### Buoyancy
Buoyancy provides a buoyancy force based on a buoyancy mesh. The mesh is triangulated and chopped at the instantaneous flat water surface. Buoyancy is applied as an upwards force that the center of buoyancy.
The calculation of buoyancy is as accurate as the provided geometry.

There as no restrictions to the size or aspect ratio of the panels. It is excellent to model as box using 6 faces. Using smaller panels has a negative effect on performance.

The normals of the panels should point towards to water.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
trimesh | Read-only | |
cob | Read-only | GLOBAL position of the center of buoyancy [m,m,m] (global axis)|
cob_local | Read-only | Position of the center of buoyancy [m,m,m] (local axis)|
displacement | Read-only | Displaced volume of fluid [m^3]|
density |  | Density of surrounding fluid [mT/m3].<br>        Typical values: Seawater = 1.025, fresh water = 1.00<br>        |
#### Cable
A Cable represents a linear elastic wire running from a Poi or sheave to another Poi of sheave.

A cable has a un-stretched length [length] and a stiffness [EA] and may have a diameter [m]. The tension in the cable is calculated.

Intermediate pois or sheaves may be added.

- Pois are considered as sheaves with a zero diameter.
- Sheaves are considered sheaves with the given geometry. If defined then the diameter of the cable is considered when calculating the geometry. The cable runs over the sheave in the positive direction (right hand rule) as defined by the axis of the sheave.

For cables running over a sheave the friction in sideways direction is considered to be infinite. The geometry is calculated such that the
cable section between sheaves is perpendicular to the vector from the axis of the sheave to the point where the cable leaves the sheave.

This assumption results in undefined behaviour when the axis of the sheave is parallel to the cable direction.

Notes:
	If pois or sheaves on a cable come too close together (<1mm) then they will be pushed away from eachother.
	This prevents the unwanted situation where multiple pois end up at the same location. In that case it can not be determined which amount of force should be applied to each of the pois.



|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
tension | Read-only | Tension in the cable [kN]|
stretch | Read-only | Stretch of the cable [m]<br><br>        Tension [kN] = EA [kN] * stretch [m] / length [m]<br>        |
length |  | Length of the cable when in rest [m]<br><br>        Tension [kN] = EA [kN] * stretch [m] / length [m]<br>        |
EA |  | Stiffness of the cable [kN]<br><br>        Tension [kN] = EA [kN] * stretch [m] / length [m]<br>        |
diameter |  | Diameter of the cable. Used when a cable runs over a circle. [m]|
connections |  | List or Tuple of nodes that this cable is connected to. Nodes may be passed by name (string) or by reference.<br><br>        Example:<br>            p1 = s.new_point('point 1')<br>            p2 = s.new_point('point 2', position = (0,0,10)<br>            p3 = s.new_point('point 3', position = (10,0,10)<br>            c1 = s.new_circle('circle 1',parent = p3, axis = (0,1,0), radius = 1)<br>            c = s.new_cable("cable_1", endA="Point", endB = "Circle", length = 1.2, EA = 10000)<br><br>            c.connections = ('point 1', 'point 2', 'point 3')<br>            # or<br>            c.connections = (p1, p2,p3)<br>            # or<br>            c.connections = [p1, 'point 2', p3]  # all the same<br><br>        Notes:<br>            1. Circles can not be used as endpoins. If one of the endpoints is a Circle then the Point that that circle<br>            is located on is used instead.<br>            2. Points should not be repeated directly.<br><br>        The following will fail:<br>        c.connections = ('point 1', 'point 3', 'circle 1')<br><br>        because the last point is a circle. So circle 1 will be replaced with the point that the circle is on: point 3.<br><br>        so this becomes<br>        ('point 1','point 3','point 3')<br><br>        this is invalid because point 3 is repeated.<br><br>        |
#### Circle
A Circle models a circle shape based on a diameter and an axis direction  
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
axis |  | Direction of the sheave axis (x,y,z) in parent axis system.<br><br>        Note:<br>            The direction of the axis is also used to determine the positive direction over the circumference of the<br>            circle. This is then used when cables run over the circle or the circle is used for geometric contacts. So<br>            if a cable runs over the circle in the wrong direction then a solution is to change the axis direction to<br>            its opposite:  circle.axis =- circle.axis. (another solution in that case is to define the connections of<br>            the cable in the reverse order)<br>        |
radius |  | Radius of the circle [m]|
global_position | Read-only | Returns the global position of the center of the sheave.<br><br>        Note: this is the same as the global position of the parent point.<br>        |
#### Connector2d
A Connector2d linear connector with acts both on linear displacement and angular displacement.

* the linear stiffness is defined by k_linear and is defined over the actual shortest direction between nodeA and nodeB.
* the angular stiffness is defined by k_angular and is defined over the actual smallest angle between the two systems.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
angle | Read-only | Actual angle between nodeA and nodeB [deg] (read-only)|
force | Read-only | Actual force between nodeA and nodeB [kN] (read-only)|
moment | Read-only | Actual moment between nodeA and nodeB [kNm] (read-only)|
axis | Read-only | Actual rotation axis between nodeA and nodeB (read-only)|
ax | Read-only | X component of actual rotation axis between nodeA and nodeB (read-only)|
ay | Read-only | Y component of actual rotation axis between nodeA and nodeB (read-only)|
az | Read-only | Z component of actual rotation axis between nodeA and nodeB (read-only)|
k_linear |  | Linear stiffness [kN/m]|
k_angular |  | Angular stiffness [kNm/rad]|
nodeA |  | Connected axis system A|
nodeB |  | Connected axis system B|
#### ContactBall
A ContactBall is a linear elastic ball which can contact with ContactMeshes.

It is modelled as a sphere around a Poi. Radius and stiffness can be controlled using radius and k.

The force is applied on the Poi and it not registered separately.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
can_contact | Read-only | True if the ball ball is perpendicular to at least one of the faces of one of the meshes. So when contact is possible. To check if there is contact use "force"<br>        See Also: Force<br>        |
contact_force | Read-only | Returns the force on the ball [kN, kN, kN] (global axis)<br><br>        The force is applied at the center of the ball<br><br>        See Also: contact_force_magnitude<br>        |
contact_force_magnitude | Read-only | Returns the absolute force on the ball, if any [kN]<br><br>        The force is applied on the center of the ball<br><br>        See Also: contact_force<br>        |
compression | Read-only | Returns the absolute compression of the ball, if any [m]|
contactpoint | Read-only | The nearest point on the nearest mesh. Only defined  |
meshes |  | List of contact-mesh nodes.<br>        When getting this will yield a list of node references.<br>        When setting node references and node-names may be used.<br><br>        eg: ball.meshes = [mesh1, 'mesh2']<br>        |
meshes_names | Read-only | List with the names of the meshes|
radius |  | Radius of the contact-ball [m]|
k |  | Compression stiffness of the ball in force per meter of compression [kN/m]|
#### ContactMesh
A ContactMesh is a tri-mesh with an axis parent
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
trimesh | Read-only | The TriMeshSource object which can be used to change the mesh<br><br>        Example:<br>            s['Contactmesh'].trimesh.load_file('cube.obj', scale = (1.0,1.0,1.0), rotation = (0.0,0.0,0.0), offset = (0.0,0.0,0.0))<br>        |
#### CoreConnectedNode
ABSTRACT CLASS - Properties defined here are applicable to all derived classes
Master class for all nodes with a connected eqCore element
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
name |  | Name of the node (str), must be unique|
#### Force
A Force models a force and moment on a poi.

Both are expressed in the global axis system.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
force |  | The x,y and z components of the force [kN,kN,kN] (global axis)<br><br>        Example s['wind'].force = (12,34,56)<br>        |
fx |  | The global x-component of the force [kN] (global axis)|
fy |  | The global y-component of the force [kN]  (global axis)|
fz |  | The global z-component of the force [kN]  (global axis)|
moment |  | The x,y and z components of the moment (kNm,kNm,kNm) in the global axis system.<br><br>        Example s['wind'].moment = (12,34,56)<br>        |
mx |  | The global x-component of the moment [kNm]  (global axis)|
my |  | The global y-component of the moment [kNm]  (global axis)|
mz |  | The global z-component of the moment [kNm]  (global axis)|
#### GeometricContact

GeometricContact

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
#### HydSpring
A HydSpring models a linearized hydrostatic spring.

The cob (center of buoyancy) is defined in the parent axis system.
All other properties are defined relative to the cob.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
cob |  | Center of buoyancy in parent axis system (m,m,m)|
BMT |  | Vertical distance between cob and metacenter for roll [m]|
BML |  | Vertical distance between cob and metacenter for pitch [m]|
COFX |  | Horizontal x-position Center of Floatation (center of waterplane area), relative to cob [m]|
COFY |  | Horizontal y-position Center of Floatation (center of waterplane area), relative to cob [m]|
kHeave |  | Heave stiffness [kN/m]|
waterline |  | Waterline-elevation relative to cob for un-stretched heave-spring. Positive if cob is below the waterline (which is where is normally is) [m]|
displacement_kN |  | Displacement when waterline is at waterline-elevation [kN]|
#### LC6d
A LC6d models a Linear Connector with 6 dofs.

It connects two Axis elements with six linear springs.

The first axis system is called "main", the second is called "secondary". The difference is that
the "main" axis system is used for the definition of the stiffness values.

The translational-springs are easy. The rotational springs may not be as intuitive. They are defined as:

  - rotation_x = arc-tan ( uy[0] / uy[1] )
  - rotation_y = arc-tan ( -ux[0] / ux[2] )
  - rotation_z = arc-tan ( ux[0] / ux [1] )

which works fine for small rotations and rotations about only a single axis.

Tip:
It is better to use use the "fixed" property of axis systems to create joints.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
stiffness |  | Stiffness of the connector: kx, ky, kz, krx, kry, krz in [kN/m and kNm/rad] (axis system of the main axis)|
main |  | Main axis system. This axis system dictates the axis system that the stiffness is expressed in|
secondary |  | Secondary (connected) axis system|
#### LinearBeam
A LinearBeam models a FEM-like linear beam element.

A LinearBeam node connects two Axis elements with six linear springs.

By definition the beam runs in the X-direction of the nodeA axis system. So it may be needed to create a
dedicated Axis element for the beam to control the orientation.

The beam is defined using the following properties:

*  EIy  - bending stiffness about y-axis
*  EIz  - bending stiffness about z-axis
*  GIp  - torsional stiffness about x-axis
*  EA   - axis stiffness in x-direction
*  L    - the un-stretched length of the beam
*  mass - mass of the beam in [mT]

The beam element is in rest if the nodeB axis system

1. has the same global orientation as the nodeA system
2. is at global position equal to the global position of local point (L,0,0) of the nodeA axis. (aka: the end of the beam)

The scene.new_linearbeam automatically creates a dedicated axis system for each end of the beam. The orientation of this axis-system
is determined as follows:

First the direction from nodeA to nodeB is determined: D
The axis of rotation is the cross-product of the unit x-axis and D    AXIS = ux x D
The angle of rotation is the angle between the nodeA x-axis and D

The rotation about the rotated X-axis is undefined.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
EIy |  | E * Iyy : bending stiffness in the XZ plane [kN m2]<br><br>        E is the modulus of elasticity; for steel 190-210 GPa (10^6 kN/m2)<br>        Iyy is the cross section moment of inertia [m4]<br>        |
EIz |  | E * Izz : bending stiffness in the XY plane [kN m2]<br><br>        E is the modulus of elasticity; for steel 190-210 GPa (10^6 kN/m2)<br>        Iyy is the cross section moment of inertia [m4]<br>        |
GIp |  | G * Ipp : torsional stiffness about the X (length) axis [kN m2]<br><br>        G is the shear-modulus of elasticity; for steel 75-80 GPa (10^6 kN/m2)<br>        Ip is the cross section polar moment of inertia [m4]<br>        |
EA |  | E * A : stiffness in the length direction [kN]<br><br>        E is the modulus of elasticity; for steel 190-210 GPa (10^6 kN/m2)<br>        A is the cross-section area in [m2]<br>        |
mass |  | Mass of the beam in [mT]<br>        |
L |  | Length of the beam in unloaded condition [m]|
nodeA |  | The axis system that the A-end of the beam is connected to. The beam leaves this axis system along the X-axis|
nodeB |  | The axis system that the B-end of the beam is connected to. The beam arrives at this axis system along the X-axis|
moment_A | Read-only | Moment on beam at node A (kNm, kNm, kNm) , axis system of node A|
moment_B | Read-only | Moment on beam at node B (kNm, kNm, kNm) , axis system of node B|
tension | Read-only | Tension in the beam [kN], negative for compression|
torsion | Read-only | Torsion moment [kNm]. Positive if end B has a positive rotation about the x-axis of end A |
torsion_angle | Read-only | Torsion angle [deg]. Positive if end B has a positive rotation about the x-axis of end A |
#### Manager
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
#### Node
ABSTRACT CLASS - Properties defined here are applicable to all derived classes
Master class for all nodes
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
visible |  | |
manager |  | |
name |  | Name of the node (str), must be unique|
#### NodeWithParent

NodeWithParent

Do not use this class directly.
This is a base-class for all nodes that have a "parent" property.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
parent_for_export | Read-only | |
parent |  | Determines the parent of the node. Should be an axis or None|
#### Path
PurePath subclass that can make system calls.

Path represents a filesystem path but unlike PurePath, also offers
methods to do system calls on path objects. Depending on your system,
instantiating a Path will return either a PosixPath or a WindowsPath
object. You can also instantiate a PosixPath or WindowsPath directly,
but cannot instantiate a WindowsPath on a POSIX system or vice versa.

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
#### Point
A location on an axis
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
#### RigidBody
A Rigid body, internally composed of an axis, a point (cog) and a force (gravity)
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
name |  | |
cogx |  | x-component of cog position [m] (local axis)|
cogy |  | y-component of cog position [m] (local axis)|
cogz |  | z-component of cog position [m] (local axis)|
cog |  | Center of Gravity position [m,m,m] (local axis)|
mass |  | Static mass of the body [mT]<br><br>        See Also: inertia<br>        |
#### Scene

A Scene is the nodeA component of DAVE.

It provides a world to place nodes (elements) in.
It interfaces with the equilibrium core for all calculations.

By convention a Scene element is created with the name s, but create as many scenes as you want.

Examples:

	s = Scene()
	s.new_axis('my_axis', position = (0,0,1))

	a = Scene() # another world
	a.new_point('a point')



|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
#### Shackle

	Green-Pin Heavy Duty Bow Shackle BN

	visual from: https://www.traceparts.com/en/product/green-pinr-p-6036-green-pinr-heavy-duty-bow-shackle-bn-hdgphm0800-mm?CatalogPath=TRACEPARTS%3ATP04001002006&Product=10-04072013-086517&PartNumber=HDGPHM0800
	details from: https://www.greenpin.com/sites/default/files/2019-04/brochure-april-2019.pdf

	wll a b c d e f g h i j k weight
	[t] [mm]  [kg]
	120 95 95 208 95 147 400 238 647 453 428 50 110
	150 105 108 238 105 169 410 275 688 496 485 50 160
	200 120 130 279 120 179 513 290 838 564 530 70 235
	250 130 140 299 130 205 554 305 904 614 565 70 295
	300 140 150 325 140 205 618 305 996 644 585 80 368
	400 170 175 376 164 231 668 325 1114 690 665 70 560
	500 180 185 398 164 256 718 350 1190 720 710 70 685
	600 200 205 444 189 282 718 375 1243 810 775 70 880
	700 210 215 454 204 308 718 400 1263 870 820 70 980
	800 210 220 464 204 308 718 400 1270 870 820 70 1100
	900 220 230 485 215 328 718 420 1296 920 860 70 1280
	1000 240 240 515 215 349 718 420 1336 940 900 70 1460
	1250 260 270 585 230 369 768 450 1456 1025 970 70 1990
	1500 280 290 625 230 369 818 450 1556 1025 1010 70 2400

	Returns:

	
|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
kind |  | Type of shackle, for example GP800 [text] |
#### Sling
A Sling is a single wire with an eye on each end. The eyes are created by splicing the end of the sling back
into the itself.

The geometry of a sling is defined as follows:

diameter : diameter of the wire
LeyeA, LeyeB : inside lengths of the eyes
LsplicaA, LspliceB : the length of the splices
Total : the distance between the insides of ends of the eyes A and B when pulled straight.

Stiffness:
The stiffness of the sling is specified by a single value: EA
This determines the stiffnesses of the individual parts as follows:
Wire in the eyes: EA
Splices: Infinity (rigid)
Main part: determined such that total stiffness (k) of the sling is EA/L


  Eye A           Splice A             nodeA part                   Splice B          Eye B

/---------------\                                                                /---------------    |                =============-------------------------------------===============                |
\---------------/                                                                \---------------/

See Also: Grommet


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
length |  | Total length measured between the INSIDE of the eyes of the sling is pulled straight. [m]|
LeyeA |  | Total length inside eye A if stretched flat [m]|
LeyeB |  | Total length inside eye B if stretched flat [m]|
LspliceA |  | Length of the splice at end A [m]|
LspliceB |  | Length of the splice at end B [m]|
diameter |  | Diameter of the sling (except the splices) [m]|
EA |  | Effective mean EA of the sling when eyes are flat [kN].<br>        This is the EA that would be obtained when measuring the stiffness of the sling by putting zero-diameter pins in the eyes and stretching the sling and then using the length between the insides of the eyes.|
mass |  | Mass and weight of the sling. This mass is discretized  distributed over the two splices [mT]|
endA |  | End A [circle or point node]|
endB |  | End B [circle or point node]|
sheaves |  | List of sheaves (circles, points) that the sling runs over bewteen the two ends.<br><br>        May be provided as list of nodes or node-names.<br>        |
#### Tank
Tank provides a fillable tank based on a mesh. The mesh is triangulated and chopped at the instantaneous flat fluid surface. Gravity is applied as an downwards force that the center of fluid.
The calculation of fluid volume and center is as accurate as the provided geometry.

There as no restrictions to the size or aspect ratio of the panels. It is excellent to model as box using 6 faces. Using smaller panels has a negative effect on performance.

The normals of the panels should point *away* from the fluid. This means that the same basic shapes can be used for both buoyancy and tanks. 

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
trimesh | Read-only | |
cog | Read-only | Returns the GLOBAL position of the center of volume / gravity|
cog_local | Read-only | Returns the local position of the center of gravity|
fill_pct |  | Amount of volume in tank as percentage of capacity [%]|
level_global |  | The fluid plane elevation in the global axis system. Setting this adjusts the volume|
volume |  | The volume of fluid in the tank in m3. Setting this adjusts the fluid level|
density |  | Density of the fluid in the tank in mT/m3|
capacity | Read-only | Returns the capacity of the tank in m3. This is calculated from the defined geometry.|
#### TriMeshSource

TriMesh

A TriMesh node contains triangular mesh which can be used for buoyancy or contact


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
#### Visual

Visual

.. image:: ./images/visual.png

A Visual node contains a 3d visual, typically obtained from a .obj file.
A visual node can be placed on an axis-type node.

It is used for visualization. It does not affect the forces, dynamics or statics.

The visual can be given an offset, rotation and scale. These are applied in the following order

1. rotate
2. scale
3. offset

Hint: To scale before rotation place the visual on a dedicated axis and rotate that axis.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
#### WaveInteraction1

WaveInteraction

Wave-interaction-1 couples a first-order hydrodynamic database to an axis.

This adds:
- wave-forces
- damping
- added mass

The data is provided by a Hyddb1 object which is defined in the MaFreDo package. The contents are not embedded
but are to be provided separately in a file. This node contains only the file-name.


|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |

Process finished with exit code 0
