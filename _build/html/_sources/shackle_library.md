# Shackle library

The `Shackle` node and the `RiggingString` node can both be used to model shackles.

The list of available shackles is located in in .csv file named `shackle data.csv` and located in resources folder of the DAVE installation. Shackles can be added or removed from this list. The list is loaded when DAVE starts, so changes will only take effect after restarting DAVE.

The columns in the .csv are as follows:

```
Name,Description,WLL,weight,pin diameter,bow diameter,inside length,bow inside diameter,visual,visual scale,,,
```

- Name is the unique identifier for the shackle kind

- Description can be anything and is used in reporting

- WLL is the working load limit or SWL - it is noted that the SWL my differ based on the use of the shackle.

- weight in in [kg]

## Dimensions

- pin diameter in [mm] : D

- bow diameter [mm] : G

- inside length [mm] : H

- bow inside diameter [mm] : 2*K

![image-20221104095532140](images/image-20221104095532140.png)

## Visual / visual scale

The combination of the visuals and a scale is used to enable working with a single visual file for multiple sizes of shackles. Note that this may result in slightly off visuals as not all shackle dimensions scale equally.

The visual shall be oriented and positioned such that the centerline of the shackle pin follows the x-axis and the shackle bow points upwards (z):

![image-20221104100314561](images/image-20221104100314561.png)

