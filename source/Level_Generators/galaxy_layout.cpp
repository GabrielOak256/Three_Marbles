// The program used to generate the galaxy level.

#include<iostream>
#include<vector>
#include<string>
#include<cmath>

using namespace std;

const double pi = 3.1415926535;
const vector<string> color = {"red", "yellow", "blue", "gray"};
const vector<string> opp_color = {"blue", "yellow", "red", "gray"};

int main() {
    
    cout << "$board 7\n\n$highlight_player true\n$quit_on_death true\n\n$freeze a true\n\n";
    cout << "$collision r a 2\n$collision y a 2\n$collision b a 2\n";
    cout << "$behavior r a 2\n$behavior y a 2\n$behavior b a 2\n\n$place player blue 0 0\n\n";
    
    const vector<double> circumferences = {0.25, 0.75, 1.0};
    const vector<int> circumference_counts = {12, 18, 18};
    
    for (int i = 0; i < circumferences.size(); ++i) 
        for (int j = 0; j < circumference_counts[i]; ++j) 
            if (i == circumferences.size() - 1) {
                cout << "$place polar " << "gray" << " " << circumferences[i] << " " << 2 * pi * j/circumference_counts[i] << "\n";
            } else {
                if (i % 2) 
                    cout << "$place polar " << color[j % 3] << " " << circumferences[i] << " " << 2 * pi * j/circumference_counts[i] << "\n";
                else 
                    cout << "$place polar " << opp_color[j % 3] << " " << circumferences[i] << " " << 2 * pi * j/circumference_counts[i] << "\n";
                
            }
    
    cout << "\n$score red == 0 min |Eliminate Red: ";
    
    return 0;
}
