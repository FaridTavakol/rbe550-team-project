/**
 * This module contains NeedleSteering, DFS, Djikstras, A* algorithms
 */

#include "Environment.hpp"
#include <iostream>

namespace motion_planning
{

	Environment::Environment(int rows, int cols)	: 	m_grid(make_shared<Eigen::MatrixXi>(rows,cols)),
														m_num_rows(rows),
														m_num_cols(cols)
	{
		*m_grid = Eigen::MatrixXi::Zero(rows,cols);
	}


	void Environment::print()
	{
		if (m_grid)
		{
			cout << *m_grid << endl;
		}
	}


	void Environment::add_obstacle(Eigen::Vector2i pt, int height, int width)
	{
		int x = pt(0);
		int y = pt(1);
		// NOTE: y is row and x is col
		m_grid->block(y, x, height, width) = Eigen::MatrixXi::Ones(height,width);

		auto obs = make_shared<BoundingBox>();
		// Set the boundary indices
		obs->top 	= y;
		obs->bottom = y + height - 1; 	// -1 because of 0 indexing

		obs->left	= x;
		obs->right 	= x + width - 1; 	// -1 because of 0 indexing

		m_obstacles.push_back(obs);
	}


	void Environment::add_path(const list<Eigen::Vector2i>& path, int c)
	{
		Eigen::Vector2i start = path.front();
		Eigen::Vector2i goal = path.back();

		for (auto& p : path)
		{
			(*m_grid)(p(1), p(0)) = c;
			++c;
			cout << p(0) << ", " << p(1) << endl;
		}
	}
}	// namespace motion_planning
