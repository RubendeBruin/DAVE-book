# Scene and nodes
A node is an item or element in a model. For example a ship or a force.
A Scene is a collection of nodes.

The common way of working is as follows:

1. Create a scene
2. Add nodes to it

Nodes are added to the scene using .new_nodetype() where nodetype is the type of the node. Each node has a unique name. This is always needs to be provided to the .new_node function.
A complete list of node types and corresponding functions is provided later.

```python
s = Scene()                               # create an empty scene
s.new_point('point 1')                      # creates a poi with name anchor
s.new_point('point 2', position = (10,0,0)) # create a second poi at x=10
s.new_cable('line',endA = 'point 1', endB = 'point 2')
	  # creates a cable between the two points
s.save_scene(r'test.dave')              # save to file
```

Nodes in a scene can be referenced by either name or by reference.
The .new_nodetype() functions return a reference to the newly created node.

```python
s = Scene()
a = s.new_axis('axis')
	# a is now a reference to node 'axis'

p1 = s.new_point('poi_1', parent = a )       # refer by reference
p2 = s.new_point('poi_2', parent = 'axis' )  # refer by name
```

A reference to a node can also be obtained from the scene using square brackets:

```python
s = Scene()
s.new_axis('axis')

a = s['axis']
print(a.position)
```


## Scene

Apart from methods to create nodes, Scene also harbours functionality to delete, import, re-order and export nodes.

### Creating scenes

A Scene is not a singleton. Multiple scenes can exist next to eachother.

A new and empty Scene can be created as follows:

```python
s = Scene()
```

 where `s` can be anything, for example `my_scene` but s is nice and short which is usefull as it will be used a lot.

 Optionally a filename can be provided to the constructor. In that case that file will be imported.
 
```python
my_vessel = Scene('path/to/my_vessel.dave')
```

It is also possible to create a (deep) copy of a scene. This is done as follows:

```python
copy_of_scene = Scene(copy_from = other_scene)
```


## Adding content

Nodes can be added to the scene using the s.new_point, s.new_axis, etc.. functions which were introduced in the previous section.


Multiple nodes can be imported from file or directly from another Scene object using `Scene.load_scene()` or `Scene.import_scene()` respectively.

Note: Beware of name-conflicts when importing. The `Scene.import_scene` provides the option to add a prefix to names of imported nodes.


### Access nodes

A list of nodes is maintained as the ._nodes property of a scene. It is advised not to use this directly.

Obtaining a reference to a single node can be done using its name:

```python
node = s['node_name']
```

This is the reason why all node names should be unique. To get a list of all available node names use `Scene.print_node_tree()`

It is also possible to:

- Get all nodes of a type, use : `Scene.nodes_of_type()`
- Get all nodes that depend on a node : `Scene.nodes_depending_on()`
- Get all child nodes : `Scene.nodes_with_parent()`

## Deleting nodes

Removing nodes can be tricky due to nodes depending on eachother. For example deleting a poi which is also used a endpoint for a cable will cause problems for that cable.
The same applies to axis systems with nodes on it (children)

`Scene.clear()` can be used to delete all nodes from a scene.

To delete a single node there are two options:

1. `Scene.delete(node)`. This deletes a node from the scene. All nodes that depend on this node will be deleted as well.
2. `Scene.dissolve(node)`. This "evaporates" the node. Attempts to maintain child nodes. Often used in combination with the containerize option of `Scene.import_scene`

## Saving or exporting

The standard file-format for saving DAVE scenes and nodes is [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) python.

The contents of a Scene can be save using `Scene.save_scene(filename)`. The python code to re-create the scene can be obtained using `Scene.give_python_code()`.

## Solving

Solving static equilibrium is done using `Scene.solve_statics()`. If there is a static equilibrium condition then this function will attempt to find it by changing the non-fixed degrees of freedom of the scene.

## Optimalizations

A goal-seek function is available: `Scene.goal_seek()`.