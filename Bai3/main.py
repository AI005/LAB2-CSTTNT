import Parse
import re

#TOKEN_REGEX = r"[A-Za-z0-9_]+|:\-|[()\.,]"
TOKEN_REGEX = r"'(.*?)'|[A-Za-z0-9_]+|:\-|[()\.,]"
ATOM_NAME_REGEX = r"^[A-Za-z0-9_]+$"
VARIABLE_REGEX = r"^[A-Z_][A-Za-z0-9_]*$"

# Regex to parse comment strings. The first group captures quoted strings (
# double and single). The second group captures regular comments ('%' for
# single-line or '/* */' for multi-line)
COMMENT_REGEX = r"(\".*?\"|\'.*?\')|(/\*.*?\*/|%[^\r\n]*$)"


def remove_comments(input_text):
    """Return the input text string with all of the comments removed from it"""

    # Create a regular expression Pattern object we can use to find and strip out
    # comments. The MULTILINE flag tells Python to treat each line in the string
    # separately, while the DOTALL flag indicates that we can match patterns
    # which span multiple lines (so our multi-line comments '/* */' can  be
    # processed)
    regex = re.compile(COMMENT_REGEX, re.MULTILINE | re.DOTALL)

    def remove_comment(match):
        """If we found a match for our 2nd group, it is a comment, so we remove"""
        if match.group(2) is not None:
            return ""
        # Otherwise, we found a quoted string containing a comment, so we leave
        # it in
        else:
            return match.group(1)

    return regex.sub(remove_comment, input_text)

def parse_tokens_from_string(input_text):
    """Convert the input text into a list of tokens we can iterate over / process"""
    iterator = re.finditer(TOKEN_REGEX, remove_comments(input_text))
    return [token.group() for token in iterator]

def parseClause(iterator):
    clauses = []
    flag = True
    right = -1
    left = 0
    while flag:
        try:
            right = iterator.index('.', left)
        except Exception as e:
            break
        clauses.append(iterator[left:right+1])
        left = right + 1
         
    return clauses


facts = dict()
rules = dict()

#return relation, parameters
def get_component_of_query(clause):
    return clause[0], [a for a in clause[1:] if a not in ['(',')','.',',']]
    
def add_to_facts(clause):
    global facts
    # relation = clause[0]
    # item = [a for a in clause[1:] if a not in ['(',')','.',',']]
    relation, item = get_component_of_query(clause)
    if relation in facts.keys():
        facts[relation].append(item)
    else:
        facts[relation] = [item]

def add_to_rules(clause):
    head = clause[0:clause.index(':-')]
    body = clause[clause.index(':-') + 1:]
    #print(head, body)
    #print(clause)
    relation, params = get_component_of_query(head)
    item = dict()
    item['params'] = params

    list_sub_rules = []
    left = 0
    right = -1
    while True:
        try:
            right = body.index(')', left)
            list_sub_rules.append(get_component_of_query(body[left:right]))
            left = right + 2
        except Exception as e:
            break    
    item['defi'] = list_sub_rules
    if relation in rules.keys():
        rules[relation].append(item)
    else:
        rules[relation] = [item]
    
    
def classify(clauses):
    for clause in clauses:
        if ':-' not in clause:
            add_to_facts(clause)
        else:
            add_to_rules(clause)

def is_Var(param):
    return (param == '_') or (param[0].isupper())

def check_for_vars(parameters):
    cont_vars = False
    var_positions = []
    for word in parameters:
        var_positions.append(is_Var(word))
    
    if True in var_positions:
        cont_vars = True
    return cont_vars, var_positions


def solve_facts(component_of_query):
    relation = component_of_query[0]
    params_query = component_of_query[1]
    
    cont_vars, var_positions = check_for_vars(params_query)
    matches = []
    #print(var_positions)
    if cont_vars:
        for param in facts[relation]:
            match = True
            for pos, var, rel in zip(var_positions, params_query, param):
                if pos:
                    continue
                elif var == rel:
                    continue
                else:
                    match = False
                    
            if match:
                matches.append(param)
        result = ""
        index = 0   
        for i in range(len(matches)):
            for j in range(len(var_positions)):
                if var_positions[j] == True:
                    result += params_query[j] + ' = ' + str(matches[index][j]) + ',\n'
            index += 1
            result = result[0:-2] + ';' + '\n'
        return result.strip()
                
            
                
    elif params_query in facts[relation]:
        return True
    else:
        return False

def solve_rules(component_of_query):
    relation = component_of_query[0]
    
    if relation not in rules.keys():
        return False
    params_query = component_of_query[1]
    
    for body in rules[relation]:
        for i in range(len(params_query)):
            globals()[body['params'][i]] = params_query[i]
        
        for rule in body['defi']:
            print(rule)
            rel = rule[0]
            pars = [globals()[a] for a in rule[1]]
            comp_rule = (rel, pars)
            
            ans = process(comp_rule)
            
            if ans == False:
                return ans
            else:
                continue
            
    return True
    
    
            


def process(component_of_query):
    relation = component_of_query[0]
    
    if relation not in facts.keys():
        return solve_rules(component_of_query)
    else:
        return solve_facts(component_of_query)
    

#Type and run query
def shell():
    running = True
    
    while running:
        print('?- ', end='')
        query = input()
        
        if query == 'exit':
            running = False
        else:
             parsed_query = re.finditer(TOKEN_REGEX, query)
             parsed_query = [token.group() for token in parsed_query]
             comp_query = get_component_of_query(parsed_query)
             print("component of query: ", comp_query)
             
             try:
                 result = process(comp_query)
                 print(result)
             except Exception as e:
                 print(e)
        

if __name__ == '__main__':
    
    input_file = 'family.pl'
    try:
        file_in = open(input_file, 'r')
        text_input = file_in.read()
        #print(text_input)
        itera = parse_tokens_from_string(text_input)
        #print(itera)
        clauses = parseClause(itera)
        classify(clauses)
        #print(facts)
        print(rules)
        shell()
        
        
    except Exception as e:
        print(e)

    