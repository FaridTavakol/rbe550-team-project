/**
 * This module contains the class computing the Kinematics of the Scara Robot
 */

#ifndef NEEDLE_STEERING_HPP
#define NEEDLE_STEERING_HPP

#include <Eigen/Dense>
#include <vector>
#include <list>
#include <memory>
#include </usr/include/eigen3/unsupported/Eigen/CXX11/Tensor>
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
	struct BoundingBox	// it's a cube for 3D
	{
		int top;		// y-axis (0th row)
		int bottom;		// y-axis (nth row)
		int left;		// y-axis (0th col)
		int right;		// y-axis (nth col)
		int front;		// y-axis (0th page)
		int back;		// y-axis (nth page)
	};


	class Environment
	{
	public:
		Environment(int x_max, int y_max, int z_max);

		Environment() = default;

		~Environment() = default;

		void print();

		/*
		 * pt 		--> point at which obstacle should be placed
		 * width	--> width of the obstacle
		 * height 	--> height of the obstacle
		 * length	--> length of the obstacle
		 */
		void add_obstacle(Eigen::Vector3i pt, int width, int height, int length);

		/*
		 * path		--> self-explanatory
		 * c		--> char used to show the path
		 */
		void add_path(const list<Eigen::Vector3i>& path, int c);

		shared_ptr<Eigen::Tensor<int, 3>> m_grid; 		// input 3D map (x,y,z) --> (col,row,page)

		int m_num_rows;

		int m_num_cols;

		int m_num_pages;

		vector<shared_ptr<BoundingBox>> m_obstacles;

	};

}    	// namespace motion_planning

#endif	// #ifndef NEEDLE_STEERING_HPP
