## Making a hydrodynamic database


A hydrodynamic database contains the first order wave and fluid interaction in the frequency domain. These are typically calculated using a panel method (BEM). DAVE does not include such a solver because these solvers already exists. Examples of available software are:
- WAMIT
- OrcaWave
- Nemoh
- Aqwa
- Moses
- Diffrac
- Capytaine

A freely available BEM solver is [Capytaine](https://github.com/mancellin/capytaine).
Background: [Paper](https://joss.theoj.org/papers/10.21105/joss.01341).

### MaFreDo

DAVE can read hydrodynamic data in the mafredo .dhyd format. [MaFreDo](https://github.com/RubendeBruin/mafredo) is a python package which is automatically installed when you install DAVE. 

### Recipe - capytaine

This snippet show how to create a hydrodynamic database using Capytaine convert it to the mafredo format.
Input is a panel model in .stl format. Output is a .dhyd file which can be used in DAVE.

Step 1: Make hydrodynamic database 

Inspired by: [Capytaine cookbook](https://ancell.in/capytaine/latest/user_manual/cookbook.html)

```python
import logging
import numpy as np
from numpy import pi

import capytaine as cpt
from capytaine.meshes.geometry import Plane

logging.basicConfig(level=logging.INFO, format='%(levelname)-8s: %(message)s')
bem_solver = cpt.BEMSolver()

def make_database(body, omegas, wave_directions):
    # SOLVE BEM PROBLEMS
    problems = []
    for wave_direction in wave_directions:
        for omega in omegas:
            problems += [cpt.RadiationProblem(omega=omega, body=body, radiating_dof=dof) for dof in body.dofs]
            problems += [cpt.DiffractionProblem(omega=omega, body=body, wave_direction=wave_direction)]
    results = [bem_solver.solve(problem) for problem in problems]
    *radiation_results, diffraction_result = results
    dataset = cpt.assemble_dataset(results)

    dataset['diffraction_result'] = diffraction_result

    return dataset


if __name__ == '__main__':

    # -------- Only this part needs to be changed -----:
    omega = [0.01, 0.02, 0.04,0.06,0.08,0.1,0.15, 0.2,0.25, 0.3,0.35, 0.4,0.45, 0.5,0.55, 0.6,0.65, 0.7, 0.8,0.9, 1.0,1.1,1.2,1.4,1.6,1.8,2.0,4.0]
    filename = r"husky_panel.stl"
    name = "vessel_name"
    output = r"husky.nc"
    directions = np.linspace(0,pi,9)

    # ------ till here ------

    boat = cpt.FloatingBody.from_file(filename, file_format="stl", name=name)
    # boat = cpt.RectangularParallelepiped(size=(100, 30, 8), resolution=(40, 12, 8))
    boat.clip(Plane(normal=(0, 0, 1), point=(0, 0, -0.01)))
    boat.add_all_rigid_body_dofs()
    boat.keep_immersed_part()

    boat.show()

    dataset = make_database(body=boat, omegas=omega, wave_directions=directions)
    print(dataset)

    from capytaine.io.xarray import separate_complex_values
    sep = separate_complex_values(dataset)
    sep.to_netcdf(output,
                  encoding={'radiating_dof': {'dtype': 'U'},
                            'influenced_dof': {'dtype': 'U'},
                            'diffraction_result': {'dtype': 'U'}})
```

step 2:

Convert the .nc file to .dhyd

```python
from mafredo import hyddb1
import numpy as np
import matplotlib.pyplot as plt

filename = 'husky'

hyd = hyddb1.Hyddb1()

print('reading data')

hyd.load_from_capytaine(r"{}.nc".format(filename))

plt.subplots(2,3)
for i in range(6):
    plt.subplot(2,3,i+1)
    rao = hyd.force_rao(i)
    rao['amplitude'].plot()
plt.show()

hyd.save_as("{}.dhyd".format(filename))
```

The .dhyd file can not be used in a WaveInteraction Node.

