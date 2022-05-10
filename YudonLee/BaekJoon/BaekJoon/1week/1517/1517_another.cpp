#include <iostream>
using namespace std;
int arr[500000];
int sorted[500000];
long long result = 0;

void merge(int left, int mid, int right){ 
	int leftStart = left;
	int rightStart = mid + 1;
	int sortedStart = 0;

	while(leftStart <= mid && rightStart <= right) {
		if(arr[leftStart] > arr[rightStart]) {
			sorted[sortedStart++] = arr[rightStart++];
			result += (mid - leftStart) + 1;
		} else {
			sorted[sortedStart++] = arr[leftStart++];
		}
	}

	while(leftStart <= mid) {
		sorted[sortedStart++] = arr[leftStart++];
	}	
	while(rightStart <= right) {
		sorted[sortedStart++] = arr[rightStart++];
	}

	int leftCopy = left;
	for (int i = 0; i < sortedStart; i++) {
		arr[leftCopy++] = sorted[i];
	}

}

void mergeSort(int left, int right) {
	if(left < right) {
		int mid = (left + right) / 2;
		mergeSort(left, mid);
		mergeSort(mid + 1, right);
		merge(left, mid, right);
	}
}
int main(){
	ios_base::sync_with_stdio(false);
	cin.tie(NULL);
	int N;
	cin >> N;
	for(int i = 0; i < N; i++) cin >> arr[i];
	mergeSort(0, N - 1);
	cout << result << "\n";
	return 0;	
}
