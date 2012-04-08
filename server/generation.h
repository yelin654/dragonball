#ifndef GENERATION_H
#define GENERATION_H

#include <map>
using namespace std;

#include "stlite.h"

#define GEN_TYPE_0
#define GEN_TYPE_1 , class T1
#define GEN_TYPE_2 GEN_TYPE_1, class T2
#define GEN_TYPE_3 GEN_TYPE_2, class T3
#define GEN_TYPE_4 GEN_TYPE_3, class T4
#define GEN_TYPE_5 GEN_TYPE_4, class T5
#define GEN_TYPE_6 GEN_TYPE_5, class T6
#define GEN_TYPE_7 GEN_TYPE_6, class T7
#define GEN_TYPE_8 GEN_TYPE_7, class T8
#define GEN_TYPE(n) GEN_TYPE_##n

#define GEN_PARAM_0
#define GEN_PARAM_1 params.at<T1>(0)
#define GEN_PARAM_2 GEN_PARAM_1, params.at<T2>(1)
#define GEN_PARAM_3 GEN_PARAM_2, params.at<T3>(2)
#define GEN_PARAM_4 GEN_PARAM_3, params.at<T3>(3)
#define GEN_PARAM_5 GEN_PARAM_4, params.at<T3>(4)
#define GEN_PARAM_6 GEN_PARAM_5, params.at<T3>(5)
#define GEN_PARAM_7 GEN_PARAM_6, params.at<T3>(6)
#define GEN_PARAM_8 GEN_PARAM_7, params.at<T3>(7)
#define GEN_PARAM(n) GEN_PARAM_##n

#define ARGS_LEN_MAX 8


#endif
