

# File format

The standard file-format for saving DAVE scenes and nodes is [vanilla](https://en.wikipedia.org/wiki/Vanilla_software) python.

When loading a model or asset from a file into a scene the contents of that file are executed in the python interpreter. In the interpreter a variable `s` is
available which refers to the current scene.

This makes it possible to define DAVE models in a very flexible way as arbitrary code can be executed when importing the model. Importing a model into DAVE is basically the same as running a file, so beware of the involed security implications.