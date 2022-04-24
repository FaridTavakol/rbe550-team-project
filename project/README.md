# Motion Planning Algorithms

## Overview
At the moment, the following graph search algorithms are implemented:
1. Breadth First Search (BFS)
2. Dept First Search (DFS)
3. Dijkstra
4. A*

> :information_source: The algorithms are implemented in C++ and the visualization is done using Python scripts.

---
### Output paths in the graph 
<p float="left">
  <img src="media/1_BFS.png" width="320" />
  <img src="media/2_DFS.png" width="320" />
</p>

<p float="left">
  <img src="media/3_Dijkstra.png" width="320" />
  <img src="media/4_AStar.png" width="320" />
</p>

~~~
Here's the number of cells each algorithm visits before hitting the goal:
  
  * It takes 64 steps to find a path using BFS
  * It takes 33 steps to find a path using DFS
  * It takes 64 steps to find a path using Dijkstra
  * It takes 60 steps to find a path using A*
~~~

---
## High Level View

<p float="left">
  <img src="media/5_Classes.png" width="480" />
</p>



---
## Building

To build from source, clone the latest version from this repository into your catkin workspace and compile the package using

	```bash
	$ cd catkin_workspace/src
	$ git clone https://github.com/emmanuel-logy/motion_planning_algorithms.git
	$ cd ..
	$ catkin_make
	```


---
## Usage

Yet to add . . . 
	
	
---
    
    
---
## For further explanation

Please refer to the docs/Emmanuel_Report.pdf for more detailed explanation
	
	
---
    
