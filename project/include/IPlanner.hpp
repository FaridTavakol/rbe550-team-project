/**
 * This module contains the class computing the Kinematics of the Scara Robot
 */

#ifndef IPLANNER_HPP
#define IPLANNER_HPP

#include "Environment.hpp"
#include <Eigen/Dense>
#include <list>
using namespace std;

namespace motion_planning
{

	class IPlanner
	{
	public:
		IPlanner() = default;

		virtual ~IPlanner() = default;

		/*
		 * steps --> num of nodes visited before getting the solution
		 *
		 */
		virtual bool search( Environment* env,
							 const Eigen::Vector3i& start,  const Eigen::Vector3i& goal,
							 vector<list<Eigen::Vector3i>>& paths, int& steps) = 0;

	private:

	};

}    	// namespace motion_planning

#endif	// #ifndef IPLANNER_HPP
