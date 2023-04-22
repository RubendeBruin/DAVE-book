# Components

Models often have reoccurring details. For example all the liftpoints on something are often identical.

The "duplicate" option in the GUI makes it easy to model these reoccurring details, but having duplicate data is
in general a bad practice. If the design of the liftpoints changes then all the liftpoints have to be updated manually.

Enter components.

A component is a single node that contains a collection of nodes. The collection of nodes is loaded from a .DAVE file.
Any DAVE model can be a component.

Components are also a great way of including standard-assets in a scene.

```{admonition} Components
Components contain a reference to an other model (file). The contents of that model are loaded
into the current model when the component node .path property is set.  
```

## Make a component

- Start a new model
- Model what you want
- Save the model

Where to save: see {doc}`Assets and resources<assets_and_resources>`

## Use a component 

- Add a `Component` node to the model.
- Set the `path` property of the node to the saved model.


The component node creates a `Frame` into which the imported nodes are placed. This enables placement of the
imported scene and control over its degrees of freedom. 

A component "manages" the nodes in the imported scene. This means that their properties can not be changed (except when exposed, see below).
It *is* possible to reference to the nodes (for example connect a cable to them) or to use them as parent.

### Embedding

The contents of a component are created based on the referenced file. If that file changes then the component will
change as well. So the model containing a component DEPENDS on the referenced files. If they do no longer exist then
the model can not be loaded anymore. If the files have changed then the model will change as well the next time it is loaded.

If this is not the behaviour that you are looking for then a simple solution is to "dissolve" the component.
Dissolving a component evaporates the control over the imported nodes making them part of the current Scene.



## Edit a component

To edit a component you must open the .DAVE file in the GUI, edit it and then save it again.

The contents of `Components` in a scene are re-loaded from the referenced .DAVE file when the node
is created. This can be triggered manually from the file menu (file->reload-components). 
But DAVE also re-creates nodes when using the undo functionality and when internally creating copies of 
a scene for solving or multi-threading.

*TLDR: After updating a component file, use scene->reload-components to update all the depending components.*

## Exposing component properties

The main purpose of component is enabling re-use of (checked and approved) standard components. This is why the nodes in a component can by default not be changed, that would void the QC. 

If editing is needed, then a component can be dissolved. Dissolving a component makes all nodes of the component normal nodes in the scene and removes the connection to the component .dave file that they came from. This means all the components nodes are now in the scene itself and thus uncontrolled.

### .exposed

A less rigorous way is to explicitly define that some of the properties of some of the nodes in a component **can** be changed. This can be done by declaring them as "exposed". This needs to be done by manually adding some python code to the .dave file.

A variable`exposed` needs to be created as property of the scene. This variable is a list or tuple. Every entry in the variable is again a list or tuple with three items:

- An unique description of the property
- The name of the applicable node 
- The name of the applicable property

Consider the following example:

<u>exposed_component.dave:</u>

```python
s.new_point('Point')
s.new_frame('Frame')

s.exposed = list()
s.exposed.append(('Point position',
				  'Point',
				  'x'))
s.exposed.append(('Frame fixed x',  # human description
                  'Frame',          # name of the node
                  'fixed_x'))       # propery 
```

In the Gui a button "edit exposed properties" should become enabled when a component with exposed properties is loaded.

Note that this does not work for components inside components.

The `exposed` property of a scene is maintained when loading/saving. So it is ok to edit a component in the Gui after defining the exposed properties. Note however that (node-names in) the exposed variable are not automatically updated when the name of a node is changed or the node is deleted. 