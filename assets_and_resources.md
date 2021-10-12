## Assets and resources

Assets are .DAVE files containing one or more Nodes. These are human readable python files.
Resources are all files that DAVE can use in a model. For example visuals (.obj), hydrodynamic databases but also assets (.DAVE).

### Assets

Re-usable components of a model are typically stored as asset. Assets can be imported into a scene using `import_scene` or via the Library in the Gui.

![Library](./images/asset_library.png)

or they can be used in a `Component` node (Where to save: see {doc}`Components<components>`)

If a model contains many identical parts, it is good practice to save these parts as asset. 

```{admonition} Example:
Consider a 4 point lift with four identical pad-eyes.

Model the padeye:
- First create a single padeye.
- Then save this padeye as asset.

Model the lift:
- Create the lifted object
- Create Component node
- Set the path of the component node to the padeye asset.
- Place the component in the right position
- Duplicate the component for the other three liftpoints
- Import the hook asset.
- Model slings and shackles.
```

To avoid name conflices assets can be imporeted using a pre-fix on the element names.
To enable movement and rotation of the imporeted nodes as a whole it is possible to place all imported elements in a frame (container). This means all positions and rotations are given relative to this frame. Moving and rotating this frame will move/rotate all contained nodes.

### Resources

Some default resources are included with DAVE. These include basic geometric shapes, shackles and the famous DAVE fleet. You can add your own.


### Storage locations


DAVE is designed with use as part of a larger system in mind. In such a system various sources for assets and resources may exist.
For example a shared library with officially approved assets, an library with project assets that are still under construction, a personal folder with the items you are working on at that moment.

On the other hand, DAVE can also be used completely separated from the rest of the world.

Assets and resources are FILES on a file-system somewhere. Assets are files with a .DAVE extension and can be imported into a scene or can be opened as a scene. Resources are all other type of files that may be needed such as .obj or .stl files for visuals or buoyancy, hydrodynamic databases and so on.

A Scene contains a list of locations where assets and resources can be found. This list is in `Scene.resources_paths`. By default it is initialized (in `settings.py`) to

1. the `resources` subdirectory in the DAVE python source folder
2. the `DAVE_models` subdirectory in the users home folder.
3. the current work directory


> Tip: The resource folders are shown in the standard-assets form (see image above)


You are free to add more locations or remove existing locations by either changing the initilization in settings.py for a system-wide change or by changing the `resources_paths` list of the current Scene object.

The order of the list is important.
The list is considered to be ordered from most-official to least-official. So, for the default list, a resource in the `resources` subfolder of the DAVE installation is considered of higher rank than a resource with the same name in the users DAVE_assets folder.

```{admonition} More info:

- For information about python lists see [python documentation](https://docs.python.org/3/tutorial/datastructures.html)
- Python treats backslashes "\" in strings in a special way which can result in unexpected results when you are not aware of that. For example \n means "new-line" and \t means tab. To suppress this simply place a "r" in front of the string.

```python
s = Scene()
s.resources_paths.append(r'c:\data') # append to the end of the list
s.resources_paths.insert(0, r'c:\data\copy_of_very_official_stuff') # insert at top of list
s.resources_paths = [r'c:\master_assets', *s.resources_paths] # alternative to insert on top of list.
```

In a typical workflow an asset would first be created in a local or project folder. Then it would be checked as approved. Once approved it would be moved to an official (write protected) folder.

### Loading and saving resources

The path to a resource can be obtained by putting `res: ` in front of the filename. This will loop over the resources_paths **from top to bottom**. It will return the full path to the first items found. More official assets or resources take precedence over less official ones.


> `res: cube.obj` will resolve to the file cube.obj in the most-official resource folder 

If a resource with the same name is present in both the `resources` directory and the `DAVE_models` directory then a link to the one in the `resources` directory is returned as `resources` is higher in the hierarchy than `DAVE_models`.

When saving resoures the folders are evaluated from bottom to top. The first folder with write access is used to save the item. So this is exactly opposite from loading resources. **A resource is saved in the least official folder.**

It is also possible to load or save resources using the full path. In that case the whole system is circumpassed.

#### Subfolders

The Scene object will *not* walk through sub-folders when looking for an asset or resource. This means that subfolders add to the uniqueness of the filename.
A file called `attempt1/box.obj` is different from a file `attempt2/box.obj`


### Examples

Example 

```python
s = Scene()
filename = s.get_resource_path('res: buoyancy cheetah.obj')  # will return the official buoyancy cheetah.obj

s.save_asset('empty')                 # assets saved in workfolder / empty.dave
s.save_asset('subfolder/empty')       # assets saved in workfolder / subfolder / empty.dave

s.get_resource_path('empty.dave')           #  will return "workfolder / empty.dave_asset"
s.get_resource_path('subfolder/empty.dave_asset') #  will return "workfolder / subfolder / empty.dave"

s.save_asset(r'c:\data\test.abc')     # will save as c:\data\test.abs
```

### Summary

- Scene.resources_paths is a list of paths with locations where resources are located.
- `res:` means look-up a file with this name in the resource folders 
- This list is ordered from Most official to Least official
- If a file with the same name exists in a more official location, then that file gets priority above a file with the same name in a less official location.
- Saving files without specifying the full path will store them in the least official folder
- The resources_paths can be edited either in settings.py or in the Scene object.
