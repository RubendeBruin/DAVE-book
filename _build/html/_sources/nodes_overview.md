# Nodes overview

A short overview of all available node types is given here. You may skip this section if you want.


![nodes_in_gui](images/all_nodes_gui.png)


## Backbone

|  Type | Provides  |
|:---------------- |:------------------------------- |
| `Axis` | An axis system with position and orientation and optionally a parent | 
| `RigidBody` | An Axis with cog and weight  | 


## Geometry

|  Type | Provides  |
|:---------------- |:------------------------------- |
| `Point` | A 3d location | 
| `Circle` | A circle with radius and orientation  | 



## Connectors

Connectors connect two or more nodes and can apply a force on them based on their positions and orientations.

|  Type | Provides  | 
|:---------------- |:------------------------------- |
| `Cable` | A finite length cable with linear stiffness. A cable runs between two Point nodes and can run over multiple pois or circles. A cable may have a diameter.   | 
| `LinearBeam` | A beam connects two axis systems with a linear beam element  |
| `LC6d` | Connects two axis systems with six linear springs. Orientation of the springs is determined by the main axis system  |
| `Connector2d` | Connects two axis systems with two linear springs. Orientation of the springs is determined by shortest distance between the two axis systems |


## Forces

Forces apply a force to a node. The magnitude of the force may depend on the position and/or orientation of the node.

|  Type | Provides  |
|:---------------- |:------------------------------- |
| `Force` | An fixed force and/or moment applied on a Point | 
| `HydSpring` | A linear hydrostatic spring attached to an Axis  | 
| `Buoyancy` | A buoyancy mesh (.obj or .stl) attached to an Axis  |
| `Tank` | A (ballast)tank mesh (.obj or .stl) attached to an Axis  |
| `BallastSystem` | A group of ballast-tanks for which a ballast-plan can be created |

## Contact

Basic elastic contact can be modelled using meshes and contact-balls.

|  Type | Provides  | 
|:---------------- |:------------------------------- |
| `ContactBall` | A ball with a radius and a stiffness |
| `ContactMesh` | A mesh that can contact a contact ball  | 

## Information


|  Type | Provides  | 
|:---------------- |:------------------------------- |
| `Visual` | (Almost) Everything gets better when visualized :-). | 
| `WaveInteraction1` | 1 st order hydrodynamic database | 

## Groups

Nodes or groups of nodes can be "managed" by another node. This makes it possible to standardize common groups of nodes.
For example the nodes that make up a shackle or sling.

|  Type | Provides  |
|:---------------- |:------------------------------- |
| `GeometricContact` | Bar-Bar or Pin-in-hole connections | 
| `Sling` | A sling "splice" with eyes, mass, etc  | 
| `Shackle` | A standard shackle  | 
