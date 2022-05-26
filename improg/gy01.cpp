#include <iostream>

using namespace std;

int main()
{
    int eletkor = 42;
    cout << "hany eves vagy csira" << endl ;
    cin >> eletkor;

    if (eletkor < 17) {
        cout << "Nagyon csira vagy" << endl;
        return 1;
    }
    cout << "Eletkorod" << eletkor << endl;
    return 0;
}
