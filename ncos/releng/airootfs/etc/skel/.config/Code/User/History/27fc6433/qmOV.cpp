// MapDriver.cpp
#include "Map.h"
#include <iostream>

using namespace std;

void testLoadMaps() {
    MapLoader loader;
    vector<string> mapFiles = {
        "Map/valid.map",
        "Map/multiContinent.map",
        "Map/nosub.map",
        "Map/notfullconnect.map",
        "Map/multi-cont.map",
        "Map/garbage.txt"
        
        // Add paths to various map files here
    };

     for (const string& filename : mapFiles) {


        cout << "\n\nLoading map: " << filename << endl;
        Map* map = loader.loadMap(filename);

        if (map) {
            // After loading, explicitly validate the map
            if (map->validate()) {
                cout << "Successfully loaded and validated map:\n" << *map << endl;
            } else {
                cout << "Loaded map but validation failed: " << filename << endl;
            }
        } else {
            cout << "Failed to load map: " << filename << endl;
        }

        delete map; // Clean up after using the map
    }
}
