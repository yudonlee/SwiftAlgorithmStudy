#include <iostream>
#include <set>

using namespace std;

int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);

	int N;
	cin >> N;
	long long count = 0;
	int input_number;
	set<int> inputs;
	// log(N^2)! 
	for (int i = 0; i < N; i++) {
		cin >> input_number;
		set<int>::iterator it = inputs.lower_bound(input_number);
		//this part generate TLE. because distance method's time complexity is N. 
		std::size_t dist = std::distance(it, inputs.end());
		
		inputs.insert(input_number);
		
		count += dist;
	}
	cout << count << "\n";
	return 0;
}
