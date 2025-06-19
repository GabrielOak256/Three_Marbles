// The program used to generate the moon level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const vector<string> color = {"red", "yellow", "blue"};

const double pi = 3.1415926535;
const double corner = 1/pow(2, 0.5);

int main() {

    cout << "$board 1\n\n$quit_on_death true\n\n";
    
    cout << "$place player " << color[2] << " " << -0.5 << " " << 0 << "\n";
    cout << "$place " << color[2] << " " << 0.5 << " " << 0 << "\n";
    
    cout << "$place " << color[0] << " " << 0.5 << " " << -0.333333 << "\n";
    cout << "$place " << color[0] << " " << 0.5 + 0.1 << " " << 0.333333 << "\n";
    cout << "$place " << color[0] << " " << 0.5 - 0.1 << " " << 0.333333 << "\n";
    
    cout << "$place " << color[0] << " " << -0.5 << " " << 0.333333 << "\n";
    cout << "$place " << color[0] << " " << -0.5 + 0.1 << " " << -0.333333 << "\n";
    cout << "$place " << color[0] << " " << -0.5 - 0.1 << " " << -0.333333 << "\n";
    
    
    cout << "$place " << color[1] << " " << 0.5 << " " << 0.666666 << "\n";
    cout << "$place " << color[1] << " " << 0.5 + 0.1 << " " << -0.666666 << "\n";
    cout << "$place " << color[1] << " " << 0.5 - 0.1 << " " << -0.666666 << "\n";
    
    cout << "$place " << color[1] << " " << -0.5 << " " << -0.666666 << "\n";
    cout << "$place " << color[1] << " " << -0.5 + 0.1 << " " << 0.666666 << "\n";
    cout << "$place " << color[1] << " " << -0.5 - 0.1 << " " << 0.666666 << "\n";
    
    cout << "$place " << color[0] << " " << 0 << " " << 0 << "\n";
    
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*0.25 + 0.05 << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*0.25 - 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*0.75 + 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*0.75 - 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*1.25 + 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*1.25 - 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*1.75 + 0.05  << "\n";
    cout << "$place polar " << color[0] << " " << 1 << " " << pi*1.75 - 0.05  << "\n";
    
    
    cout << "$place " << color[0] << " " << 0 << " " << 1 << "\n";
    cout << "$place " << color[0] << " " << 0 << " " << -1 << "\n";
    
    cout << "$place " << color[1] << " " << corner << " " << corner << "\n";
    cout << "$place " << color[1] << " " << corner << " " << -corner << "\n";
    cout << "$place " << color[1] << " " << -corner << " " << corner << "\n";
    cout << "$place " << color[1] << " " << -corner << " " << -corner << "\n";
    
    cout << "\n$score red == 0 min |Eliminate Red: \n";
    cout << "$score yellow == 0 min |Eliminate Yellow: ";
    
    return 0;
}
