#ifndef ARRAY_H
#define ARRAY_H

template<class T>
class Array {
public:
    int length;
    T* data;
    Array(T* t, int len) {
        data = t;
        length = len;
    };

    T& at(int index) const {
        return data[index];
    };

    T& operator[](int index) const {
        return data[index];
    };


};

// template<>
// class Array<char*> {
// public:
//     int length;
//     const char** data;
//     Array(const char** t, int len){
//         data = t;
//         length = len;
//     };

//     char*& operator[](int index) {
//         return data[index];
//     };
// };

#endif
