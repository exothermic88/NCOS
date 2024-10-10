#include "Orders/Orders.h"
#include "Cards/Cards.h"
#include "GameEngine/GameEngine.h"
#include "Player/Player.h"
#include "Map/Map.h"

int main () {
	//Call all test files 
	//Map
	cout << "\n\n***Map - testMaps***" << endl; 
	testLoadMaps();
	//Player 
	cout << "\n\n***Player - testPlayers***" << endl; 
	testPlayers();
	//Orders
	cout << "\n\n***Orders - testOrdersList***" << endl; 
	testOrdersLists(); 
	//Cards
	cout << "\n\n***Cards - testCards***" << endl; 
	testCards();
	//Game Engine
    cout << "\n\n***Game Engine - testGameStates***" << endl;
    testGameStates();

	return 0; 
}