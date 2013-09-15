#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main()
{
    for(;;)
    {
        string ip, host, gw, mask;
        cin >> ip >> host >> gw >> mask;
        if (ip.empty()) break;
        size_t s = host.find(".hosts.advancedfiltering.net");
        if (s != string::npos) host.resize(s);
        {
            ofstream f((host + ".ip6").c_str());
            f << ip;
        }
        {
            ofstream f((host + ".ip6.gw").c_str());
            f << gw;
        }
        {
            ofstream f((host + ".ip6.pfx").c_str());
            f << mask;
        }
    }
}
