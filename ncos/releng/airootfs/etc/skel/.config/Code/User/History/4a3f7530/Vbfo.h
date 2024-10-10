// Map.h
#ifndef MAP_H
#define MAP_H

#include <string>
#include <vector>
#include <iostream>

using namespace std;

// Forward declarations
class Continent;
class Player;

class Territory {
private:
    string* name;
    Player* owner;
    int* armies;
    vector<Territory*>* adjacentTerritories;
    string* continent;

public:
    Territory(const string& name, Player* owner, int armies);
    Territory(const Territory& other); // Copy constructor
    Territory& operator=(const Territory& other); // Assignment operator
    ~Territory(); // Destructor
    
    void addAdjacentTerritory(Territory* territory);
    const vector<Territory*>& getAdjacentTerritories() const;
    bool isAdjacent(const Territory* territory) const;
    
    
    const string& getName() const { return *name; }
    const string& getContinent() const { return *continent; }

    // Stream insertion operator
    friend ostream& operator<<(ostream& out, const Territory& territory);
};

class Continent {
private:
    string* name;
    vector<Territory*>* territories;

public:
    Continent(const string& name);
    Continent(const Continent& other); // Copy constructor
    Continent& operator=(const Continent& other); // Assignment operator
    ~Continent(); // Destructor
    
    const string& getName() const { return *name; } //getter
    vector<Territory*> getTerritories() const {return *territories;}
    
    void addTerritory(Territory* territory);
    bool isConnectedSubgraph() const;
    
    friend ostream& operator<<(ostream& out, const Continent& continent);
};

class Map {
private:
    vector<Territory*>* territories;
    vector<Continent*>* continents;


public:
    Map();
    Map(const Map& other); // Copy constructor
    Map& operator=(const Map& other); // Assignment operator
    ~Map(); // Destructor
    
    void addTerritory(Territory* territory);
    void addContinent(Continent* continent);
    
    const vector<Continent*>& getContinents() const { return *continents; }

    
    bool validate() const;
    bool isConnectedGraph() const;
    bool areContinentsConnected() const;
    bool isTerritoryInOneContinent() const;
    
    
    friend ostream& operator<<(ostream& out, const Map& map);
};

class MapLoader {
public:
    MapLoader();
    MapLoader(const MapLoader& other); // Copy constructor
    MapLoader& operator=(const MapLoader& other); // Assignment operator
    ~MapLoader(); // Destructor

    Map* loadMap(const string& filename);
    bool isValidMap(const string& filename) const;
    
    private:
    bool parseMapSection(ifstream& file, Map* map);
    bool parseContinentsSection(ifstream& file, Map* map);
    bool parseTerritoriesSection(ifstream& file, Map* map);
};

//Free function for testing
void testLoadMaps(); 

#endif