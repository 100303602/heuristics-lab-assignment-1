"""
Title:
    ruta.py

Description:
    Solves the optional part for the lab assignment. It receives a file with
    distances between cities, computes the path with the minimum total length,
    ands shows it to the user, together with the distance taken.

Authors:
    Alvaro Caceres Mu~noz (100303602)
    Guillermo Escobero Hernandez (100346060)
"""

import sys



distances_between_cities = []
total_distance = 0
visited_cities = []
unvisited_cities = []
number_of_cities = 0

def process_file():
    """Generates an array of graph edges (distances between cities) provided
    by the user; initializes the problem."""
    global distances_between_cities
    global number_of_cities
    global unvisited_cities

    text_file = open(sys.argv[1].strip('\r'))
    distances_between_cities = [[int(i) for i in line.strip("\r\n").split()[1:]] for line in text_file.readlines()[1:]]
    number_of_cities = len(distances_between_cities)

    # set the initial conditions of the problem (you have already visited madrid)
    unvisited_cities = range(number_of_cities)
    visit_city(0)

def visit_city(city):
    """Moves a city from the list of unvisited cities to the list of visited
    ones."""
    visited_cities.append(city)
    unvisited_cities.remove(city)

def solve_tsp():
    for i in range(number_of_cities):
        print 'TODO'
        
def show_results():
    """Prints total distance and path, according to the requested format."""
    print 'Distancia total: ', total_distance
    print 'Ruta: ', visited_cities

def main():
    process_file()
    solve_tsp()
    show_results()

if __name__ == '__main__':
    main()
