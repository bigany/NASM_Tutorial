#include <iostream>
#include <iomanip>

extern "C" void _asmMain();
extern "C" void _printString(char* s){
    std::cout << s;
    return;
}

extern "C" void _printDouble(double d){
    std::cout.setf(std::ios::fixed);
    std::cout.setf(std::ios::showpoint);
    std::cout.precision(2);
    std::cout << d << std::endl;
    return;
}

extern "C" double _getDouble(){
    double d;
    std::cin >> d;
    return d;
}

extern "C" int _getInt(){
    int i;
    std::cin >> i;
    return i;
}

int main(){
    _asmMain();
    return 0;
}