// assembler.cpp : This file contains the 'main' function. Program execution begins and ends there.
// make an input.txt and paste the assembly code there
// output.txt will contain the translated machine code
// this is a very rudimentary assembler, it does not support comments
// every instruction must be on a single line
// the assembly file gets parsed by getline and whitespace
// thus any label term must be separated from the instruction via space or tab
// all literals must be in decimal
// b range is 2^12 - 1
// bl range is 2^8 - 1
// beq range is only -8 to +7
// vector out of range can mean missing semicolon

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

	//string inputFile = "input.txt", outputFile = "output.txt";
	string inputFile, outputFile;

	cout << "Enter input file name: ";
	cin >> inputFile;

	fin.open(inputFile);
	if (fin.fail())
	{
		cout << "Could not find " << inputFile << endl;
		exit(1);
	}

	outputFile = inputFile.substr(0, inputFile.size() - 4) + "_machine_code.txt";
	fout.open(outputFile);
	
	vector<pair<string, int>> labelList;
	string line;
	int instructionAddress = 0; //assumes that the instruction address starts at 0, can change later

	while (getline(fin, line)) //first pass to extract all labels from the assembly code
	{
		stringstream ss(line);
		string temp;
		ss >> temp;
		if (temp.back() == ':')
		{
			temp.pop_back();
			labelList.push_back(make_pair(temp, instructionAddress));
			cout << temp + "_" + to_string(instructionAddress) + "\n";
			instructionAddress++;
			continue;
		}
		instructionAddress++;
	}

	fin.clear();
	fin.seekg(0);

	instructionAddress = 0; //assumes that the instruction address starts at 0, can change later

	while (getline(fin, line)) //extracts each instruction by line
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
			if (temp.back() == ':') //ignores labels on the second pass
				continue;

			if (!opcodeSeen) //excluding label, the first string detected must be the opcode
			{
				instruction = temp;
				machineCode += getOpcode(opcodeList, temp) + "_";
				opcodeSeen = true;
			}
			else if (temp.back() == ',' || temp.back() == ';') //if is not the opcode then it is a parameter
			{
				if (temp.back() == ';') //if semicolon is seen, increment the instruction address
					instructionAddress++;
					
				temp.pop_back(); //delete the , or ; from the param string

				//if it is a register, push it onto the param vector
				if (((temp.size() == 2 || temp.size() == 3) && temp[0] == 'r' && isdigit(temp[1])) || temp == "r_zero" || temp == "sp" || temp == "lr")
					params.push_back(getRegister(registerList, temp));
				else
				{
					if (isImm(temp)) //push immediate values
					{
						params.push_back(bitset<4>(stoi(temp)).to_string());
					}
					else //push label or raise exception
					{
						bool found = false;
						for (int i = 0; i < labelList.size(); i++)
						{
							if (labelList[i].first == temp)
							{
								found = true;
								if (instruction == "b") //branch label is 12 bits of the absolute instruction address
									params.push_back(bitset<12>(labelList[i].second).to_string());
								else if (instruction == "bl") //branch and link label is 8 bits signed offset from current instruction to label
									params.push_back(bitset<8>(labelList[i].second - instructionAddress).to_string());
								else if (instruction == "beq") //branch on equal is 4 bits signed offset from current instruction to label
									params.push_back(bitset<4>(labelList[i].second - instructionAddress).to_string());
								else 
								{
									cout << "Error parsing instruction " + line + " at line: " + to_string(instructionAddress);
									exit(2);
								}
							}
						}
						if (!found) //catches any errors while parsing label
						{
							cout << "Could not parse: " << temp << " at line: " + to_string(instructionAddress);
							exit(3);
						}
					}
				}
			}
		}

		//writes the machine code to the file
		if (instruction == "not")
			machineCode += params[1] + "_0000_" + params[0];
		else if (instruction == "b")
			machineCode += params[0];
		else if (instruction == "bl")
			machineCode += params[0] + "_" + getRegister(registerList, "lr");
		else if (instruction == "br")
			machineCode += params[0] + "_0000_0000";
		else if (instruction == "beq" || instruction == "ldr" || instruction == "str" || instruction == "addi" || instruction == "lsl" || instruction == "lsr")
			machineCode += params[1] + "_" + params[0] + "_" + params[2];
		else
			machineCode += params[1] + "_" + params[2] + "_" + params[0];
		fout << machineCode << endl;
	}
	cout << "Assembly successfully converted into machine code. Check " + outputFile + "\n";
	return 0;
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