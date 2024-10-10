// Map.cpp
#include "Map.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <unordered_set>
#include <queue>
#include <unordered_map>
#include <functional>
using namespace std;

// Territory Implementation

Territory::Territory(const std::string& name, Player* owner, int armies)
    : name(new std::string(name)), owner(owner), armies(new int(armies)), adjacentTerritories(new std::vector<Territory*>()) {}

Territory::Territory(const Territory& other) 
    : name(new std::string(*other.name)), owner(other.owner), armies(new int(*other.armies)),
      adjacentTerritories(new std::vector<Territory*>(*other.adjacentTerritories)) {}

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

const std::vector<Territory*>& Territory::getAdjacentTerritories() const {
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

std::ostream& operator<<(std::ostream& out, const Territory& territory) {
    out << *territory.name << " (Armies: " << *territory.armies << ")";
    return out;
}

// Continent Implementation

Continent::Continent(const std::string& name) 
    : name(new std::string(name)), territories(new std::vector<Territory*>()) {}

Continent::Continent(const Continent& other) 
    : name(new std::string(*other.name)), territories(new std::vector<Territory*>(*other.territories)) {}

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
 std::unordered_set<Territory*> visited;
    std::queue<Territory*> toVisit;

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

            // Replace std::find with an explicit loop
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
                std::cout << "Neighbor not found in continent's territories: " << neighbor << std::endl;
            }
        }
    }

    // Check if all territories in the continent were visited
    return visited.size() == territories.size();
}

std::ostream& operator<<(std::ostream& os, const Continent& continent) {
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
    : territories(new std::vector<Territory*>()), continents(new std::vector<Continent*>()) {}

Map::Map(const Map& other) 
    : territories(new std::vector<Territory*>(*other.territories)), continents(new std::vector<Continent*>(*other.continents)) {}

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
    std::cout << "Starting map validation..." << std::endl;
    bool result = isConnectedGraph() && areContinentsConnected() && isTerritoryInOneContinent();
    std::cout << "Map validation result: " << (result ? "Valid" : "Invalid") << std::endl;
    return result;
}

bool Map::isConnectedGraph() const {
    std::cout << "Checking if the graph is connected..." << std::endl;
    if (territories->empty()) {
        std::cout << "No territories found. Graph is trivially connected." << std::endl;
        return true;
    }

    std::unordered_set<Territory*> visited;
    std::queue<Territory*> toVisit;

    // Start from the first territory
    toVisit.push((*territories)[0]);
    visited.insert((*territories)[0]);
    std::cout << "Starting from territory: " << (*territories)[0]->getName() << std::endl;

    while (!toVisit.empty()) {
        Territory* current = toVisit.front();
        toVisit.pop();
        std::cout << "Visiting territory: " << current->getName() << std::endl;

        for (Territory* neighbor : current->getAdjacentTerritories()) {
            if (visited.find(neighbor) == visited.end()) {
                visited.insert(neighbor);
                toVisit.push(neighbor);
                std::cout << "Found unvisited adjacent territory: " << neighbor->getName() << std::endl;
            }
        }
    }

    bool isConnected = visited.size() == territories->size();
    std::cout << "Graph connectivity check: " << (isConnected ? "All territories visited." : "Not all territories visited.") << std::endl;
    return isConnected; // All territories should be visited
}

bool Map::areContinentsConnected() const {
    std::cout << "Checking if all continents are connected..." << std::endl;
    for (Continent* continent : *continents) {
        if (!continent->isConnectedSubgraph()) {
            std::cout << "Continent " << continent->getName() << " is not connected." << std::endl;
            return false; // If any continent is not connected
        }
    }
    std::cout << "All continents are connected." << std::endl;
    return true;
}

// bool Map::isTerritoryInOneContinent() const {
//     if (territories == nullptr) {
//         std::cout << "Error: Territories pointer is null." << std::endl;
//         return false; // Or handle as appropriate
//     }

//     std::unordered_map<std::string, std::string> territoryToContinent;

//     for (const Territory* territory : *territories) {
//         if (territory == nullptr) {
//             std::cout << "Error: Encountered a null territory." << std::endl;
//             continue; // Skip this iteration or handle as needed
//         }
        
//         const std::string& territoryName = territory->getName();
//         const std::string& continentName = territory->getContinent();

//         std::cout << "Checking territory: " << territoryName << " in continent: " << continentName << std::endl;

