// assembler.cpp : This file contains the 'main' function. Program execution begins and ends there.
// make an input.txt and paste the assembly code there
// output.txt will contain the translated machine code
// this is a very rudimentary assembler, it does not support comments
// every instruction must be on a single line
// the assembly file gets parsed by getline and whitespace
// thus any label term must be separated from the instruction via space or tab
// all literals must be in decimal

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <bitset>
using namespace std;

string getOpcode(vector<string>& opcodeList, string op);
string getRegister(vector<string>& registerList, string reg);
bool isImm(string s);

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

	ifstream fin;
	ofstream fout;


	string inputFile = "input.txt", outputFile = "output.txt";
	fin.open(inputFile);
	fout.open(outputFile);
	
	vector<pair<string, int>> labelList;
	string line;
	int instructionAddress = 0; //assumes that the instruction address starts at 0, can change later
	while (getline(fin, line))
	{
		stringstream ss(line);

		string temp;
		string machineCode = "";
		bool opcodeSeen = false;
		string instruction = "";
		vector<string> params;

		//extracts every string from each line separated by a space
		while (ss >> temp)
		{
			if (temp.back() == ':') //keeps track of the label and ignores it from string
			{
				temp.pop_back();
				labelList.push_back(make_pair(temp, instructionAddress));
				continue;
			}

			if (!opcodeSeen) //excluding label, the first string seen is the opcode
			{
				instruction = temp;
				machineCode += getOpcode(opcodeList, temp) + "_";
				opcodeSeen = true;
			}

			else if (temp.back() == ',' || temp.back() == ';')
			{
				if (temp.back() == ';') //if ; line end is seen, increment the instruction address
					instructionAddress++;

				temp.pop_back(); //delete the , or ;

				/*
				add		rd, rs, rt
				addi	rd, rs, imm
				ldr		rt, rs, offset
				b		label(12)
				bl		(rs,) label(8)
				br		rs
				beq		rs, rt, label(4)
				*/

				//if it is a register, push it onto the param vector
				if (((temp.size() == 2 || temp.size() == 3) && temp[0] == 'r' && isdigit(temp[1])) || temp == "r_zero" || temp == "sp" || temp == "lr")
					params.push_back(getRegister(registerList, temp));
				else
				{
					if (isImm(temp)) //immediate values
					{
						params.push_back(bitset<4>(stoi(temp)).to_string());
					}
					else //labels
					{
						bool found = false;
						for (int i = 0; i < labelList.size(); i++)
						{
							if (labelList[i].first == temp)
							{
								found = true;
								if (instruction == "b")
									params.push_back(bitset<12>(labelList[i].second).to_string());
								else if (instruction == "bl")
									params.push_back(bitset<8>(labelList[i].second).to_string());
								else if (instruction == "beq")
									params.push_back(bitset<4>(labelList[i].second - instructionAddress + 1).to_string());
								else 
								{
									cout << "Error parsing instruction " + line + " at line: " + to_string(instructionAddress);
									exit(2);
								}
							}
						}
						if (!found)
						{
							cout << "Could not find label: " << temp;
							exit(2);
						}
					}
				}
			}
		}

		/*
		"add", "addi", "sub", "and",
		"or", "xor", "not", "slt",
		"lsl", "lsr", "ldr", "str",
		"b", "bl", "br", "beq"
		*/

		if (instruction == "not")
			machineCode += params[1] + "_0000_" + params[0];
		else if (instruction == "b")
			machineCode += params[0];
		else if (instruction == "bl")
			machineCode += params[0] + "_" + getRegister(registerList, "lr");
		else if (instruction == "br")
			machineCode += params[0] + "_0000_0000";
		//else if (instruction == "beq")
		//	machineCode += params[0] + "_" + params[1] + "_" + params[2];
		else if (instruction == "beq" || instruction == "ldr" || instruction == "str" || instruction == "addi" || instruction == "lsl" || instruction == "lsr")
			machineCode += params[1] + "_" + params[0] + "_" + params[2];
		else
			machineCode += params[1] + "_" + params[2] + "_" + params[0];
		fout << machineCode << endl;
	}
	cout << "Assembly successfully converted into machine code. Check output.txt\n";
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
string getRegister(vector<string>& registerList, string reg)
{
	for (int i = 0; i < registerList.size(); i++)
	{
		if (reg == registerList[i])
			return bitset<4>(i).to_string();
	}
	cout << "Invalid register: " << reg << "\n";
	exit(1);
}
bool isImm(string s)
{
	for (char c : s)
	{
		if (!isdigit(c))
			return false;
	}
	return true;
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
