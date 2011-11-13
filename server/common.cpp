#include <stdio.h>
#include <string.h>

void load_file(char*& buf,int& size, const char* filename) {
    FILE* file = fopen(filename, "r");
    fseek(file, SEEK_SET, SEEK_END);
    size = ftell(file);
    buf = new char[size+1];
    fseek(file, 0, SEEK_SET);
    fread(buf, size, 1, file);
    buf[size] = '\0';
    fclose(file);
}

void save_file(char* buf, int size, const char* filename) {
    FILE* file = fopen(filename, "w");
    fwrite(buf, size, 1, file);
    fclose(file);
}
