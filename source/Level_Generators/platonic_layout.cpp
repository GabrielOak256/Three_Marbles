// The program used to generate the platonic solids level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"red", "yellow", "blue"};
const vector<string> sec_color = {"purple", "orange", "green"};

int main() {

    vector<double> radii = {0, 0.25, 0.45, 0.666666, 0.875, 1.0}; // lengths from center
    const int gray_spokes = 6;
    const int flock_spokes = 12;
    
    cout << "$board 8\n\n$freeze a true\n\n";
    cout << "$highlight_player true\n$quit_on_death true\n\n";
    cout << "$alignment_weight orange 2\n\n$alignment_weight green 2\n\n$alignment_weight purple 2\n\n";
    cout << "$collision r a 2\n$collision o a 2\n$collision y a 2\n$collision g a 2\n$collision b a 2\n$collision p a 2\n";
    cout << "$behavior r a 2\n$behavior o a 2\n$behavior y a 2\n$behavior g a 2\n$behavior b a 2\n$behavior p a 2\n\n";
    cout << "$collision red purple 0\n$behavior red purple 0\n$behavior purple red 3\n$collision red blue 1 purple\n\n";
    cout << "$collision yellow orange 0\n$behavior yellow orange 0\n$behavior orange yellow 3\n$collision yellow red 1 orange\n\n";
    cout << "$collision blue green 0\n$behavior blue green 0\n$behavior green blue 3\n$collision blue yellow 1 green\n\n";
    
    
    for (int r = 1; r < radii.size(); ++r) {
        int spokes = (r % 2) ? flock_spokes : gray_spokes; // The colors alternate outwards.
        for (int i = 0; i < spokes; ++i) {
            double radius = radii[r];
            double angle = 2 * pi * (i+0.5)/spokes; // offset by another half of 1/spokes to offset the hexagon 30 degrees from the x axis
            
            if (r % 2) {
                if (r == 3 && i == 11)
                    cout << "$place player polar " << color[floor(i/4)] << " " << radius << " " << angle << "\n";
                else if (r == 5 && !(i % 4)) {
                    cout << "$place polar " << sec_color[floor(i/4)] << " " << radius << " " << angle << "\n";
                } else
                    cout << "$place polar " << color[floor(i/4)] << " " << radius << " " << angle << "\n";
            } else {
                cout << "$place polar " << "gray" << " " << radius << " " << angle << "\n";
            }
        }
    }
    
    cout << "\n$score red == 0 min |Eliminate Red: \n$score orange == 0 min |Eliminate Orange: \n$score purple == 0 min |Eliminate Purple: ";
    
    return 0;
}
