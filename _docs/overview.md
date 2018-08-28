---
title: Visualizations Overview
permalink: /docs/overview/
---

VizRob presents several visualizations to understand based-behavior robots.
Each of the visualizations are accessible via tabs at the top of VizRob.

Moreover, each of the visualizations are interactive in nature: you can click on the elements of the visualization to see more detailed information of that specific element. 
For example, clicking on a state with a nested machine reveals the nested structure.
In this new section, you can again see all the VizRob visualizations on their tabs, but now they are specific to the clicked state.

You can keep going deep in your behavior.
With this, you won't miss any details of what your robot is doing!

## Static View

The static view visualization represents the machine as a graph. Nodes represent states and directed edges are their transitions. A green border around a state indicates the presence of a nested machine. The machine name is located on the top-left corner.

![Static View]({{ "/img/vizrob/static.png" | absolute_url }} "Static View")

## Types of Logs

The types of logs visualization associates states to the severity of anomalies found in the logs. States are represented as a box to which metrics are vertically and horizontally mapped: the height of a box represents the execution time, and the width represents the number of logs produced on that state.

In this visualization, states are yellow when there is at least one warning log in a state. States with at least one error log are red. When there are warnings and errors logs in the state, red has priority over the yellow. The default color for no warning or error log is gray.

![Type of Logs]({{ "/img/vizrob/typeLogs.png" | absolute_url }} "Type of Logs")


## Error Logs

In this visualization, the number of log errors emitted from the execution of a state is linearly mapped to a gray-to-red fading. 
A red box indicates the state that emitted the largest number of error logs, while a gray state is the state with the least number of error logs.

![Error Logs]({{ "/img/vizrob/errorLogs.png" | absolute_url }} "Error Logs")

## Coverage

The coverage visualization only shows states that were executed in the behavior.

![Coverage]({{ "/img/vizrob/coverage.png" | absolute_url }} "Coverage")

## Frequency

The frequency visualization represents the number of times a state is executed using a white-to-black fading.
A state is colored black if has many executions and it is colored light-gray with very few executions.

![Frequency]({{ "/img/vizrob/frequency.png" | absolute_url }} "Frequency")

## Logs & Sources

Finally, clicking on a state lists all the logs associated to the state.
The list of logs offers the classical navigation and filtering options found in common debug tools.

VizRob also offers a visualization of the sources where logs are produced.
The source of a log is represented by the line of code in the program where the log is produced.
This visualization is similar to the log visualization.

![Log]({{ "/img/vizrob/log.png" | absolute_url }} "Log")