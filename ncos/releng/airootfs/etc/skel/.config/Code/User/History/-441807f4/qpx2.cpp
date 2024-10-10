// MapDriver.cpp
#include "Map.h"
#include <iostream>


void testLoadMaps() {
    MapLoader loader;
    std::vector<std::string> mapFiles = {
        "valid.map",
        "nosub.map",
        "notfullconnect.map",
        "multi-cont.map",
        "garbage.txt",
        "usa.map"
        
        // Add paths to various map files here
    };

     for (const std::string& filename : mapFiles) {
        std::cout << "Loading map: " << filename << std::endl;
        Map* map = loader.loadMap(filename);

        if (map) {
            // After loading, explicitly validate the map
            if (map->validate()) {
                std::cout << "Successfully loaded and validated map:\n" << *map << std::endl;
            } else {
                std::cout << "Loaded map but validation failed: " << filename << std::endl;
            }
        } else {
            std::cout << "Failed to load map: " << filename << std::endl;
        }

        delete map; // Clean up after using the map
    }
}

int main() {
    testLoadMaps();
    return 0;
}