// To-Do: Update logic for reducing checks when multiple obs exists
bool Planner_RRT::check_collision(const shared_ptr<Node> n1,
	 	 	 	   const shared_ptr<Node> n2)
{
	int x1 = n1->x;
	int y1 = n1->y;

	int x2 = n2->x;
	int y2 = n2->y;

	// Setup line equation properly based on slope
	int num = y2-y1;
	int den = x2-x1;
	function<int(int)> fn;		// fn to find y

	if (den == 0)
	{
		fn = [&] (int x) { cout << x << endl; return x + y1; };
	}
	else
	{
		double m = (double)num/den;
		fn = [&] (int x) {
							double y = m*(x-x1) + y1;
							cout << x << ", " << y << endl;
							return y;
						 };
	}

	int step = 1;
	int x = x1;		// Start from 1st point
	int y = y1;		// Start from 1st point

	// Decide which direction to move
	bool collision_exist = false;
	if (x2 > x1)
	{
		step *= 1;		// move rightward

		while (x < x2)
		{
			// For every point on line, check if it is outside every obstacle
			for (auto& obs : m_env->m_obstacles)
			{
				// check if within the bounding box, then obstacle detected
				if (x >= obs->left && x <= obs->right &&
					y >= obs->top  && y <= obs->bottom)

				{
					x += step;
					y = fn(x);
					collision_exist = true;
					break;
				}
			}

			if (collision_exist)
				break;

			x += step;
			y = fn(x);
		}
	}
	else			// move leftward
	{
		step *= -1;		// move leftward

		while (x > x2)
		{
			// For every point on line, check if it is outside every obstacle
//				for (auto& obs : m_env->m_obstacles)
//				{
//					// check if within the bounding box, then obstacle detected
//					if (x >= obs.left && x =< obs.right &&
//						y >- obs.top  && y =< obs.bottom)
//
//					{
//						x += step;
//						y = fn(x);
//						collision_exist = true;
//						break;
//					}
//				}

			if (collision_exist)
				break;

			x += step;
			y = fn(x);
		}
	}


	// Update node2 with correct value
	if (x==x1 && y==y1)
	{
		// this case happens when the very next point from tree node is in collision
		// In that case, we shouldn't connect existing node to itself
		n2->x = -1;
		n1->y = -1;
	}
	else
	{
		n2->x = x;
		n2->y = y;
	}

	// if obs detected, stop will be set to true
	return collision_exist;
}



void collision_check_test()
{
	for (auto& i : {1,2,3,4,5})
	{
		auto n1 = get_new_node();
		auto n2 = get_new_node();

		cout << n1->x << ", " << n1->y << " **** " <<  n2->x << ", " << n2->y << endl;
		if (check_collision(n1,n2))
		{
			cout << "yes" << endl;
			cout << n2->x << ", " << n2->y << endl;
		}
		else
		{
			cout << "no" << endl;
			cout << n2->x << ", " << n2->y << endl;
		}
	}
}



