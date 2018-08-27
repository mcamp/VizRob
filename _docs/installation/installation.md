---
title: Installation
permalink: /docs/installation/
---

For now, VizRob only has support to work with SMACH.
To install VizRob and use it with your SMACH project, you first need to download [Pharo](pharo.org).

Then, open the playground and do-it the following code:

```
  Gofer it
    smalltalkhubUser: 'mcamp' project: 'MachineVisualization';
    configurationOf: 'VizRobSMACH';
    loadDevelopment
```