## Open Source - implications and possibilities

The python part of DAVE (The API, Gui, jupyter, exporters, etc) are open-source.
The equilibrium core that is used by DAVE is a commercial component. Equilibrium core can be used for free for educational purposes. 

DAVE will attempt to download the equilibrium-core when starting the GUI.


### DAVE API / GUI / etc.
The DAVE API, gui and jupyter interface are published under the MPL 2.0 license and are written in python.
This means you are free to download the source-code and do pretty much anything with it. It also means that it comes without warranty nor liability. You may change the source-code but you must disclose the changes if you re-distribute it.

Practically this means that you can:
1. tailor DAVE to your own needs
2. add new exporters to DAVE, for example to interface with CAD software or in-house engineering software
3. add new features to DAVE for your own use only
4. add new features to DAVE and make them available for the rest of the world

If you encounter any issues/bugs in the open-source part then the github repository is the place to raise them:

- [DAVE License file](https://github.com/RubendeBruin/DAVE/blob/master/LICENSE)
- [DAVE Source code](https://github.com/RubendeBruin/DAVE)
- [Issue tracker](https://github.com/RubendeBruin/DAVE/issues)

### Equilibrium core

Equilibrium core is the engine driving DAVE. It is the core module that takes care of the geometric calculations, forces and finding equilibrium.

If you already have an application that does this then it is possible to replace the equilibrium-core interface in DAVE with your own.

- [Equilibrium Core](https://www.open-ocean.org/equilibrium-core/)

### What can you do?

You do not have any obligation to give something back to DAVE. Just enjoy it. But if you want to do more then:
- Contributors are welcome.
- Also bugs are valuable. If you encounter any, please report them via the issue tracker so that they can be solved.
- New ideas. Good. If you implement them yourself and create a merge request: even better :-)
- Cases that we can use to further validate DAVE are always welcome.
