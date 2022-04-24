/**
 * This module contains the useful constants
 */

#ifndef HW1_BASIC_SEARCH_COMMON_HPP
#define HW1_BASIC_SEARCH_COMMON_HPP

#include <Eigen/Dense>
#include <memory>
#include <iostream>
using namespace std;

namespace motion_planning
{
    // Some helpful ros constants
    constexpr uint32_t queue_size = 1;						// Want the latest information
    constexpr double spin_rate = 10.0;						// Keep processing callback queue at 10 Hz = 1/10 sec = 100ms


    // Some ros topics to talk with python HW scripts
    const std::string srv_bfs_name 		{"/srv_bfs"};
    const std::string srv_dfs_name 		{"/srv_dfs"};
    const std::string srv_dijkstra_name {"/srv_dijkstra"};
    const std::string srv_astar_name 	{"/srv_astar"};


}		// namespace motion_planning

#endif	// #ifndef HW1_BASIC_SEARCH_COMMON_HPP
