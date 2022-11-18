# Solving static equilibrium

We have now covered how to create the structure (tree) of a model and how to decorate it with nodes. Time to move to the static solver.

DAVE's static solver tries to bring the model to a state with force and moment equilibrium. But what is the "state"? Which parts of the model can move and how can they move?

![solving1](images/solving_1.png)

The position and orientation of each and every Axis in the model is defined using six numbers. Three for the position and three for the orientation. Each of these six components can be either "fixed" or "free" (not fixed). Any free component becomes a degree of freedom of the model. The numerical values for these degrees of freedom will be determined by the static equilibrium solver.

```{admonition} Degrees of Freedom
The solver finds the numerical values for the positions and orientations of axis nodes that are not fixed
```

By default the position and orientation of an axis node are fixed.

Note that only the positions and orientations of Axis type nodes can be released. For all other node types this is not possible. They will either move with their parent (axis) or will not move at all.


## Example

The following example models a piano suspended from a skyhook.

![solving2](images/solving_2.png)

- The skyhook is a Point without a parent. This means it is a point that is fixed to the world.
- The piano is an Axis node
- The cog of the piano is modelled by placing a Point on the piano (the parent of center of gravity is piano)
- Gravity is modelled by applying a force node on the cog
- The liftpoint on the piano is modelled using another point on the piano node.
- The lifting wire is modelled using a Cable node between the skyhook point and the liftpoint node. The cable is given a length and stiffness.


You can create this model by copy-pasting the following python code into the Gui and executing it.

![solving2](images/solving_copy_paste.gif)


```python

s.clear()

s.new_point(name='sky_hook',
          position=(2.0,1.0,4.0))

s.new_axis(name='Piano')

s.new_point(name='liftpoint',
          parent='Piano',
          position=(1.0,1.0,0.0))

s.new_point(name='center of gravity',
          parent='Piano',
          position=(0.0, 0.0, 0.0))

s.new_cable(name='Cable',
            endA='liftpoint',
            endB='sky_hook',
            length=5.0,
            EA=10000.0)

s.new_force(name='Force',
            parent='center of gravity',
            force=(0.0, 0.0, -3.0),
            moment=(0.0, 0.0, 0.0) )
```

As you can see this model is not in static equilibrium. Or is it?

Statics can be solved by pressing the yellow "Solve Statics" button on the top-left of the viewport. Pressing this button will show a "No degrees of freedom - nothing to solve" message.
This does not mean that the model is not in equilibrium. It just means that the model is not what we expect it to be. In this case the piano has all its degrees of freedom set to Fixed. This means that the origin of the piano node is fixed to the world. A force and moment can be present in the connection between the piano and the world. And in fact there are: 

![solving3](images/solving_3.png)

To model a free haning piano we need to release this connection. As expected this is done by unchecking the "fixed" settings for all degrees of freedom of the piano node.

![solving2](images/solving_solve_6dof.gif)

### What just happened?

The static solver of DAVE just brought the model to a static equilibrium.
The new X and Y positions of the origin of the piano node were changed to 2.0 and 1.0, bringing the cog of the piano right below the skyhook.
Also the piano rotated such that the liftpoint is now located in line with the cog and the skyhook.
Finally the piano fell down a bit. The vertical displacement is such that the stretch in the cable is such that the tension in the cable due to stretch equals the gravity force on the piano. Changing the stiffness or length of the cable and solving again will result in a different Z value.

```{admonition} Uniqueness
A model may have more than a single equilibrium condition. In this particular example the piano can rotate under its liftpoint. Any rotation in that direction is an equilibrium position as well.

Also the situation where the piano is upside-down with its cog right above the liftpoint is an equilibrium situation. DAVE tries its best to find the most logical stable equilibrium situation based on the start conditions.
```

```{admonition} Existence
It is also possible that a model does not have an equilibrium position at all. Try removing the cable from the model and solving statics.... In such cases the undo button next to the solve-statics button comes in handy.
```







