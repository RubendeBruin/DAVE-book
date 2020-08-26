## Configuration

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