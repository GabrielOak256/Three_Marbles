// The program used to generate the tutorial level.
// Nothing special in this one.

#include<iostream>

using namespace std;

int main() {
    
    cout << "$board 0\n\n";
    cout << "$place red random random\n";
    cout << "$delay 1 $place yellow 0 0\n";
    cout << "$delay 1 $place player blue 0 0\n";
    cout << "$delay 2\n";
    cout << "$delay 3 repeat $place red random random\n";
    cout << "$delay 3 repeat $place yellow random random\n";
    cout << "$delay 3 repeat $place blue random random\n";
    
    cout << "\n$score yellow == 0 max |Latest without Yellow: \n";
    cout << "$score red >= 6 min |Earliest with 6 Red: ";
    
    return 0;
}
