# Orcaflex

Orcaflex [orcaflex](https://www.orcina.com/orcaflex/) is a well known dynamic analysis package offering myriad options.

As many concepts in DAVE and Orcaflex are identical it is relatively straight forward to export a DAVE model to orcaflex. Expection are the nonlinear fluid nodes (tanks, buoyancy shapes) that DAVE has. These need to be linearized before exporting.

Orcaflex has its own static solver. However it is more geared towards speed than stability. It is easy to find a model that DAVE solves correctly but does not converge or converges to an unwanted static equilibrium in orcaflex. It may therefore be a real time-saver to solve statics in DAVE and than export the solved model to orcaflex. When orcaflex is presented with a model that is already in static equilibrium the program will accept that.



DAVE can export directly to orcaflex .yml files. This means orcaflex itself is not needed for the export.

Some nodes have a 1-on-1 counterpart in orcaflex. Examples are Axis, Bodies, Linear Hydrostatics, Beams, cables (exluding cable-to-circle contact) and Wave Interaction. These nodes can be exported directly to orcaflex.
Other nodes such as shape based buoyancy, tanks and contact meshes need to be converted before they can be exported.

## How to export

Exporting a dave model to orcaflex .yml is done as follows:

```python
from DAVE.orcaflex import *
export_ofx_yml(s, r'c:\data\orcaflex_model.yml')  # s is the Scene 
```

any .obj files used in visuals will be copied to the same folder as the .yml file.

From the Gui: file -> export -> orcaflex


## Example notebooks

- {doc}`3-point lift static equilibrium validation<DAVE-notebooks/crossvalidate_ofx_3plift>`
- {doc}`15-body constrains validation<DAVE-notebooks/crossvalidate_ofx_Snake15>`
- {doc}`Barge hydrostatics validation<DAVE-notebooks/crossvalidate_ofx_barge_heel_trim>`
- {doc}`Calculated RAO validation<DAVE-notebooks/crossvalidate_ofx_dynamics>`


## Geometry

### Axis, RigidBody

Converted to a 6D buoy except if they have a LinearHydrostatics node as one of their childen. In that case they are exported as vessel.
If an axis is partially fixed to a parent then a constraint is used model the partial connection.

### Points, Circles

Orcaflex does not have the concept of Points. Points and Circles are therefore exported as part of the nodes using them.

### Geometric contact

Below the surface geometric contacts are just a couple of cleverly combined axis systems. This means they are exported.


## Connectors

### Cable

Cables are exported as winches. 

[TODO]
Cables running over circles are not supported by orcaflex and are not exported.

### Beams 

Linear beams are exported as orcaflex lines.

- The diameter (buoyancy) for lines in orcaflex is set to a small number
- In orcaflex lines run along the Z axis while in DAVE they run along the X axis. Therefore DAVE.EIy --> orcaflex.EIx and DAVE.EIz --> orcaflex.EIy


## LC6D [TODO]

Linear connectors with 6 degrees of freedom are exported as a set of six linear springs and constraints.
This is not an exact representation (there is a sin(angle) term instead of a tan(angle) term) but is fine for small angles and displacements.

## Connector2d  [TODO]

Normally one would model such a connector in orcaflex using a contraint with stiffness.
This is however only possible if the connector happens to connect a parent and a child node.

If this is not the case then 
- The displacement part is exported as a spring.
- The rotational part is exported as a line with a single segment

## Forces

### Force [TODO]

Exported a applied load on the parent element


## BallastSystem

BallastSystems are exported as a 6D buoy containing the cog and inertia of the collection of tanks.

## HydSpring

Linear Hydrostatics Exported as vessel-type stiffness

## Buoyancy

Shape based buoyancy is not supported by any Orcaflex element and then therefore not be exported.

Work-around: Use the linearize_buoyancy function from DAVE.marine to convert this Buoaycy nodes to HydSpring nodes before exporting.

## Tank

Not supported by Orcaflex.

Work-around: Convert to RigidBody, but impossible to keep both the inertia and the free surface effect


## WaveInteraction1

1 st order hydrodynamic database is exported to an orcaflex vessel-type but only if the parent is converted to a vessel.

In practice this means that to export a vessel from DAVE to orcaflex you need to have a RigidBody with both a HydSpring and a WaveInteraction1 is childen.


## Contact [TODO]

The contact systems work differently.

TODO

## Rigging items

### Sling

A sling is a combination of rigidbodies and cables. 

TODO:  This is exported as long as the sling does not contact any circles.

### Shackle

A shackle is a combination of axis and visuals.
However the visuals are often scaled which is not supported by Orcaflex. This means the visual may be wrong. But the underlaying structure is correct.

## Visuals

Visuals based on .obj files that are not scaled or rotated are exported as shape.
For performance reasons the objs are not used to export to wire-frame mode.

TODO: offsets as position





