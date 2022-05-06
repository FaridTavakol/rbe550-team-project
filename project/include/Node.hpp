/**
 * This module contains the useful constants
 */

#ifndef HW1_BASIC_SEARCH_HPP
#define HW1_BASIC_SEARCH_HPP

#include "Common.hpp"
#include <vector>
#include <limits>
using namespace std;


namespace motion_planning
{

    struct Node
    {
    	int row;
    	int col;
    	bool obs;
    	int g;						// cost to come (previous g + moving cost).. edge value
    	int cost;					// total cost (depend on the algorithm)
    	int h;						// heuristic
    	bool visited;
    	shared_ptr<Node> parent;	// previous node through which this node was visited
    	vector<int> edge_w;			// edge value ... size will be four as it stores weights to move to its neighboring 4-connected nodes


    	Node (int in_row, int in_col, bool in_obs)
    	{
    		row = in_row;
    		col = in_col;
    		obs = in_obs;

    		g = 1;					// all edges weighted equally according to question
    		cost = numeric_limits<int>::max();
    		visited = false;
    		parent = nullptr;
    		h = 0;

    		edge_w = {1,1,1,1};		// Right,Down,Left,Top
    	}

    	bool operator== (const Node& n)
    	{
    	    return (this->row == n.row &&
    	            this->col == n.col);
    	}

    	bool operator!= (const Node& n)
    	{
    	    return (this->row != n.row ||
    	            this->col != n.col);
    	}
    };


} // namespace motion_planning

#endif	// #ifndef HW1_BASIC_SEARCH_HPP
