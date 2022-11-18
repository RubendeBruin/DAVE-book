# Dynamics

DAVE thinks it can do frequency domain dynamics, but this is still in beta.

```{admonition} Blog post
A short validation for pendulums is given on open-ocean:
See [open-ocean](https://www.open-ocean.org/pendulums/)
```

<iframe width="560" height="315" src="https://www.youtube.com/embed/mWC9Gd0aSmo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

First rule when adding dynamics to DAVE was that it should not make static calculations more difficult. Therefore the properties that are only important for dynamics (inertia mainly) are a bit hidden. In the Gui they only become visible in the mode-shapes screen. This screen contains a widget where the inertia and inertia radii can be edited. By default the inertia is set to the static weight.

The corresponding properties are `inertia_position`, `inertia_radii` and `inertia` of the Axes node.


## Mass and inertia
Internally DAVE does not support inertia matrices. All inertia is lumped into point-masses. Each Axis node contains 6 pointmasses that represent the inertia matrix. The properties of these pointmasses are controlled using the beforementioned properties of the Axis node.

This automatically implies that the radii can not be set to physically impossible combinations. It is for example not possible to set rxx=1m, ryy=1m and rzz = 10m  (do you understand why?).

## Getting the matrices

The inertia and stiffness matrices are derived numerically using a given displacement.

- `s.dyanamic_M(delta)` gives the inertia matrix
- `s.dyanamic_K(delta)` gives the stiffness matrix
- `s.dynamics_modes()` gives the modes corresponding to the rows/colums of the matrices
- `s.dynamics_nodes()` gives a list of nodes corresponding to the rows/colums of the matrices


## Notebooks

{doc}`Dynamic matrices<DAVE-notebooks/dynamics>`

