#!/bin/python3
import os
import argparse
import subprocess
from math import log

PRECISION = 0.001


def file_path(string):
    if not os.path.exists(string) or not os.path.isfile(string):
        raise argparse.ArgumentTypeError(f"{string} is not a valid path to program")
    return string


def dir_path(string):
    if not os.path.exists(string):
        raise argparse.ArgumentTypeError(f"{string} is not a valid path")
    if os.path.isdir(string):
        return string
    raise argparse.ArgumentTypeError(f"{string} is not a directory")


def validate(path_to_program, path_to_test, verbose, use_files=False):
    with open(path_to_test, mode="r") as fin:
        test_data = fin.read()

    path_to_log = os.path.abspath(os.path.join(os.getcwd(), "test_log"))
    command = [path_to_program, "-i", path_to_test, "-o", path_to_log] if use_files else [
        path_to_program]
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    if not use_files:
        process.stdin.write(test_data.encode())
        process.stdin.close()

    try:
        process.wait(10)
    except subprocess.TimeoutExpired:
        process.kill()
        return 2

    out_data = None
    if use_files:
        fin = open("./test_log", mode="r")
        out_data = fin.readlines()
        fin.close()
    else:
        out_data = [string.decode("utf-8") for string in process.stdout.readlines()]

    program_answer = float(out_data[-1])

    raw_test_data = test_data.split()
    input_number = float(raw_test_data[0])
    answer = log(1 - input_number)

    if verbose:
        print(f"Input number is {input_number}\n"
              f"Program answer is {program_answer}\nCorrect answer is {answer}")
    elif use_files:
        os.remove("./test_log")

    return abs(program_answer - answer) < PRECISION


parser = argparse.ArgumentParser(description='Checker for IHW3')
parser.add_argument("path_to_program", type=file_path)
parser.add_argument("path_to_tests", type=dir_path)
parser.add_argument('-f', '--use-files', dest="use_files", action='store_true')
parser.add_argument('-v', '--verbose', action='store_true')

args = parser.parse_args()

tests = list()

for filename in os.listdir(args.path_to_tests):
    full_filename = os.path.join(args.path_to_tests, filename)
    if "." in filename:
        continue

    if os.path.isfile(full_filename):
        tests.append(full_filename)

total = 0
passed = 0
error = 0
for test_path in tests:
    result = validate(args.path_to_program, test_path, args.verbose, use_files=args.use_files)
    if result == 2:
        error += 1
        print(f"Error | {test_path:^} | Timeout expired")
    elif result:
        passed += 1
        print(f"Info  | {test_path:^} | Passed")
    else:
        error += 1
        print(f"Error | {test_path:^} | Program output and answer are different")

    if args.verbose:
        print()
    total += 1
