// MapDriver.cpp
#include "Map.h"
#include <iostream>


void testLoadMaps() {
    MapLoader loader;
    std::vector<std::string> mapFiles = {
        "test.map",
        "nosub.map",
        "notfullconnect.map",
        "multi-cont.map",
        "garbage.txt"
        
        // Add paths to various map files here
    };

     for (const std::string& filename : mapFiles) {
        std::cout << "Loading map: " << filename << std::endl;
        Map* map = loader.loadMap(filename);

        if (map) {
            // After loading, explicitly validate the map
            if (map->validate([Map]
author=Sean O'Connor
image=world2.bmp
wrap=no
scroll=horizontal
warn=yes

[Continents]
North America=3
South America=2
Africa=2
Asia=2

[Territories]
Alaska,70,126,North America,Ontario,Quebec
Ontario,199,167,North America,Quebec,Alaska
Quebec,253,166,North America,Ontario

Venezuala,259,303,South America,Brazil
Brazil,308,337,South America,Venezuala

North Africa,420,264,Africa,Congo
Congo,475,318,Africa,North Africa

China,662,217,Asia,India
India,612,249,Asia,China)) {
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