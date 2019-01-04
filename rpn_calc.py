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
            match = re.match("(?<![0-9.A-z\)])-?[0-9]*\.?[0-9]*", expression) # Check for numbers
            if(match):
                if(was_symbol or match[0] is "-"):
                    # It's actually a minus operation, not a negative sign
                    operator_stack.append("-")
                    expression = expression[1:]
                else:
                    # It's a number, put it on the output
                    expression = re.sub("(?<![0-9.A-z\)])-?[0-9]*\.?[0-9]*", "", expression)
            else:
                match = re.match("[+*\/\(\)]|[A-z]+", expression)
                if(match):
                    # Operation or function
                    operation = match[0]
                    precedence = operator_precedence[operation]

                    if precedence is not None:
                        stack_precedence = operator_precedence[stack[len(stack)]]
                        if precedence > stack_precedence:
                            operator_stack.append(operation)
                        elif operation in left_assoc and precedence is stack_precedence:
                            pass
                    
                    expression = re.sub("[+*\/\(\)]|[A-z]+", "", expression)
