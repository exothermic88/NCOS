// Map.cpp
#include "Map.h"
#include <fstream>
#include <iostream>
#include <sstream>

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
    // Implement graph traversal to check connectivity
    return true; // Simplified for now
}

std::ostream& operator<<(std::ostream& out, const Continent& continent) {
    out << *continent.name << " contains " << continent.territories->size() << " territories.";
    return out;
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
    // Check if the map is a connected graph
    // Check if each continent is a connected subgraph
    // Check if each territory belongs to one and only one continent
    return true; // Simplified for now
}

std::ostream& operator<<(std::ostream& out, const Map& map) {
    out << "Map with " << map.territories->size() << " territories and " << map.continents->size() << " continents.";
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
        std::cerr << "Error opening file: " << filename << std::endl;
        return nullptr;
    }
    
    Map* map = new Map();
    
    // Simplified parsing for now, this would read and parse the map file
    std::string line;
    while (std::getline(file, line)) {
        // Parse the file
    }
    
    file.close();
    return map;
}

bool MapLoader::isValidMap(const std::string& filename) const {
    // Implement logic to check if a file is a valid map
    return true; // Simplified for now
}
