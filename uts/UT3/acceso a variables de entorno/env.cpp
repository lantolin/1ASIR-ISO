#include <iostream>
#include <cstdlib>
 
int main()
{
   std::cout << "USER: " << std::getenv("USER") << '\n';
   std::cout << "UNA_VARIABLE: " << std::getenv("UNA_VARIABLE") << '\n';
   std::cout << "OTRA_VARIABLE: " << std::getenv("OTRA_VARIABLE") << '\n';
}
