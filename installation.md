## Installation

DAVE is a python package (but you do not need to know python to use it).

```{admonition} Elaborate installation instructions
Elaborate installation instructions:
See [open-ocean](https://www.open-ocean.org/dave-installation/)
```

If you already have anaconda or miniconda installed then DAVE can be downloaded and installed from conda-forge using the following command:

```
conda create -n DAVE DAVE -c conda-forge
```

This will install DAVE.

### Equilibrium core

The first time that DAVE runs it will download the equilibrium core. Equilibrium core can be used for free for educational purposes. [link](https://www.open-ocean.org/equilibrium-core/)


### Starting the Gui

The DAVE Gui can be started using

```
activate DAVE
python -m DAVE.run_gui
```

### Jupyter lab

If you wish to use DAVE through Jupyter Lab then the DAVE environment needs to be registered with ipykernel.

```
activate DAVE
conda install ipykernel
ipykernel install --user --name DAVE --display-name "Python (DAVE)"
```

Jupyter Lab can be started using

```
activate DAVE
jupyter lab
```

This will start lab in the current folder.


### Install blender (optional)

Blender is an excellent and free tool for 3d modeling, the artist way. It can be used for creating visuals checking meshes and for rendering DAVE scenes.

Blender can be obtained from [blender](https://www.blender.org/)


