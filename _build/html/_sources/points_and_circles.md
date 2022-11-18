# Points and Circles

In the previous section it was explained that Axis system nodes make up the backbone of the model.

All the other nodes add features. If you think of the scene as a christmas tree, then the axis systems are the tree and all other nodes are the decoration.

But before we can start decorating, there are two helpers that need to be introduced: Points and Circles.

*Points* are 3d locations. They can be located in the world or on an axis. If they are located on an axis than that axis is their parent.

*Circles* are 2d circles. They are always located on a Point which determines where they are. On top of that they also have a radius [m] and an orientation. The orientation of a circle is the direction of its center axis. The direction of the axis also determines the positive direction over the circumference.


![ps1](images/points_and_circles_1.png)

Points and circles do not do change the model directly. They merely define the geometric features that other nodes can use. This means that points and circles can be added to a model without changing the results. This is very usefull when working with standard models. Two examples:


For example a standard barge can have points defined at all its bollards. When loading the barge into a scene the user can connect mooring lines to the bollards that are needed without having to look up what their positions are.

![ps2](images/points_and_circles_2.png)

The standard shackles have circles defining the center of the pin, bow and the inside of the shackle.

![ps3](images/points_and_circles_3.png)


## Gui

Just like with Axis nodes, the parent of Circles and Points can be changed by dragging and dropping in the node-tree.