import math
import re

operator_precedence = {
    "!": 4,
    '^': 3,
    "*" : 2,
    "/": 2,
    "+": 1,
    "-": 1
}

def get_operator_precedence(operator):
    if operator in operator_precedence:
        return operator_precedence[operator]
    return None

left_assoc = ["/", "-"]

class RPN:
    _operator_n_operands = {
        "+": 2,
        "-": 2,
        "*": 2,
        "/": 2,
        "^": 2,
        "log": 2,
        "lg": 1,
        "ln": 1,
        "!": 1,
        "sin": 1,
        "cos": 1,
        "tan": 1,
        "abs": 1
    }

    stack = []

    def is_operation(self, operation):
        return operation in self._operator_n_operands

    def solve(self, expression):
        # Expression is a space delimited list of operators and operands\
        self.stack = []
        elements = expression.strip().split(" ")

        for i in elements:
            if i is "":
                continue
            try:
                self._operator_n_operands[i]
                self.do_operation(i)
            except:
                try:
                    self.stack.append(float(i))
                except:
                    print("Invalid expression")

        return self.stack
    
    def do_operation(self, operator):
        n_operands = self._operator_n_operands[operator]

        if n_operands is None or n_operands > len(self.stack):
            print("That's not a valid operation.")
            return
        
        operands = []
        for i in range(n_operands):
            operands.append(self.stack.pop())

        operands.reverse()

        value = 0

        if operator == "+":
            value = operands[0] + operands[1]
        elif operator == "-":
            value = operands[0] - operands[1]
        elif operator == "*":
            value = operands[0] * operands[1]
        elif operator == "/":
            if operands[1] == 0:
                print("Cannot divide by 0")
                return
            value = operands[0] / operands[1]
        elif operator == "^":
            value = operands[0] ** operands[1]
        elif operator == "log":
            value = math.log(operands[1], operands[0])
        elif operator == "lg":
            value = math.log10(operands[0])
        elif operator == "ln":
            value = math.log(operands[0])
        elif operator == "!":
            value = math.factorial(operands[0])
        elif operator == "sin":
            value = math.sin(operands[0])
        elif operator == "cos":
            value = math.cos(operands[0])
        elif operator == "tan":
            value = math.tan(operands[0])
        elif operator == "abs":
            value = abs(operands[0])

        self.stack.append(value)

    def print_stack(self):
        print("Stack: " + ", ".join([str(i) for i in self.stack]))

def is_number(n):
    try:
        float(n)
    except:
        return False
    return True

def add_asterisks(match):
    return(match[0] + "*")

rpn = RPN()

mode = ""
while mode not in ["1", "2", "3"]:
    mode = input("Select a mode, 1 for calculator mode 2 for expression mode, 3 for infix expression mode: ")

if mode == "1":
    print("Calculator mode. Input operands and operations one at a time, press enter after each.")
    while True:
        rpn.print_stack()
        inp = input()
        if(inp == "cl"):
            rpn.stack = []
        elif rpn.is_operation(inp):
            rpn.do_operation(inp)
        else:
            try:
                rpn.stack.append(float(inp))
            except:
                print("Invalid input")
elif mode == "2":
    print("Expression mode.")
    while True:
        inp = input()
        out = rpn.solve(inp)
        print(" = " + " ".join([str(i) for i in out]))
else:
    # TODO: Finish this
    print("Infix notation solver.")
    while True:
        inp = input()
        expression = inp.replace(" ", "")
        expression = re.sub("[0-9](?=[\(A-Za-z])", add_asterisks, expression)

        temp = "" # Used to build numbers and functions

        output = []
        operator_stack = []

        was_symbol = False # Was the last thing that was checked a symbol? 

        while expression is not "":
            match = re.search("\A(?<![0-9.A-z\)])-?[0-9]*\.?[0-9]*", expression) # Check for numbers
            if match and len(match[0]) > 0:
                if(was_symbol and "-" in match[0] or match[0] is "-"):
                    # It's actually a minus operation, not a negative sign
                    operator_stack.append("-")
                    expression = expression[1:]
                    was_symbol = False
                else:
                    # It's a number or variable, put it on the output
                    output.append(match[0])
                    expression = re.sub("\A(?<![0-9.A-z\)])-?[0-9]*\.?[0-9]*|\A(?<![A-z])[A-z](?![A-z])", "", expression)
                    was_symbol = True
            else:
                match = re.match("\A[+*\/\(\)]|\A[A-z]+", expression)
                if(match):
                    # Operation or function
                    operation = match[0]
                    precedence = get_operator_precedence(operation)

                    if precedence is not None and len(operator_stack) is not 0:
                        stack_precedence = get_operator_precedence(operator_stack[len(operator_stack)-1])
                        if stack_precedence is not None:
                            while precedence < stack_precedence or precedence == stack_precedence and operation not in left_assoc:
                                output.append(operator_stack.pop())
                                if len(operator_stack) is 0:
                                    break

                                stack_precedence = get_operator_precedence(operator_stack[len(operator_stack)-1])
                                if stack_precedence is None:
                                    break

                        operator_stack.append(operation)
                        was_symbol = False
                    elif operation == "(":
                        operator_stack.append(operation)
                        was_symbol = False
                    elif operation == ")":
                        pop = operator_stack.pop()
                        while pop is not "(":
                            output.append(pop)
                            pop = operator_stack.pop()
                        was_symbol = True
                    else:
                        # operation goes right on the stack
                        operator_stack.append(operation)
                        was_symbol = False

                    expression = re.sub("\A[+*\/\(\)]|\A[A-z]+", "", expression)

        while operator_stack:
            output.append(operator_stack.pop())
        output_string = " ".join(output)
        print(output_string)
        result = rpn.solve(output_string)
        print(" = " + " ".join([str(i) for i in result]))
