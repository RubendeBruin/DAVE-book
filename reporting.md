# Reporting

Designing something awesome is fun. But there comes a time when you need to report and document what you did and how you did it. This is often one of the weak points of programs with a GUI. They can produce large tables and reports with data, but it is very hard to distinguish between data that you entered, data that was solved and data that was already there.

Reporting in DAVE is done differently.

<iframe width="560" height="315" src="https://www.youtube.com/embed/J4DVHOhyvvE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Instead of producing an overflow of tables and files, DAVE gives you the option to document data that went into the design and then what was done with that data. This makes report much shorter and easier to contol.

This way of working is because every action in the DAVE gui has a corresponding python command. These command can be entered direcly in a jupyter notebook to re-create your model. This allows you to document the proces rather than the resulting model.

It is a bit like recording a macro in excel but then 30 years into the future.

The Jupyter interface of DAVE provides the following options to document and illustrate the model:

```python
from DAVE.jupyter import *
```

|  Function | Does
|:---------------- |:------------------------------- |
| view(s)			| creates an interactive 3D view of the model |
| show(s)           | creates a static 3D image of the model |
| report(node)      | reports all properties of that node |
| report(node, x )  | reports only property x of node |
| s.print_node_tree() | display of all nodes in the scene |

A small present for those who read the manual:

![present](images/reporting_1.png)
 This button copies the code to include the current 3D view into jupyter.


It is also possible to open the Gui from the notebook.

And of course you can leverage all exisitng jupyter and python functionality such as pandas, matplotlib, pdf export etc.

## Notebooks
 {doc}`Reporting demonstrations<DAVE-notebooks/Reporting node properties>`

