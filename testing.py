# -*- coding: utf-8 -*-
if __name__ == "__main__":
    array = ['a','b','c','d','e','f','g','h','i']

    array2 = []
    array3 = []
    nums = "  ".join(array)
    print nums

    array2.append(nums)
    array2.append(nums)   
    array2.append(nums)
    
    print array2
    
    array3.append(array2)    
    array3.append(array2)   
    array3.append(array2)

    for array in array3:
        print array
