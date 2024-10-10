// Map.cpp
#include "Map.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <unordered_set>
#include <queue>
#include <unordered_map>
#include <functional>
#include <set>
using namespace std;

// Territory Implementation

Territory::Territory(const string& name, Player* owner, int armies)
    : name(new string(name)), owner(owner), armies(new int(armies)), adjacentTerritories(new vector<Territory*>()) {}

Territory::Territory(const Territory& other) 
    : name(new string(*other.name)), owner(other.owner), armies(new int(*other.armies)),
      adjacentTerritories(new vector<Territory*>(*other.adjacentTerritories)) {}

Territory& Territory::operator=(const Territory& other) {
    if (this == &other) return *this;
    *name = *other.name;
    owner = other.owner;
    *armies = *other.armies;
    *adjacentTerritories = *other.adjacentTerritories;
    return *this;
}

Territory::~Territory() {
    delete name;
    delete armies;
    delete adjacentTerritories;
}

void Territory::addAdjacentTerritory(Territory* territory) {
    adjacentTerritories->push_back(territory);
}

const vector<Territory*>& Territory::getAdjacentTerritories() const {
    return *adjacentTerritories;
}

bool Territory::isAdjacent(const Territory* territory) const {
    for (Territory* adjacent : *adjacentTerritories) {
        if (adjacent == territory) {
            return true;
        }
    }
    return false;
}

ostream& operator<<(ostream& out, const Territory& territory) {
    out << *territory.name << " (Armies: " << *territory.armies << ")";
    return out;
}

// Continent Implementation

Continent::Continent(const string& name) 
    : name(new string(name)), territories(new vector<Territory*>()) {}

Continent::Continent(const Continent& other) 
    : name(new string(*other.name)), territories(new vector<Territory*>(*other.territories)) {}

Continent& Continent::operator=(const Continent& other) {
    if (this == &other) return *this;
    *name = *other.name;
    *territories = *other.territories;
    return *this;
}

Continent::~Continent() {
    delete name;
    delete territories;
}

void Continent::addTerritory(Territory* territory) {
    territories->push_back(territory);
}

bool Continent::isConnectedSubgraph() const {
 unordered_set<Territory*> visited;
    queue<Territory*> toVisit;

    // Start from the first territory in the continent
    const auto territories = getTerritories();
    if (territories.empty()) return true; // An empty continent is considered connected

    toVisit.push(territories[0]);
    visited.insert(territories[0]);

    while (!toVisit.empty()) {
        Territory* current = toVisit.front();
        toVisit.pop();

        // Visit all adjacent territories
        for (Territory* neighbor : current->getAdjacentTerritories()) {
            // Check if the neighbor belongs to this continent
            bool isInContinent = false;

            // Replace find with an explicit loop
            for (Territory* territory : territories) {
                if (territory == neighbor) {
                    isInContinent = true;
                    break; // Found the neighbor in the continent's territories
                }
            }

            if (isInContinent) {
                if (visited.find(neighbor) == visited.end()) {
                    visited.insert(neighbor);
                    toVisit.push(neighbor);
                }
            } else {
            }
        }
    }

    // Check if all territories in the continent were visited
    return visited.size() == territories.size();
}

ostream& operator<<(ostream& os, const Continent& continent) {
    os << "Continent: " << continent.getName() << "\n"; // Assuming you have a getName() method
    os << "Territories:\n";
    
    const auto& territories = continent.getTerritories(); // Get territories
    for (const Territory* territory : territories) {
        os << *territory << "\n"; // Assuming you have an operator<< defined for Territory as well
    }
    
    return os;
}

// Map Implementation

Map::Map() 
    : territories(new vector<Territory*>()), continents(new vector<Continent*>()) {}

Map::Map(const Map& other) 
    : territories(new vector<Territory*>(*other.territories)), continents(new vector<Continent*>(*other.continents)) {}

Map& Map::operator=(const Map& other) {
    if (this == &other) return *this;
    *territories = *other.territories;
    *continents = *other.continents;
    return *this;
}

Map::~Map() {
    delete territories;
    delete continents;
}

void Map::addTerritory(Territory* territory) {
    territories->push_back(territory);
}

void Map::addContinent(Continent* continent) {
    continents->push_back(continent);
}

bool Map::validate() const {
    cout << "Starting map validation..." << endl;
    //bool result = isConnectedGraph() && areContinentsConnected() && isTerritoryInOneContinent();
    bool result = areContinentsConnected() && isConnectedGraph() && isTerritoryInOneContinent();
    cout << "Map validation result: " << (result ? "Valid" : "Invalid") << endl;
    return result;
}

bool Map::isConnectedGraph() const {
    cout << "Checking if the graph is connected..." << endl;
    if (territories->empty()) {
        cout << "No territories found. Graph is trivially connected." << endl;
        return false;
    }

    unordered_set<Territory*> visited;
    queue<Territory*> toVisit;

    // Start from the first territory
    toVisit.push((*territories)[0]);
    visited.insert((*territories)[0]);

    while (!toVisit.empty()) {
        Territory* current = toVisit.front();
        toVisit.pop();

        for (Territory* neighbor : current->getAdjacentTerritories()) {
            if (visited.find(neighbor) == visited.end()) {
                visited.insert(neighbor);
                toVisit.push(neighbor);
            }
        }
    }

    bool isConnected = visited.size() == territories->size();
    cout << "Graph connectivity check: " << (isConnected ? "All territories visited." : "Not all territories visited.") << endl;
    return isConnected; // All territories should be visited
}

