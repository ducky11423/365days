import math


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
                self.stack.append(float(i))

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

rpn = RPN()

while True:
    inp = input()
    out = rpn.solve(inp)
    print(" = " + " ".join([str(i) for i in out]))
