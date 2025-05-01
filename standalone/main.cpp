/**
 * @file main.cpp
 * @brief Simple program that prints "Hello, world!!" to the standard output.
 *
 * This is a minimal example demonstrating basic output to the console using
 * the C++ standard library.
 *
 * @author Your Name
 * @date 2025-04-28
 */

#include <iostream>

/**
 * @brief Entry point of the program.
 *
 * Prints the message "Hello, world!!" followed by a newline to the standard output.
 *
 * @return Returns 1 to indicate the program ended with a custom status code.
 *
 * @note Returning 1 typically indicates an error or abnormal termination,
 *       but here it is used explicitly as the program's return value.
 *
 * @example
 * @code
 * $ ./hello_world
 * Hello, world!!
 * @endcode
 */
int main() {
  std::cout << "Hello, world!!" << std::endl;
  return 1;
}
