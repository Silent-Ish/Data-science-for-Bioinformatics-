// Week 2 Practical Exercise
#include <iostream>
#include <string>

// This statement allows us to use cout and cin directly
using namespace std;

int main() {
    // Variable declaration
    string name;

    // Output to screen
    cout << "What is your name? ";

    // Input from keyboard
    getline(cin, name);

    // Output final greeting
    cout << "Hello, " << name << "!" << endl;

    return 0;
}