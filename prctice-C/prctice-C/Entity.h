//
//  Entity.h
//  consoleC
//
//  Created by niko on 15/9/6.
//  Copyright (c) 2015年 andybain. All rights reserved.
//

#ifndef __consoleC__Entity__
#define __consoleC__Entity__
#include <stdbool.h>
#include <stdio.h>
#include "EntityType.h"
#define Max   3
#define Left  0
#define Right 1

typedef struct EntityStruct*  EntityRef;

typedef  struct EntityStruct
{
    EntityType   type; //实体类型
    int          end_point_number;//端点数量
    EntityRef    pointInstance[Max];//最多3个实例连接
    
}Entity;
/**
创建一个实例类型
*/
bool createEntity(EntityType type);

#endif /* defined(__consoleC__Entity__) */
