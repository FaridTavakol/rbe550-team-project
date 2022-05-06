/**
 * This module contains the class managing the ROS Logistics
 */

#ifndef HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP
#define HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP

#include "Environment.hpp"
#include "Planner_RRT.hpp"
#include <ros/ros.h>
#include "needle_steering/rrt_planner.h"

namespace motion_planning
{
	class ROS_Logistics
	{
	public:
		ROS_Logistics();

		~ROS_Logistics() = default;


	private:
	    const uint32_t m_queue_size;

	    const double m_spin_rate;

        std::shared_ptr<ros::NodeHandle> m_node;			// ptr cuz we shouldn't create it before calling ros::init

        std::shared_ptr<Planner_RRT> m_rrt_planner;

		ros::ServiceServer m_srv_rrt_planner;

		/* Establish necessary services, clients, publisher, listener communication */
		void setUp_ROS_Communication();

		bool srv_rrt_planner(needle_steering::rrt_planner::Request& req,
							 needle_steering::rrt_planner::Response& res);

	};


} // namespace motion_planning

#endif	// #ifndef HW1_BASIC_SEARCH_ROS_LOGISTICS_HPP
