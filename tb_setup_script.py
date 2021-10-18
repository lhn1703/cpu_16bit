import argparse
from os import remove

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str, help="verilog module file")
parser.add_argument('--clk', type=int, help='optional synchronous clock (int)')
args = parser.parse_args()
in_name = args.input.replace('.\\', '')
try:
    input_file = open(in_name, 'r')
    out_name = in_name.split('.', 1)[0] + '_tb.v'
    output_file = open(out_name, 'w')

    for line in input_file.readlines():
        if (line.find('module') > -1):
            module_name = line[7:line.find('(')] + '_tb()'
            variables =  line[line.find('(')+1:-3]   
            variables = variables.replace('output reg', 'wire')
            variables = variables.replace('output', 'wire')
            variables = variables.replace('input', 'reg')
            output_file.write('module ' + module_name + ';' + "\n")
            data_type = ('wire', 'reg')
            type_list = []
            new_type_index = 0
            variables = variables.split(', ')
            for i in range(len(variables)):
                for data in data_type:               
                    if (variables[i].find(data) > -1):
                        if (i == 0):
                            continue
                        if (i == len(variables)-1):
                            type_list.append(variables[new_type_index:i+1])   
                            break 
                        type_list.append(variables[new_type_index:i])                            
                        new_type_index = i

            for type in type_list:
                string_concat = ', '.join(type) + ' ;\n'
                output_file.write('\t' + string_concat)

            module_instantiation = module_name + ' u1('
            variables = ' '.join(variables)
            variables = variables.split(' ')
            for var in variables:
                if not (var == 'wire' or var == 'reg' or var.find(':') > -1):
                    module_instantiation += '.' + var + ", "
            module_instantiation = module_instantiation[0:-2] +  ');'
            
            if args.clk is not None:
                output_file.write('always clk = #5 clk;' + "\n") 
            output_file.write('\t' + module_instantiation + "\n")
            output_file.write('\tinital begin\n\n\tend' + "\n")
            output_file.write('endmodule' + "\n")
            
            input_file.close()
            output_file.close()
            break
        else:
            input_file.close()
            output_file.close()
            class MissingModuleError(Exception):
                pass
            raise MissingModuleError('input does not contain any modules')
except FileNotFoundError:
    print('cannot find' + in_name + 'in directory')