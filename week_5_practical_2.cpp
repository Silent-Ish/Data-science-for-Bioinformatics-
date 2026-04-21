#include <iostream>
using namespace std;

int main() {
    int mark1, mark2, mark3, mark4;
    int grade;

    cout << "Type 1st mark: "; cin >> mark1;
    cout << "Type 2nd mark: "; cin >> mark2;
    cout << "Type 3rd mark: "; cin >> mark3;
    cout << "Type 4th mark: "; cin >> mark4;

    grade = (mark1 + mark2 + mark3 + mark4) / 4;

    if (grade < 50) { 
        cout << "Fail" << endl; 
    } else {
        cout << "Pass" << endl;  
    }

    return 0;
}