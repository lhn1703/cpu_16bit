import argparse
from os import remove

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str, help="verilog module file")
parser.add_argument('--clk', type=int, help='optional synchronous clock (int)')
args = parser.parse_args()
in_name = args.input.replace('.\\', '')

def remove_char(str, n):
      first_part = str[:n] 
      last_part = str[n+1:]
      return first_part + last_part

try:
    input_file = open(in_name, 'r')
    out_name = in_name.split('.', 1)[0] + '_tb.v'
    output_file = open(out_name, 'w')

    f = input_file.read();
    if 'module' in f:
        f = f[f.find('module'): f.find(';')+1]
        f = f.replace('\n', ' ')
        f = f.replace('\t', '')
        if (f[f.find('(')+1] == ' '):
            f = remove_char(f, f.find('(')+1)
        if (f[f.find(')')-1] == ' '):
            f = remove_char(f, f.find('(')-1)
        line = f
        if (line.find('#') > -1):
            params = line[line.find('#'):line.find('(')+1]
            line = line[line.find('(')+1:]
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
                if (variables[i][0:5].find(data) > -1):
                    if (i == 0):
                        continue
                    if (i == len(variables)-1):
                        type_list.append(variables[new_type_index:i+1])   
                        break 
                    type_list.append(variables[new_type_index:i])                            
                    new_type_index = i
        type_list.append(variables[new_type_index:len(variables)])             
        for type in type_list:
            string_concat = ', '.join(type) + ';\n'
            output_file.write('\t' + string_concat)

        module_instantiation = module_name + ' u1('
        variables = ' '.join(variables)
        variables = variables.split(' ')
        for var in variables:
            if not (var == 'wire' or var == 'reg' or var.find(':') > -1):
                module_instantiation += '.' + var + ", "
        module_instantiation = module_instantiation[0:-2] +  ');'
        
        if args.clk is not None:
            output_file.write('\n\talways clk = #5 clk;' + "\n") 
        output_file.write('\n\t' + module_instantiation + "\n")
        output_file.write('\n\tinital begin\n\n\tend' + "\n")
        output_file.write('\nendmodule' + "\n")
        
        input_file.close()
        output_file.close()
    else:
        input_file.close()
        output_file.close()
        class MissingModuleError(Exception):
            pass
        raise MissingModuleError('input does not contain any modules');
except FileNotFoundError:
    print('cannot find' + in_name + 'in directory')