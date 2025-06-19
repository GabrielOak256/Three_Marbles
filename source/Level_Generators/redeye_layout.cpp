// The program used to generate the Red Eye level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"red", "yellow", "blue"};

int main() {
    
    const int points_per_revolution = 9;
    const int revolutions = 3;
    
    cout << "$board 4\n\n$quit_on_death true\n\n";
    cout << "$place player blue 0 0\n";
    cout << "$place yellow -0.05 0\n";
    cout << "$place yellow 0 0.05\n";
    cout << "$place yellow 0.05 0\n";
    
    for (int r = 0, i = 0; r < revolutions; ++r) 
        for (int p = 0; p < points_per_revolution && i < revolutions*points_per_revolution; ++p, ++i) {
            double radius = double(i)/(revolutions*points_per_revolution);
            double angle = 2 * pi * (i % points_per_revolution)/points_per_revolution * ((r % 2) ? 1 : -1);
            if (i > 2)
                cout << "$place polar " << color[0] << " " << radius << " " << angle << "\n";
        }
    
    cout << "$score red == 0 min |Eliminate Red: \n$score yellow == 0 min |Eliminate Yellow: \n$score yellow == 0 max |Survive without Yellow: ";
    
    return 0;
}
