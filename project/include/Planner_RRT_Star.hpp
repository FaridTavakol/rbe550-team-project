/**
 * This module contains the class computing the Kinematics of the Scara Robot
 */

#ifndef PLANNER_RRT_STAR_HPP
#define PLANNER_RRT_STAR_HPP

#include "Planner_RRT.hpp"
#include "Environment.hpp"
#include <Eigen/Dense>
#include <memory>
#include <vector>
#include <list>
#include <random>

namespace motion_planning
{

	class Planner_RRT_Star : public Planner_RRT
	{
	public:
		/*
		 * 	goal_bias	--> self-explanatory
		 * 	goal_region --> Sets the precision needed around goal
		 *	nn_region 	--> Sets the speed at which tree grows
		 *	max_itr		--> Maximum tries allowed to find the goal
		 */
		Planner_RRT_Star(double goal_bias,
						double goal_region,
						double nn_region,
						int max_itr);

		~Planner_RRT_Star() = default;

		/*
		 * paths --> 1st path would be the raw_path
		 * 			 2nd path would be the smooth_path
		 * steps --> num of nodes visited before getting the solution
		 *
		 */
		bool search( Environment* env,
					 const Eigen::Vector3i& start,  const Eigen::Vector3i& goal,
					 vector<list<Eigen::Vector3i>>& raw_paths,
					 vector<list<Eigen::Vector3d>>& smooth_paths) override;

	private:

		bool check_collision2(const shared_ptr<Node> n1,
							  const shared_ptr<Node> n2);

		void get_neighbors(const shared_ptr<Node> rand_node, vector<shared_ptr<Node>>& neighbors);

		void rewire(const shared_ptr<Node> new_node, const vector<shared_ptr<Node>>& neighbors);

	};

}    	// namespace motion_planning

#endif	// #ifndef PLANNER_RRT_STAR_HPP
