#include <iostream>
#include <iomanip>

using namespace std;

extern "C" void _asmMain();

extern "C" void _printFloat(float f) {
    cout << setprecision(7) << f << endl;
}

extern "C" void _printDouble(double d){
    cout << setprecision(15) << d << endl;
}

int main(){
    _asmMain();
    return 0;
}