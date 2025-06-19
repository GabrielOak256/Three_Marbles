// The program used to generate marble placements for the default custom level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"red", "yellow", "blue", "red", "green", "purple", "orange", "green"};

int main() { 
    
    const double turn_frac = (1 + pow(5, 0.5))/2;
    
    const int count = 8*21; // Two Fibonnacci numbers, one apart, one of which is the amount of arms. 
    
    cout << "$board 0\n\n$label 0 0 0 |Custom\\nLevel\n\n$delay 10 $quit\n\n$collision k k 0\n\n$collision w k 0\n$collision w w 0\n\n$collision r k 0\n$collision r w 0\n$collision r r 0\n\n$collision y k 0\n$collision y w 0\n$collision y r 0\n$collision y y 0\n\n$collision b w 0\n$collision b k 0\n$collision b r 0\n$collision b y 0\n$collision b b 0\n\n$collision o k 0\n$collision o w 0\n$collision o r 0\n$collision o y 0\n$collision o b 0\n$collision o o 0\n\n$collision g k 0\n$collision g w 0\n$collision g r 0\n$collision g y 0\n$collision g b 0\n$collision g o 0\n$collision g g 0\n\n$collision p k 0\n$collision p w 0\n$collision p r 0\n$collision p y 0\n$collision p b 0\n$collision p o 0\n$collision p g 0\n$collision p p 0\n\n$collision a k 0\n$collision a w 0\n$collision a r 0\n$collision a y 0\n$collision a b 0\n$collision a o 0\n$collision a g 0\n$collision a p 0\n$collision a a 0\n\n$collision n k 0\n$collision n w 0\n$collision n r 0\n$collision n y 0\n$collision n b 0\n$collision n o 0\n$collision n g 0\n$collision n p 0\n$collision n a 0\n$collision n n 0\n\n";
    
    
    for (int i = 0; i < count; i++) { // https://www.youtube.com/watch?v=bqtqltqcQhw
        double radius = pow(i/(count - 1.0) , 0.5); 
        double angle = 2 * pi * turn_frac * i; 
        
        
        // Black inner ring, gray middle ring, white outer ring, and colored spiral arms between.
        if (floor(i*color.size()/count) == 0) {
            if (i == 0) 
                cout << "$place player black 0 0\n";
            else
                cout << "$place polar " << "black" << " " << radius << " " << angle << "\n";
        } else if (floor(i*color.size()/count) == color.size()/2 - 1) {
            cout << "$place polar " << "gray" << " " << radius << " " << angle << "\n";
        } else if (floor(i*color.size()/count) == color.size() - 1) {
            cout << "$place polar " << "white" << " " << radius << " " << angle << "\n";
        } else {
            cout << "$place polar " << color[i % color.size()] << " " << radius << " " << angle << "\n";
        }
        
        // Use this print line for concentric rings.
        // cout << "place polar " << color[floor(i*color.size()/count)] << " " << radius << " " << angle << "\n";
        
        // Use this print line for spiral arms.
        // cout << "$place polar " << color[i % color.size()] << " " << radius << " " << angle << "\n";
    }
    
    return 0;
} 
