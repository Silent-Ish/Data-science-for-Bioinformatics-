#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

// Function to split a string by a delimiter 
std::vector<std::string> split(const std::string& line, char delimiter) {
    std::vector<std::string> tokens;
    std::string token;
    std::istringstream tokenStream(line);
    while (std::getline(tokenStream, token, delimiter)) {
        tokens.push_back(token);
    }
    return tokens;
}

int main() {
    
    std::string filename = "titanic_data.csv"; 

    std::ifstream file(filename);

    if (!file.is_open()) {
        std::cerr << "Could not open the file: " << filename << std::endl;
        std::cerr << "Ensure the .csv file is in the same folder as your code." << std::endl;
        return 1;
    }

    std::string line;
    int rowCount = 0;

    // Read and print the first 10 rows
    while (std::getline(file, line) && rowCount < 10) {
        std::vector<std::string> columns = split(line, ',');

        for (const auto& col : columns) {
            std::cout << col << "\t";
        }
        std::cout << std::endl;
        rowCount++;
    }

    file.close();
    return 0;
}