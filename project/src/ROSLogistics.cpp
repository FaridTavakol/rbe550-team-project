/**
 * This module contains the class managing the ROS Logistics
 */

#include "ROSLogistics.hpp"
#include <ros/ros.h>
//#include <std_msgs/array.h>

namespace motion_planning
{

	ROS_Logistics::ROS_Logistics()	:	m_node(nullptr),
										m_bfs(nullptr)
	{
		// Register the node with ROS Master
		m_node = std::make_shared<ros::NodeHandle>();


		// Establish all necessary connections
		setUp_ROS_Communication();
		ROS_INFO("HW1 all graph search services up and running . . .");

		// Create different search algorithms
		m_bfs = make_shared<BFS>();

		// Keep looking into service, subscriber queues once in 100ms
		ros::Rate rate(spin_rate);		// 10 Hz = 1/10 sec = 100ms
		while (m_node->ok())
		{
			ros::spinOnce();
			rate.sleep();
		}
	}


	void ROS_Logistics::setUp_ROS_Communication()
	{
		// Setup the necessary ROS services for users to use
//		m_srv_bfs = m_node->advertiseService(srv_bfs_name, &ROS_Logistics::srv_bfs, this);

	}

}  // namespace motion_planning