//         if (territoryToContinent.find(territoryName) == territoryToContinent.end()) {
//             territoryToContinent[territoryName] = continentName;
//             std::cout << "Added territory: " << territoryName << " to continent: " << continentName << std::endl;
//         } else {
//             if (territoryToContinent[territoryName] != continentName) {
//                 std::cout << "Territory " << territoryName << " is connected to multiple continents: "
//                           << territoryToContinent[territoryName] << " and " << continentName << std::endl;
//                 return false;
//             } else {
//                 std::cout << "Territory " << territoryName << " is correctly assigned to continent: " << continentName << std::endl;
//             }
//         }
//     }
//     std::cout << "All territories belong to one continent." << std::endl;
//     return true;
// }

    
bool Map::isTerritoryInOneContinent() const {
    std::cout << "hello" << std::endl;

    // Check if territories is null or empty
    if (!territories) {
        std::cerr << "Error: Territories pointer is null." << std::endl;
        return false; // Handle accordingly
    }

    if (territories->empty()) {
        std::cerr << "Error: Territories vector is empty." << std::endl;
        return true; // Or handle accordingly
    }

    std::unordered_map<std::string, std::string> territoryToContinent;

    // Loop through each territory
    for (const Territory* territory : *territories) {
        // Check for null territory pointers
        if (territory == nullptr) {
            std::cerr << "Error: Encountered a null territory." << std::endl;
            continue; // Skip null territories
        }

        // Safely access the territory's name and continent
        const std::string& territoryName = territory->getName();
        const std::string& continentName = territory->getContinent();

        std::cout << "Processing territory: " << territoryName << " in continent: " << continentName << std::endl;

        // Check if the territory already exists in the map
        if (territoryToContinent.count(territoryName) == 0) {
            // Add the territory and its continent to the map
            territoryToContinent[territoryName] = continentName;
        } else {
            // Territory already exists, check if the continent is different
            if (territoryToContinent[territoryName] != continentName) {
                std::cout << "Territory " << territoryName 
                          << " is connected to multiple continents: "
                          << territoryToContinent[territoryName] 
                          << " and " << continentName << std::endl;
                return false; // Territory is in more than one continent
            }
        }
    }

    std::cout << "All territories belong to one continent." << std::endl;
    return true; // All territories are in one continent
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

Map* MapLoader::loadMap(const std::string& filename) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        throw std::runtime_error("Unable to open map file: " + filename);
    }

    std::string line;
    Map* map = new Map();
    std::unordered_map<std::string, Continent*> continentMap; // Map continent name to Continent object
    std::unordered_map<std::string, Territory*> territoryMap; // Map territory name to Territory object
    std::unordered_map<std::string, std::vector<std::string>> adjacencies; // Temporary storage for adjacency names

    enum Section { NONE, MAP, CONTINENTS, TERRITORIES } currentSection = NONE;

    while (std::getline(file, line)) {
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
            std::istringstream ss(line);
            std::string key, value;
            if (std::getline(ss, key, '=') && std::getline(ss, value)) {
                // Handle metadata if necessary (e.g., map metadata)
            }
        } 
        else if (currentSection == CONTINENTS) {
            // Format: ContinentName=ControlValue
            std::istringstream ss(line);
            std::string continentName;
            int controlValue;
            if (std::getline(ss, continentName, '=') && ss >> controlValue) {
                Continent* continent = new Continent(continentName);
                continentMap[continentName] = continent;
                map->addContinent(continent);
            }
        } 
        else if (currentSection == TERRITORIES) {
            // Format: TerritoryName,x,y,Continent,Adj1,Adj2,...
            std::istringstream ss(line);
            std::string territoryName, x, y, continentName, adjacentTerritoryName;
            std::getline(ss, territoryName, ',');
            std::getline(ss, x, ',');
            std::getline(ss, y, ',');
            std::getline(ss, continentName, ',');

            // Create the territory object
            Territory* territory = new Territory(territoryName, nullptr, 0);  // Owner and armies can be set later
            territoryMap[territoryName] = territory;

            // Add the territory to its continent
            if (continentMap.find(continentName) != continentMap.end()) {
                continentMap[continentName]->addTerritory(territory);
            }

            map->addTerritory(territory);

            // Parse adjacent territories and temporarily store their names in adjacencies
            std::vector<std::string> adjacentNames;
            while (std::getline(ss, adjacentTerritoryName, ',')) {
                adjacentNames.push_back(adjacentTerritoryName);
            }
            adjacencies[territoryName] = adjacentNames; // Store the adjacent territories
        }
    }

    // Post-processing: Link territories with their adjacents
    for (const auto& pair : adjacencies) {
        const std::string& territoryName = pair.first;
        const std::vector<std::string>& adjacentNames = pair.second;
        
        Territory* territory = territoryMap[territoryName];
        for (const std::string& adjacentName : adjacentNames) {
            if (territoryMap.find(adjacentName) != territoryMap.end()) {
                territory->addAdjacentTerritory(territoryMap[adjacentName]);
            } else {
                std::cerr << "Warning: Adjacent territory " << adjacentName << " not found for " << territoryName << std::endl;
            }
        }
    }
    
     // ** Map Validation Step **
     
    // if (!map->validate()) {
    //     std::cerr << "Invalid map: " << filename << std::endl;
    //     delete map;
    //     return nullptr; // Return nullptr if the map is invalid
    // }

    file.close();
    return map;
}