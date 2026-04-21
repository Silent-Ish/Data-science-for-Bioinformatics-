#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

// Custom sort function to find error closest to zero
bool custom_sort(double a, double b) {
    return abs(a) < abs(b);
}

int main() {
    /* Initialisation Phase */
    double x[] = {1, 2, 4, 3, 5};
    double y[] = {1, 3, 3, 2, 5};
    vector<double> error_list;
    
    double b0 = 0;
    double b1 = 0;
    double alpha = 0.01;
    double err;

    /* Training Phase */
    for (int i = 0; i < 20; i++) {
        int idx = i % 5;
        
        // Calculating prediction
        double p = b0 + b1 * x[idx];
        
        // Calculating error
        err = p - y[idx];
        error_list.push_back(err);

        // Updating coefficients (Gradient Descent)
        b0 = b0 - alpha * err;
        b1 = b1 - alpha * err * x[idx];

        cout << "B0=" << b0 << " B1=" << b1 << " error=" << err << endl;
    }

    // Sort based on absolute error values
    sort(error_list.begin(), error_list.end(), custom_sort);
    
    cout << "Final Values: B0=" << b0 << " B1=" << b1 << " min_error=" << error_list[0] << endl;

    /* Testing Phase */
    cout << "Enter a test x value: ";
    double test;
    if (!(cin >> test)) return 0;
    
    double pred = b0 + b1 * test;
    cout << "The value predicted by the model = " << pred << endl;

    return 0;
}