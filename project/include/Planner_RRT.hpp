/**
 * This module contains the class computing the Kinematics of the Scara Robot
 */

#ifndef PLANNER_RRT_HPP
#define PLANNER_RRT_HPP

#include "IPlanner.hpp"
#include "Environment.hpp"
#include <Eigen/Dense>
#include <memory>
#include <vector>
#include <list>
#include <random>

namespace motion_planning
{

	struct Node
	{
		int x;
		int y;
		int z;
		shared_ptr<Node> parent;
		double cost;

		Node (int pos_x, int pos_y, int pos_z)
		{
			x = pos_x;
			y = pos_y;
			z = pos_z;
			parent = nullptr;
			cost = 0;
		}

    	bool operator== (const Node& other)
    	{
    	    return (this->x == other.x &&
    	            this->y == other.y &&
					this->z == other.z);
    	}

    	bool operator!= (const Node& other)
    	{
    	    return (this->x != other.x &&
    	            this->y != other.y &&
					this->z != other.z);
    	}
	};

	class Planner_RRT : public IPlanner
	{
	public:
		/*
		 * 	goal_bias	--> self-explanatory
		 * 	goal_region --> Sets the precision needed around goal
		 *	nn_region 	--> Sets the speed at which tree grows
		 *	max_itr		--> Maximum tries allowed to find the goal
		 */
		Planner_RRT(double goal_bias,
					double goal_region,
					double nn_region,
					int max_itr);

		~Planner_RRT() = default;

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

	protected:

		Environment* m_env;

		shared_ptr<Node> m_start;

		shared_ptr<Node> m_goal;

		int m_max_itr;

		vector<shared_ptr<Node>> m_tree;

		double m_goal_bias;					// [0,1)

		double m_goal_region;				// double if more precision is needed

		double m_nn_region;					// nearest neighbors to be considered within this distance

		/* Following data members for generating random node
		 * Ref: https://en.cppreference.com/w/cpp/numeric/random/uniform_int_distribution
		 */
	    std::random_device m_rd;
	    std::mt19937 m_gen;
	    std::uniform_int_distribution<> m_distrib_x;
	    std::uniform_int_distribution<> m_distrib_y;
	    std::uniform_int_distribution<> m_distrib_z;
	    std::uniform_real_distribution<> m_distrib;


		void init();

		double dist(const shared_ptr<Node> n1,
					const shared_ptr<Node> n2);

		double dist(const Eigen::Vector3i p1,
				    const Eigen::Vector3i p2);

		// If there is a collision, n2 is updated to the node just before collision. So there is no waste of computation
		// Stops checking and updates n2 the moment 1st obstacle is spotted
		bool check_collision(const shared_ptr<Node> n1,
							 shared_ptr<Node> n2);

		void generate_check_points_on_line(const Eigen::Vector3i& p0,
										   const Eigen::Vector3i& p1,
										   vector<Eigen::Vector3i>& check_points);

		shared_ptr<Node> get_new_node();

		shared_ptr<Node> get_nearest_node(const shared_ptr<Node> rand_node);

		void generate_raw_path(vector<list<Eigen::Vector3i>>& raw_paths);

		void generate_smooth_path(vector<list<Eigen::Vector3i>>& raw_paths,
								  vector<list<Eigen::Vector3d>>& smooth_paths);

	};

}    	// namespace motion_planning

#endif	// #ifndef PLANNER_RRT_HPP
