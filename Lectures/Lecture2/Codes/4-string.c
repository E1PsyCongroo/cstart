#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* 字符串以'\0'结尾 */

int main(void) {
  char str1[] = "I Can Eat Glass";
  char str2[20] = "I Can Eat Glass";

  printf("str1:%s\nsize:%lu\nstr2:%s\nsize:%lu\n", str1, strlen(str1), str2,
         strlen(str2));
  return EXIT_SUCCESS;
}
