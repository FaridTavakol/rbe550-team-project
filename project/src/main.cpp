/**
 * This module contains the main function
 */

//#include "ROSLogistics.hpp"
#include "Environment.hpp"
#include "Planner_RRT.hpp"
#include <list>
#include <iostream>
using namespace std;
using namespace motion_planning;

int main(int argc, char **argv)
{
//	ros::init(argc, argv, "hw1_basic_search_algo", ros::init_options::AnonymousName);

	/*
	 * c1		c2
	 * 	#########  	- - - x  m_grid(y,x)
	 * 	#		#  	|
	 *  #		#  	|
	 *  #########	y
	 * c4		c3
	 */

	// Creating Environment.... coordinates in terms of (y,x) from top to bottom since its matrix
	Environment env(25,25);
	env.add_obstacle(Eigen::Vector2i(5,10),4,4);
	env.print();


	// Start planner
	const Eigen::Vector2i start {3,12};
	const Eigen::Vector2i goal {24,2};
	vector<list<Eigen::Vector2i>> paths;
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
		env.add_path(paths.at(0), 201);	// use 201 and above for showing raw_paths
		env.add_path(paths.at(1), 501);	// use 501 and above for showing raw_paths
	}
	else
	{
		cout << "Not Found" << endl;
	}

	env.print();

//	/* This starts the ROS server to serve different algo etc */
//	motion_planning::ROS_Logistics rosObj();

    return 0;
}

