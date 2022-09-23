'''
b range is 2^12 - 1
bl range is 2^8 - 1
beq range is only -8 to +7
'''

import argparse

parser.add_argument('-i','--input', help='input assembly file name', required=True)
args = parser.parse_args()

input_file_name = args.i
output_file_name = input_file_name.split('.')[0] + '_machine_code.txt'

binary_list = ['0000', '0001', '0010', '0011', '0100', '0101', '0110', '0111', '1000', '1001', '1010', '1011', '1100', '1101', '1110', '1111']
opcode_list = [
    "add", "addi", "sub", "and",
    "or", "xor", "not", "slt",
    "lsl", "lsr", "ldr", "str",
    "b", "bl", "br", "beq"
    ]
register_list = ['r' + str(i) for i in range(13)] + ['r_zero', 'sp','lr']

opcode_dict = {}
register_dict = {}

for i in range(len(binary_list)):
    opcode_dict[opcode_list[i]] = binary_list[i]
    register_dict[register_list[i]] = binary_list[i]

with open(input_file_name, 'r') as input_file:
    input_file_string = input_file.read()
input_lines = input_file_string.splitlines()

# removing comments from the assembly code
for i in range(len(input_lines)):
    current_line = input_lines[i]
    if len(current_line) < 3 or current_line[:2] == '//':
        del input_lines[i]
    elif '//' in current_line:
        input_lines[i] = current_line.split('//')[0]

# first pass to extract all labels and strips them
labels_dict = {}

for i in range(len(input_lines)):
    current_line = input_lines[i]
    if ':' in current_line:
        label = current_line.split(':')[0]
        labels_dict[label] = i
        print('label {} found at line {}'.format(label, i))
        input_lines[i] = current_line.split(':')[1]
    

