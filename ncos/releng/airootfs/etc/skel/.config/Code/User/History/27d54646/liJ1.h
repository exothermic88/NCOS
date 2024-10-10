// Map.h
#ifndef MAP_H
#define MAP_H

#include <string>
#include <vector>
#include <iostream>

// Forward declarations
class Continent;
class Player;

class Territory {
private:
    std::string* name;
    Player* owner;
    int* armies;
    std::vector<Territory*>* adjacentTerritories;
    std::string* continent;

public:
    Territory(const std::string& name, Player* owner, int armies);
    Territory(const Territory& other); // Copy constructor
    Territory& operator=(const Territory& other); // Assignment operator
    ~Territory(); // Destructor
    
    void addAdjacentTerritory(Territory* territory);
    const std::vector<Territory*>& getAdjacentTerritories() const;
    bool isAdjacent(const Territory* territory) const;
    
    const std::string& getName() const { return *name; }
    const std::string& getContinent() const { return *continent; }

    // Stream insertion operator
    friend std::ostream& operator<<(std::ostream& out, const Territory& territory);
};

class Continent {
private:
    std::string* name;
    std::vector<Territory*>* territories;

public:
    Continent(const std::string& name);
    Continent(const Continent& other); // Copy constructor
    Continent& operator=(const Continent& other); // Assignment operator
    ~Continent(); // Destructor
    
    void addTerritory(Territory* territory);
    bool isConnectedSubgraph() const;
    
    friend std::ostream& operator<<(std::ostream& out, const Continent& continent);
};

class Map {
private:
    std::vector<Territory*>* territories;
    std::vector<Continent*>* continents;


public:
    Map();
    Map(const Map& other); // Copy constructor
    Map& operator=(const Map& other); // Assignment operator
    ~Map(); // Destructor
    
    void addTerritory(Territory* territory);
    void addContinent(Continent* continent);
    
    bool validate() const;
    bool isConnectedGraph() const;
    bool areContinentsConnected() const;
    bool isTerritoryInOneContinent() const;

    friend std::ostream& operator<<(std::ostream& out, const Map& map);
};

class MapLoader {
public:
    MapLoader();
    MapLoader(const MapLoader& other); // Copy constructor
    MapLoader& operator=(const MapLoader& other); // Assignment operator
    ~MapLoader(); // Destructor

    Map* loadMap(const std::string& filename);
    bool isValidMap(const std::string& filename) const;
};

#endif
