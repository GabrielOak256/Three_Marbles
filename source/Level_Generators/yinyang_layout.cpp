// The program used to generate the Yin Yang level.

#include<iostream>

using namespace std;

int main() {
    
    cout << "$board 3\n\n";
    cout << "$collision w k 3 $quit\n\n";
    cout << "$place black 0 -0.55\n";
    cout << "$place white 0 0.55\n";
    cout << "$place player blue 0.55 0\n";
    cout << "$place red 0 0\n";
    cout << "$place yellow -0.55 0\n";
    
    return 0;
}
