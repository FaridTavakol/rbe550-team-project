/**
 * This module contains NeedleSteering, DFS, Djikstras, A* algorithms
 */

#include "Environment.hpp"
#include <iostream>

namespace motion_planning
{

	Environment::Environment(int x_max, int y_max, int z_max)	: 	m_num_rows(y_max),
																	m_num_cols(x_max),
																	m_num_pages(z_max),
																	m_grid(make_shared<Eigen::Tensor<int, 3>>(y_max, x_max, z_max))
	{
		m_grid->setZero();	// make full 3D grid zeros
	}


	void Environment::print()
	{
		if (m_grid)
		{
			cout << *m_grid << endl;
		}
	}


	void Environment::add_obstacle(Eigen::Vector3i pt, int height, int width, int length)
	{
		int x = pt(0);
		int y = pt(1);
		int z = pt(2);
		// NOTE: y is row and x is col
		Eigen::array<Eigen::Index, 3> offsets = {x, y, z};
		Eigen::array<Eigen::Index, 3> extents = {height, width, length};
		auto obs_cube = m_grid->slice(offsets, extents);
		obs_cube.setConstant(1);
//		m_grid->block(y, x, height, width) = Eigen::MatrixXi::Ones(height,width,length);

		auto obs = make_shared<BoundingBox>();
		// Set the boundary indices
		obs->top 	= y;
		obs->bottom = y + height - 1; 	// -1 because of 0 indexing

		obs->left	= x;
		obs->right 	= x + width - 1; 	// -1 because of 0 indexing

		obs->front 	= z;
		obs->back  	= z + length - 1; 	// -1 because of 0 indexing

		m_obstacles.push_back(obs);
	}


	void Environment::add_path(const list<Eigen::Vector3i>& path, int c)
	{
		Eigen::Vector3i start = path.front();
		Eigen::Vector3i goal = path.back();

		for (auto& p : path)
		{
			(*m_grid)(p(1), p(0), p(2)) = c;
			++c;
			cout << p(0) << ", " << p(1) << ", " << p(2) << endl;
		}
	}
}	// namespace motion_planning
