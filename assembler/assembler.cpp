// assembler.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <bitset>
using namespace std;

class instruction
{
private:
	string label;
	string opcode;
	string rs;

};


string getOpcode(vector<string>& opcodeList, string op);
int main()
{
	vector<string> opcodeList = {
		"add", "addi", "sub", "and",
		"or", "xor", "not", "slt",
		"lsl", "lsr", "ldr", "str",
		"b", "bl", "br", "beq"
	};
	vector<string> registerList;
	for (int i = 0; i < 13; i++)
	{
		registerList.push_back("r" + to_string(i));
	}
	registerList.push_back("r_zero");
	registerList.push_back("sp");
	registerList.push_back("lr");

	for (string s : registerList)
		cout << s << endl;
}



string getOpcode(vector<string>& opcodeList, string op)
{
	for (int i = 0; i < opcodeList.size(); i++)
	{
		if (op == opcodeList[i])
			return std::bitset<4>(i).to_string();
	}
	cout << "Invalid opcode: " << op << "\n";
	exit(1);
}


// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
