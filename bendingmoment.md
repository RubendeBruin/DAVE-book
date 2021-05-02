### Shearforce and bending moments

Calculation of the global bending moments and shear-forces in ships is an important part of checking the longitudinal or global strength of a vessel.

For this caluculation a ship is modelled as a single beam with forces acting on it. Typically these forces are cargo, self-weight, ballast and buoyancy.
In DAVE the global bending moments and shear-forces can be calulated for any axis system. Furthermore all loads from all nodes connected to that axis system will contribute to the shear and moment lines. This means that loads from cranes, grounding contact, trailered loads, pilelines are included.

![global_bending_moment]
(images/global_bending_moment1.png)

For the calculation of the global shearforce and bending moments it is important to know at which location or over which length a force is distributed.

#### Where do loads connect?

DAVE distinguishes point loads and distributed loads. 

- Points loads are connected to the nearest point on the moment-line beam.
- Distributed loads are distributed over the portion of the beam bewteen the points on the beam closest to outer points of the distributed load.
- Loads from fluids (buoyancy, tanks) distributes over the area directly above/below it.

the subtle difference beteen the last two is that for normal distributed loads the imaginary line connecting the load and the beam runs perpendicular to the beam while for fluid loads it runs in vertical direction. The effect is that normal distributed loads may add an moment to the beam while fluids loads do not.

![global_bending_moment2]
(images/global_bending_moment2.png)

#### Point loads / distributed loads

Loads are loads resulting from forces on a point, connected axis systems or contact meshes. 

DAVE used the concept of "footprints" to define the area over which loads are distributed.
Footprints are a series of 3d points (vertices) that can be defined on any point or axis. 

The projection of the footprints onto the plane in which the shearforce and moments are calculated determines the extent of the distributed load.
Points and axis nodes for which no footprints are defined result in point loads.


#### Connections, loads from child nodes

Each axis system applies its connection-force on its parent using its own footprint.
The connection force of an axis includes the loads of all child nodes. 

Footprints of nodes are only seen by the parent of a node.

```
#### Transparent / Opaque

Axis systems can be transparent or opaque (non-transparent) to footprints.

- Opaque axis sytems do re-distribute the forces of their children to their own footprints.
- Transparent axis systems transfer the forces and footprints of their child nodes directly to their parent.

This is illustrated in the picture below. This example shows two boxes on top of eachother. The top box is a child of the bottom box.
On the left side the bottom box is opaque. The effect of this is that both the weight of the top box and the bottom box are applied using the footprint of the bottom box.
On the right the bottom box is transparent. The effect is that the footprints of both boxes are applied directly on the moment-beam.

![opaque_transparent]
(images/opaque_transparent.png)

```

references:
- DNVGL Rules for classification: Ships — DNVGL-RU-SHIP Pt.3 Ch.4.  https://rules.dnvgl.com/docs/pdf/dnvgl/ru-ship/2017-01/DNVGL-RU-SHIP-Pt3Ch4.pdf
