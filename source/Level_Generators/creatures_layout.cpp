// The program used to generate the creatures level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"orange", "green", "purple"};

int main() {

    const int orange_count = 18;
    const int green_count = 36;
    const int green_layers = 3;
    const int purple_count = 12;
    
    cout << "$board 5\n\n$highlight_player true\n$quit_on_death true\n\n$alignment_weight green 2\n\n$place player green 0 0\n"; 
    
    for (int i = 0; i < orange_count; i++) {
        double radius = 0.75;
        double angle = (pi * i)/orange_count - pi/2;
        cout << "$place polar " << color[0] << " " << radius << " " << angle << "\n";
    }
    
    for (int i = 0; i < green_layers; i++) 
        for (int j = 0; j < green_count/green_layers; j++) {
            double radius = (i+1) * 0.1;
            double angle = 2 * pi * j/(green_count/green_layers);
            cout << "$place polar " << color[1] << " " << radius << " " << angle << "\n";
        }
    
    for (int i = 0; i < purple_count/3; i++)
        for (int j = 0; j < 3; j++) {
            double x = ((i - 1)*0.1) - 0.875;
            double y = ((i - 1)*0.1);
            cout << "$place " << color[2] << " " << x << " " << y << "\n";
        }
    
    cout << "$score purple == 0 min |Eliminate Purple Scavengers: \n$score orange == 0 min |Eliminate Orange Pack: \n$score green == 1 max |Survive Alone: ";
    
    return 0;
}
