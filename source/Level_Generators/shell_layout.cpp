// The program used to generate the shell level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"yellow", "orange", "red", "brown"};

int main() {

    const int points_per_revolution = 9;
    const int revolutions = 4;
    
    cout << "If you want to add a player to this level, simply paste the below into the custom level, and add one.\n\n";
    cout << "$board 6\n\n$alignment_weight orange 2\n\n";
    cout << "$behavior brown brown 3\n$cohesion_range brown 100\n$alignment_range brown 100\n$alignment_weight brown 2\n$separation_range brown 6\n$flee_range brown 13\n$attack_range brown 5\n\n";
    cout << "$behavior yellow white 0\n$behavior yellow orange 0\n$behavior yellow red 1\n$behavior yellow brown 2\n$behavior yellow black 2\n\n";
    cout << "$behavior orange white 3\n$behavior orange yellow 3\n$behavior orange red 2\n$behavior orange brown 1\n$behavior orange black 2\n\n";
    cout << "$behavior red white 2\n$behavior red yellow 2\n$behavior red orange 1\n$behavior red brown 0\n$behavior red black 0\n\n";
    cout << "$behavior brown white 2\n$behavior brown yellow 1\n$behavior brown orange 2\n$behavior brown red 3\n$behavior brown black 3\n\n";
    cout << "$collision white black 3 $quit\n\n";
    cout << "$collision white yellow 0\n$collision white orange 0\n$collision white red 1 orange\n$collision white brown 1 yellow\n\n";
    cout << "$collision black yellow 1 brown\n$collision black orange 1 red\n$collision black red 0\n$collision black brown 0\n\n";
    cout << "$collision yellow orange 0\n$collision yellow red 1 orange\n$collision orange brown 1 yellow\n$collision red brown 0\n$collision red orange 1 red\n$collision brown yellow 1 brown\n\n";
    
    
    cout << "$place white 0 0\n";
    for (int r = 0, i = 1; r < revolutions; ++r) 
        for (int p = 0; p < points_per_revolution && i < revolutions*points_per_revolution; ++p, ++i) { 
            double radius = double(i)/(revolutions*points_per_revolution);
            double angle = 2 * pi * -(i % points_per_revolution)/points_per_revolution - pi/2;
            
            cout << "$place polar " << color[r] << " " << radius << " " << angle << "\n";
        }
    cout << "$place black 0 -1\n\n";
        
    return 0;
}
