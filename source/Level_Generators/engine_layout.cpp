// The program used to generate the radial engine level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"gray", "red", "gray"};

int main() {
    
    const int piston_count = 6;
    
    vector<double> radii = {0.05, 0.5, 1.0};
    vector<double> piston_lengths = {0.6, 0.1, 0.8, 0.3, 0.9, 0.1};
    
    cout << "$board 9\n\n";
    cout << "$behavior r a 2\n$collision r a 2\n\n";
    cout << "$place player blue 0 0\n";
    
    for (int r = 0; r < radii.size(); ++r) 
        for (int i = 0; i < piston_count; ++i) {
            double radius = (r == 1) ? piston_lengths[i] : radii[r];
            double angle = 2 * pi * (i+0.5)/piston_count;
            cout << "$place polar " << color[r] << " " << radius << " " << angle << "\n";
        }
    cout << "\n$score red == 0 min |Eliminate Red: ";
    return 0;
}