bool Map::areContinentsConnected() const {
    cout << "Checking if all continents are connected..." << endl;
    for (Continent* continent : *continents) {
        if (!continent->isConnectedSubgraph()) {
            cout << "Continent " << continent->getName() << " is not connected." << endl;
            return false; // If any continent is not connected
        }
    }
    cout << "All continents are connected." << endl;
    return true;
}


ostream& operator<<(ostream& out, const Map& map) {
     out << "Map with " << map.territories->size() << " territories and "
        << map.continents->size() << " continents.\n"; // Assuming continents is similarly defined.

    out << "Territories:\n";
    for (const Territory* territory : *map.territories) { // Dereference the pointer to access the vector.
        out << *territory << "\n"; // Assuming you have an operator<< for Territory.
    }

    out << "Continents:\n";
    for (const Continent* continent : *map.continents) { // Dereference as well.
        out << *continent << "\n"; // Assuming you have an operator<< for Continent.
    }

    return out;
}

// MapLoader Implementation

MapLoader::MapLoader() {}

MapLoader::MapLoader(const MapLoader& other) {}

MapLoader& MapLoader::operator=(const MapLoader& other) {
    return *this;
}

MapLoader::~MapLoader() {}

Map* MapLoader::loadMap(const string& filename) {
    ifstream file(filename);
    if (!file.is_open()) {
        throw runtime_error("Unable to open map file: " + filename);
    }

    string line;
    Map* map = new Map();
    unordered_map<string, Continent*> continentMap; // Map continent name to Continent object
    unordered_map<string, Territory*> territoryMap; // Map territory name to Territory object
    unordered_map<string, vector<string>> adjacencies; // Temporary storage for adjacency names

    enum Section { NONE, MAP, CONTINENTS, TERRITORIES } currentSection = NONE;

    while (getline(file, line)) {
        // Skip empty lines
        if (line.empty()) continue;

        // Detect section headers
        if (line == "[Map]") {
            currentSection = MAP;
            continue;
        } else if (line == "[Continents]") {
            currentSection = CONTINENTS;
            continue;
        } else if (line == "[Territories]") {
            currentSection = TERRITORIES;
            continue;
        }

        // Parse lines according to the current section
        if (currentSection == MAP) {
            // You can process metadata here if needed
            // For example: author, image, wrap, scroll, warn
            istringstream ss(line);
            string key, value;
            if (getline(ss, key, '=') && getline(ss, value)) {
                // Handle metadata if necessary (e.g., map metadata)
            }
        } 
        else if (currentSection == CONTINENTS) {
            // Format: ContinentName=ControlValue
            istringstream ss(line);
            string continentName;
            int controlValue;
            if (getline(ss, continentName, '=') && ss >> controlValue) {
                Continent* continent = new Continent(continentName);
                continentMap[continentName] = continent;
                map->addContinent(continent);
            }
        } 
        else if (currentSection == TERRITORIES) {
            // Format: TerritoryName,x,y,Continent,Adj1,Adj2,...
            istringstream ss(line);
            string territoryName, x, y, continentName, adjacentTerritoryName;
            getline(ss, territoryName, ',');
            getline(ss, x, ',');
            getline(ss, y, ',');
            getline(ss, continentName, ',');

            // Create the territory object
            Territory* territory = new Territory(territoryName, nullptr, 0);  // Owner and armies can be set later
            territoryMap[territoryName] = territory;

            // Add the territory to its continent
            if (continentMap.find(continentName) != continentMap.end()) {
                continentMap[continentName]->addTerritory(territory);
            }

            map->addTerritory(territory);

            // Parse adjacent territories and temporarily store their names in adjacencies
            vector<string> adjacentNames;
            while (getline(ss, adjacentTerritoryName, ',')) {
                adjacentNames.push_back(adjacentTerritoryName);
            }
            adjacencies[territoryName] = adjacentNames; // Store the adjacent territories
        }
    }

    // Post-processing: Link territories with their adjacents
    for (const auto& pair : adjacencies) {
        const string& territoryName = pair.first;
        const vector<string>& adjacentNames = pair.second;
        
        Territory* territory = territoryMap[territoryName];
        for (const string& adjacentName : adjacentNames) {
            if (territoryMap.find(adjacentName) != territoryMap.end()) {
                territory->addAdjacentTerritory(territoryMap[adjacentName]);
            } else {
                cerr << "Warning: Adjacent territory " << adjacentName << " not found for " << territoryName << endl;
            }
        }
    }
    
     // ** Map Validation Step **
     
    // if (!map->validate()) {
    //     cerr << "Invalid map: " << filename << endl;
    //     delete map;
    //     return nullptr; // Return nullptr if the map is invalid
    // }

    file.close();
    return map;
}