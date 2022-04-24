/**
 * This module contains the class computing the Kinematics of the Scara Robot
 */

#ifndef NEEDLE_STEERING_HPP
#define NEEDLE_STEERING_HPP

#include <Eigen/Dense>
#include <vector>
#include <list>
#include <memory>
using namespace std;


namespace motion_planning
{

	/*
	 * c1		c2
	 * 	#########  	- - - x  m_grid(y,x)
	 * 	#		#  	|
	 *  #		#  	|
	 *  #########	y
	 * c4		c3
	 *
	 * index of each side's boundary
	 */
	struct BoundingBox
	{
		int top;
		int bottom;
		int left;
		int right;
	};


	class Environment
	{
	public:
		Environment(int rows, int cols);

		Environment() = default;

		~Environment() = default;

		void print();

		/*
		 * pt 		--> point at which obstacle should be placed
		 * width	--> width of the obstacle
		 * height 	--> height of the obstacle
		 */
		void add_obstacle(Eigen::Vector2i pt, int width, int height);

		/*
		 * path		--> self-explanatory
		 * c		--> char used to show the path
		 */
		void add_path(const list<Eigen::Vector2i>& path, int c);

		shared_ptr<Eigen::MatrixXi> m_grid; 		// input map

		int m_num_rows;

		int m_num_cols;

		vector<shared_ptr<BoundingBox>> m_obstacles;

	};

}    	// namespace motion_planning

#endif	// #ifndef NEEDLE_STEERING_HPP
