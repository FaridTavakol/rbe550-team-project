cmake_minimum_required(VERSION 3.4.2)
project(needle_steering)

add_compile_options(-std=c++14)
set(CMAKE_BUILD_TYPE "Debug")		# change it to "Release" when needed

################################################
## Find all ROS dependencies ##
################################################
find_package (Eigen3 3.3.0 REQUIRED)

find_package(catkin REQUIRED COMPONENTS
    roscpp
    rospy
    message_generation
    std_msgs
    geometry_msgs
)

################################################
## Declare ROS messages, services and actions ##
################################################

#add_service_files(
#  	FILES
#	graphSearch.srv
#)

#add_message_files(
#	FILES
#
#)

#generate_messages(
#	DEPENDENCIES
#	std_msgs
#	geometry_msgs
#)

###################################
## Catkin specific configuration ##
###################################

catkin_package(
#    INCLUDE_DIRS 
#    LIBRARIES 
   CATKIN_DEPENDS roscpp rospy std_msgs geometry_msgs message_runtime 
#    DEPENDS
)

###########
## Build ##
###########

include_directories(
	include
    ${catkin_INCLUDE_DIRS}
)


########## Building search algo node exe ##########
file(GLOB SOURCES "src/Environment.cpp" "src/Planner_RRT.cpp" "src/main.cpp")
#set(SOURCES
#		src/main.cpp
#		src/BFS.cpp	
#)
add_executable(needle_steering ${SOURCES})
#add_dependencies(needle_steering needle_steering_generate_messages_cpp)
target_link_libraries(needle_steering ${catkin_LIBRARIES} Eigen3::Eigen)


#############
## Testing ##
#############

#############
## Install ##
#############
