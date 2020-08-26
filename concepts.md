## General

### Terminology

A model in DAVE is called a Scene.
Elements/parts of a model are called Nodes.

So Nodes are placed in a Scene to model something.

Groups of nodes can be saved as an Asset. This is then a re-usable building block.


### Axis systems

Axis systems are right-handed.

In the global axis system the Z-axis points up.

The mean sea-surface is defined as Z=0

### Units

The default unit system is m, kN, mT (metric tonne).
G and RHO are defined accordingly.

### Rotations

Unfortunately there is no standard way of defining rotations in 3D.

DAVE uses a [rotation vector](https://en.wikipedia.org/wiki/Axis%E2%80%93angle_representation#Rotation_vector) to represent rotations.
This means that the rotation is defined as a vector with three components (rx,ry,rz). The magnitude of the vector is the rotation in degrees.
The axis of rotation is the direction of the vector.

Some examples:

- `(0,0,90)` : A rotation of 90 degrees about the Z-axis
- `(0,-10,0)` : A rotation of -10 degrees about the Y-axis
- `(10,10,0)` : A rotation of sqrt(10^2 + 10^2) about the (1,1,0) axis.

Hint: If euler angles are needed then axis systems can be stacked to obtain the same result.


#### 2D rotations

The following 2D rotations are available: tilt_x, tilt_y, heel, trim, heading and heading_compass. These are derived from the
projection of one of the local axis onto the global axis system.
For example the tilt about the x-axis is derived from the z-component of the y-axis.

Example:
	A 3d rotation of (5,0,0) will give a heel of 5 degrees and a tilt_x of 8.7%
	A 3d rotation of (0,0,120) will give a heading of 120 degrees and a heading_compass of 330.


#### / or \\

DAVE is multiplatform. It runs fine under windows as well as linux.
Windows uses a \\ in path definitions while linux uses as /.
The python standard [pathlib](https://docs.python.org/3/library/pathlib.html) library is used to deal with paths. In most situations however a string will work fine as well.


### File format

The standard file-format for saving DAVE scenes and nodes is [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) python.

When loading a model or asset from a file into a scene the contents of that file are executed in the python interpreter. In the interpreter a variable `s` is
available which refers to the current scene.

This makes it possible to define DAVE models in a very flexible way as arbitrary code can be executed when importing the model. Importing a model into DAVE is basically the same as running a file, so beware of the involed security implications.