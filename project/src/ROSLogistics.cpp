/**
 * This module contains the class managing the ROS Logistics
 */

#include "ROSLogistics.hpp"
#include <ros/ros.h>
#include <iostream>
using namespace std;

namespace motion_planning
{

	ROS_Logistics::ROS_Logistics()	:	m_node(nullptr),
										m_rrt_planner(nullptr),
										m_queue_size(1),			// Want the latest information
										m_spin_rate(10.0)			// Keep processing callback queue at 10 Hz = 1/10 sec = 100ms
	{
		// Register the node with ROS Master
		m_node = std::make_shared<ros::NodeHandle>();


		// Establish all necessary connections
		setUp_ROS_Communication();
		ROS_INFO("Needle Steering RRT Planner service up and running . . .");

		// Keep looking into service, subscriber queues once in 100ms
		ros::Rate rate(m_spin_rate);		// 10 Hz = 1/10 sec = 100ms
		while (m_node->ok())
		{
			ros::spinOnce();
			rate.sleep();
		}
	}


	void ROS_Logistics::setUp_ROS_Communication()
	{
		// Setup the necessary ROS services for users to use
		m_srv_rrt_planner = m_node->advertiseService("/srv_rrt_planner", &ROS_Logistics::srv_rrt_planner, this);
	}

	bool ROS_Logistics::srv_rrt_planner(needle_steering::rrt_planner::Request& req,
										needle_steering::rrt_planner::Response& res)
	{
		// Create Env and RRT_Planner to serve the request
//		m_rrt_planner = make_shared<Planner_RRT>();

		cout << "Service Invoked . . . ." << endl;

		return true;
	}

}  // namespace motion_planning
