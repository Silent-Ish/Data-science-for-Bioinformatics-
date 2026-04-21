#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

// Custom sort to find error closest to zero
bool custom_sort(double a, double b) {
    return abs(a) < abs(b);
}

int main() {
    /* Initialization Phase */
    double x1[] = {2.781, 1.465, 3.396, 1.388, 3.064, 7.627, 5.332, 6.922, 8.675, 7.673};
    double x2[] = {2.550, 2.362, 4.400, 1.850, 3.005, 2.759, 2.088, 1.771, -0.242, 3.508};
    double y[] = {0, 0, 0, 0, 0, 0, 1, 1, 1, 1}; // Corrected target classes
    vector<double> error_list;
    
    double b0 = 0, b1 = 0, b2 = 0;
    double alpha = 0.01;
    double e = 2.71828;
    double err;

    /* Training Phase */
    for (int i = 0; i < 40; i++) {
        int idx = i % 10;
        
        // Calculate the linear combination
        double z = b0 + b1 * x1[idx] + b2 * x2[idx];
        
        // Apply sigmoid to get prediction 
        double pred = 1.0 / (1.0 + pow(e, -z));
        
        // Calculate error 
        err = y[idx] - pred;
        error_list.push_back(err);

        // Update coefficients using SGD 
        double gradient = alpha * err * pred * (1.0 - pred);
        b0 = b0 + gradient;
        b1 = b1 + gradient * x1[idx];
        b2 = b2 + gradient * x2[idx];

        cout << "B0=" << b0 << " B1=" << b1 << " B2=" << b2 << " error=" << err << endl;
    }

    sort(error_list.begin(), error_list.end(), custom_sort);
    cout << "\nFinal Values: B0=" << b0 << " B1=" << b1 << " B2=" << b2 << " min_error=" << error_list[0] << endl;

    /* Testing Phase */
    cout << "Enter test x1 and x2 values (e.g., 7.6737 3.5085): ";
    double test1, test2;
    cin >> test1 >> test2;
    
    double final_z = b0 + b1 * test1 + b2 * test2;
    double final_pred = 1.0 / (1.0 + pow(e, -final_z));
    
    cout << "Predicted Probability: " << final_pred << endl;
    cout << "Predicted Class: " << (final_pred > 0.5 ? 1 : 0) << endl;

    return 0;
}