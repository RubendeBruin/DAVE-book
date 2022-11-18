# Configuration

By default DAVE will try to create a subfolder "DAVE_models" in the users HOME folder (%homepath% in windows,  ~ in linux). This folder will be used for storing temporary files, the log file, and as default save location for assets and models.

DAVE can be configured by changing the settings in the settings.py file or by manually overriding them after importing settings.py and before importing scene.py

```python
from DAVE import *
from pathlib import Path

# override some of the settings
settings.RESOURCE_PATH = [Path(r'c:\data')]
settings.BLENDER_EXEC = r'C:\Program Files\Blender Foundation\Blender\2.83\blender.exe'

# now create the scene
s = Scene()

print(s.resources_paths)
```

All settings are defined in UPPERCASE.

Note: Changing G or RHO has no effect at this moment as these values would also need to be changed in the equilibrium-core

## / or \\

DAVE is multiplatform. It runs fine under windows as well as linux.
Windows uses a \\ in path definitions while linux uses as /.
The python standard [pathlib](https://docs.python.org/3/library/pathlib.html) library is used to deal with paths. In most situations however a string will work fine as well.



## File format

The standard file-format for saving DAVE scenes and nodes is [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) python.

When loading a model or asset from a file into a scene the contents of that file are executed in the python interpreter. In the interpreter a variable `s` is
available which refers to the current scene.

This makes it possible to define DAVE models in a very flexible way as arbitrary code can be executed when importing the model. Importing a model into DAVE is basically the same as running a file, so beware of the involed security implications.