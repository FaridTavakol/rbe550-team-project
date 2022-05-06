/**
 * This module contains the main function
 */

#include "ROSLogistics.hpp"
#include "Environment.hpp"
#include "Planner_RRT.hpp"
#include <list>
#include <iostream>
#include </usr/include/eigen3/unsupported/Eigen/CXX11/Tensor>

using namespace std;
using namespace motion_planning;

int main(int argc, char **argv)
{
//	ros::init(argc, argv, "needle_steering");
	/* This starts the ROS server to serve matlab client req */
//	motion_planning::ROS_Logistics rosObj;

	/*
	 * c1		c2
	 * 	#########  	- - - x  m_grid(y,x)
	 * 	#		#  	|
	 *  #		#  	|
	 *  #########	y
	 * c4		c3
	 */

/*
    // Trying 3D
	Eigen::Tensor<int, 3> a(2,2,4); 		// input 3D map (x,y,z) --> (col,row,page)
	a.setZero();
	a(0,0,0) = 1;
	a(0,0,1) = 2;
	cout << a << endl;
	Eigen::array<Eigen::Index, 3> offsets = {0, 0, 0};
	Eigen::array<Eigen::Index, 3> extents = {2, 2, 2};
	auto b = a.slice(offsets, extents);
	cout << "Sliced: \n:" << b << endl;

//	Eigen::Tensor<int, 3> c(2,2,2);
	b.setConstant(99);
	cout << "Final: \n:" << a << endl;

*/

	// Creating Environment.... coordinates in terms of (y,x) from top to bottom since its matrix
	Environment env(25, 25, 25);
	env.add_obstacle(Eigen::Vector3i(5,10,5),2,2,2);
//	env.print();


	// Start planner
	const Eigen::Vector3i start {0,0,0};
	const Eigen::Vector3i goal {8,8,3};
	vector<list<Eigen::Vector3i>> paths;
	int steps;

	double goal_bias = 0.1;
	double goal_region = 1.4;
	double nn_region = 4;
	int max_itr = 500;
	Planner_RRT planner(goal_bias, goal_region, nn_region, max_itr);
	if (planner.search(&env, start, goal, paths, steps))
	{
		cout << "Found" << endl;
		cout << steps << endl;
		for (auto& i : paths.at(0))
		{
			cout << i << endl << endl;
		}
//		env.add_path(paths.at(0), 201);	// use 201 and above for showing raw_paths
//		env.add_path(paths.at(1), 501);	// use 501 and above for showing raw_paths
	}
	else
	{
		cout << "Not Found" << endl;
	}

//	env.print();


    return 0;
}

