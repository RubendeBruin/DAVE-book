# Wind and current

Wind and current loads can be added to a model by defining:
- wind/current areas
- wind speed
- wind direction
- air density
- current speed
- current direction
- water density

Wind and current areas are nodes. All the others are general settings of the Scene.
**directions** is defined as *going to* in [deg] relative to the positive x-axis.

![direction](images/wind_current_direction.png)

Wind speed and direction are constant.

The force acts in the direction of the wind/current and is equal to:

$Force = {1 \over 2} * \rho *  Cd * A_e * V^2$



## Cd

Cd is the drag coefficient is a fixed coefficient and is user-provided. Typical values are 1.2 for a wire, 0.4 for a
sphere, 2.0 for a flat plate perpendicular to the wind.

## Effective Area

The effective area is a combination of an area (A) and the orientation of that area relative to the wind/current.

The area **A** [m2] is fixed and user-defined. 

The effective area $A_e$ is calculated from the area and its orientation relative to the wind/current. In general
$A_e = A_0 * |sin(\alpha)|$ where the term $\sin(\alpha)$ accounts for the orientation of the area
relative to the wind/current direction. It is 1 if the wind/current is perpendicular
to the surface and 0 if it is parallel.

The orientation of the surface can be defined in three ways:

**No orientation**

The area is the same from any direction:

$$
   A_w = A
$$

This is the case for spheres.

**Plane orientation**

The area is a flat plane. The direction of the node is the normal of the plane:

$$
   A_w = A * |d_{wind} . d_{plane}|
$$

The area is zero if the wind/current is perpendicular to the defined direction.

**Cylindrical orientation**

The area is constant around one axis, but plane-like about an axis perpendicular to that.
In this case the direction defines the axis about which the area is constant (ie: the center-axis of the cylinder).

$$
    Aw = A * \sqrt{ 1 - (d_{wind} . d_{plane})^2 }
$$

   The effective area is zero if the wind/current is parallel to the defined direction.


![direction](images/wind_area_orientations.gif)

## Notebooks

 {doc}`Wind demonstration<DAVE-notebooks/wind>`

## References:

- DNV-RP-C205 : ENVIRONMENTAL CONDITIONS AND ENVIRONMENTAL LOADS
