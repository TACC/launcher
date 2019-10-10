#include <iostream>
#include <iomanip>
#include <cstdlib>      //defines rand(), srand(), RAND_MAX
#include <ctime>        //defines ctime() for random numbers
#include <cmath>        //defines math functions
using namespace std;

//calculates the distance of the dart from the origin
double dist(double x, double y){
  double throwDist;
  throwDist = sqrt(x*x) + sqrt(y*y);  //Euclidean Distance Formula from point (0,0)
  return throwDist;
}

//calculates pi using number of darts thrown in the circle vs all darts thrown
double pie(int numThrows, double a){
    double pieValue = a / numThrows;
    return pieValue;
}

int main()
{
    double coord_x, coord_y, test;
    srand(time(NULL));      //creates the seed time
    test = rand() / double(RAND_MAX);
    double throwDist;       //distance from the origin
    double a = 0;              //times a dart ends up inside the circle
    long int numThrows=4000000000;          //times to throw the dart

    for(int i = 1; i <= numThrows; i++){
        coord_x = (double)rand() / (RAND_MAX);
        coord_y = (double)rand() / (RAND_MAX);
        if(dist(coord_x, coord_y) <= 1)
            a++;
        }
    double pieCalc = pie(numThrows, a);
    cout<<setw(24) << "The value of PI is: " << pieCalc<<endl;
    return 0;
}

