---
title: VizRob & SMACH
permalink: /docs/smach/
---

To use VizRob with [SMACH](http://wiki.ros.org/smach), after [installing it](../installation), you have to click anywhere and open `VizRob SMACH UI`

Then, fill the text fields with the name of the topics for the structure and the status update of your SMACH project.
To have access to those topics, remember to active the [Introspection Server](http://wiki.ros.org/smach/Tutorials/Smach%20Viewer#Creating_an_Introspection_Server)

When you are ready to recollect data (via the execution of your program or a ROS bag), you can proceed by click the *Start* button.

To stop recollecting data, you can click the *Stop* button. 
VizRob SMACH should stop when there is node that publish to the status update topic. 
However, this feature is not well tested, so use it with caution.

To open the visualization, after stop the recollection of data, you can click the *Open* button and navigate in VizRob.

![SMACH UI]({{ "/img/vizrob/smach_ui.png" | absolute_url }} "SMACH UI")
