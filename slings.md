# Slings

Slings are modelled as a combination of cable and rigid-body nodes:


![image](./images/sling_parts.png)

Cables are used for the eyes and the mid-section of the sling. Rigid-body nodes
are used to model the spliced section.
The mass of the sling is included in the rigidbody nodes.

The length of a sling is defined by the "ultimate" length. That is the length between the
insides of the eyes when the sling pulled tight over pins with a diameter of zero.

![image](./images/sling_length.png)

The stiffness of a sling can be defined either by defined in two ways:

1. By defining the EA - this defines the EA of the wire
2. By defining the total stiffness, this defines the EA/L of the whole system.

Note that in the end EA is leading. Defining the total stiffness is just an alternative way to set the EA. This means
that is the physical length of the sling is changed then EA will remain the same while the total stiffness changes.

More details on stiffness can be found here:

 {doc}`Sling length and stiffness calculations<DAVE-notebooks/sling_length>`

## API

### Sling

|  Property | Read-Only  | Documentation 
|:---------------- |:------------------------------- |:---------------- |
k_total |  | Total stiffness of the sling in kN/m|
length |  | Total length measured between the INSIDE of the eyes of the sling is pulled straight. [m]|
LeyeA |  | Total length inside eye A if stretched flat [m]|
LeyeB |  | Total length inside eye B if stretched flat [m]|
LspliceA |  | Length of the splice at end A [m]|
LspliceB |  | Length of the splice at end B [m]|
diameter |  | Diameter of the sling (except the splices) [m]|
EA |  | EA of the wire of the sling.|
mass |  | Mass and weight of the sling. This mass is discretized  distributed over the two splices [mT]|
endA |  | End A [circle or point node]|
endB |  | End B [circle or point node]|
sheaves |  | List of sheaves (circles, points) that the sling runs over between the two ends.<br><br>        May be provided as list of nodes or node-names.<br>        |

