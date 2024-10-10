// MapDriver.cpp
#include "Map.h"
#include <iostream>

void testLoadMaps() {
    MapLoader loader;
    Map* map = loader.loadMap("test.map");  // Example file name
    if (map && map->validate()) {
        std::cout << "Map is valid and loaded successfully." << std::endl;
    } else {
        std::cout << "Failed to load a valid map." << std::endl;
    }
    delete map; // Ensure no memory leaks
}

int main() {
    testLoadMaps();
    return 0;
}
