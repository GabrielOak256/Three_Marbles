// The program used to generate the nebula level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const vector<string> color = {"black", "brown"};

int main() {

    // By Pythagorean's Theorem, the side length of a square inscribed in a circle of radius 1 is square root 2.
    const double dimension = pow(2, 0.5); 
    
    const int width = 7;
    const int height = 7;
    
    cout << "$board 10\n\n$collision k n 1\n$collision w k 1\n\n$place white 1 0\n\n";
    
    for (int w = -width/2; w <= width/2; ++w) 
        for (int h = -height/2; h <= height/2; ++h) 
            if (w == 0 && h == 0) 
                cout << "$place player " << color[1] << " " << (dimension * double(w)/width) << " " << (dimension * double(h)/height) << "\n";
            else 
                cout << "$place " << color[0] << " " << (dimension * double(w)/width) << " " << (dimension * double(h)/height) << "\n";
    
    cout << "\n$score black <= 42 min |Survive to 6 Black Eliminated: \n$score black <= 36 min |Survive to one quarter Black Eliminated: \n$score black <= 24 min |Survive to half of the Black Eliminated: \n$score black <= 12 min |Survive to three quarters of the Black Eliminated: \n$score black == 0 min |Survive to All Black Eliminated: ";
    
    return 0;
}
