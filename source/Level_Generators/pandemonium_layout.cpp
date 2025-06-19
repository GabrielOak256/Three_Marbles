// The program used to generate the Pandemonium level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const vector<string> color = {"blue", "black", "red"};

int main() {
    
    const double inner_count = 3;
    const double inner_width = 0.0625;
    const double inner_slope = -10;
    const double inner_offset = 0.1;
    
    const double outer_count = 7;
    const double outer_width = 0.75;
    const double outer_slope = -0.5;
    const double outer_offset = 0.333333;
    
    cout << "$board 11\n\n$quit_on_death true\n\n$place player blue 0 0\n";
    
    for (int i = -floor(inner_count/2); i < ceil(inner_count/2); ++i) {
        double x = (i / floor(inner_count/2))*inner_width;
        double y = inner_slope*pow(x,2) + inner_offset;    // y = a(x - h)^2 + k
        cout << "$place " << color[1] << " " << x << " " << y << "\n";
        cout << "$place " << color[1] << " " << x << " " << -y << "\n";
    }
    
    for (int i = -floor(outer_count/2); i < ceil(outer_count/2); ++i) {
        double x = (i / floor(outer_count/2))*outer_width;
        double y = outer_slope*pow(x,2) + outer_offset;    // y = a(x - h)^2 + k
        cout << "$place " << color[2] << " " << x << " " << y << "\n";
        cout << "$place " << color[2] << " " << x << " " << -y << "\n";
    }
    
    return 0;
}
