/**
 * This module contains the class managing the ROS Logistics
 */

#ifndef HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP
#define HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP

#include "Common.hpp"
#include "BFS.hpp"
#include <ros/ros.h>

namespace motion_planning
{
	class ROS_Logistics
	{
	public:
		ROS_Logistics();

		~ROS_Logistics() = default;


	private:
        std::shared_ptr<ros::NodeHandle> m_node;			// ptr cuz we shouldn't create it before calling ros::init

        std::shared_ptr<BFS> m_bfs;

		ros::ServiceServer m_srv_bfs;

		/* Establish necessary services, clients, publisher, listener communication */
		void setUp_ROS_Communication();
	};


} // namespace motion_planning

#endif	// #ifndef HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP
