//
//  BTree.h
//  prctice-C
//
//  Created by li yajun on 15/11/16.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#ifndef __prctice_C__BTree__
#define __prctice_C__BTree__

#include <stdio.h>
typedef unsigned int  value;

typedef struct __BNode
{
    value  val;
    struct __BNode * left_ptr;
    struct __BNode * right_ptr;
}BNode;

BNode * create_BTree(void * ptr);

#endif /* defined(__prctice_C__BTree__) */
