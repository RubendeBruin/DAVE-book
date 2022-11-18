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

A component "manages" the nodes in the imported scene. This means that their properties can not be changed.
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