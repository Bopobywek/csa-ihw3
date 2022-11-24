#!/usr/bin/python3
import sys
from math import log

args = sys.argv[1:]
precision = 0.001

answer = float(input())
x = float(args[0])

if (abs(answer - log(1 - x)) < precision):
    print("OK")
else:
    print(f"WRONG: answer is {answer}")

