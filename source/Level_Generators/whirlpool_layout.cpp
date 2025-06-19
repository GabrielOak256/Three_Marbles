// The program used to generate the whirlpool level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"blue", "blue", "yellow", "red", "yellow"};

int main() {

    const double turn_frac = 0.903; // chosen arbitrarily because the result looks nice
    const int count = 60; 
    
    const double vertical_offset = 0.25;
    
    cout << "$board 2\n\n$highlight_player true\n\n$vampiric_player true\n\n$place player blue 0 " << vertical_offset << "\n";
    
    for (int i = 1; i < count; i++) { // https://www.youtube.com/watch?v=bqtqltqcQhw
        double radius = (1 + vertical_offset) * i/(count - 1.0); 
        double angle = 2 * pi * turn_frac * i; 
        double x = cos(angle) * radius;
        double y = vertical_offset + (sin(angle) * radius);
        if (y < 1.0 && x < cos(asin(y))) 
            cout << "$place " << color[floor(i*color.size()/count)] << " " << x << " " << y << "\n";
    }
    
    
    cout << "\n$score red == 0 min |Eliminate Red: ";
    
    return 0;
}
