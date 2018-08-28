---
title: Examples
permalink: /docs/examples/
---

We have an example directly taken from the book [ROS by Example Volume 2](https://github.com/pirobot/rbx2):
The [Clean House Task](https://github.com/pirobot/rbx2/blob/indigo-devel/rbx2_tasks/nodes/clean_house_smach.py)
In this task, a robot moves from one room to another while cleaning them.

We run this example and we serialize the visualization using [Fuel](https://rmod.inria.fr/web/software/Fuel).
You can find the serialized file in [here](https://github.com/mcamp/VizRob/blob/master/examples/clean_house_rbx2.fuel).

After [installed](../installation) VizRob and downloaded the fuel file, you should open a Playground and *inspect* the following code (ctrl+i): 

```
  FLMaterializer materializeFromFileNamed: '<complete path of file>'
```

After that, you will see something like this:

![Example Behavior]({{ "/img/vizrob/clean_house_rbx2.png" | absolute_url }} "Example Behavior")

Now you can click on any state and switch to the other visualizations.
Look into this behavior and see what you can find!