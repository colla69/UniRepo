# -*- coding: utf-8 -*-
"""
Created on Tue May 22 13:08:11 2018

@author: richter
"""

import random
import numpy as np
import matplotlib.pyplot as plt
from timeit import Timer

X = 10000000
n = 10000
#A = [ i for i in random.sample(range(X), n) ]
#A = [9,3,5,7,1,4,8]

def RandomSwap(a, m):
    n = len(a)
    if n > 0:
        for i in range(0,m):
            x = random.randint(0,n-1)
            y = random.randint(0,n-1)
            swap(a,x,y)

def swap(a, i, j):
    temp = a[i]
    a[i] = a[j]
    a[j] = temp

def bubbleSort(a):
    n = len(a)
    for i in range(n):
        for j in range(n-i-1):
            if a[j]>a[j+1]:
                swap(a,j,j+1)
                
def selectionSort(a):
    n = len(a)
    for i in range(n):
        min = i;
        for j in range(i+1,n,1):
            if a[j] < a[min]:
                min = j
        swap(a,i,min)    
    
def insertionSort(a):
    n = len(a)
    for i in range(n):
        key = a[i]
        j = i
        while j > 0 and a[j-1] > key:
            a[j] = a[j-1]
            j = j-1
        a[j] = key    
    
def mergeSort(a):
    if len(a)>1:
        mid = len(a)//2
        lefthalf = a[:mid]
        righthalf = a[mid:]
    
        mergeSort(lefthalf)
        mergeSort(righthalf)
    
        i=0
        j=0
        k=0
        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                a[k]=lefthalf[i]
                i=i+1
            else:
                a[k]=righthalf[j]
                j=j+1
            k=k+1
    
        while i < len(lefthalf):
            a[k]=lefthalf[i]
            i=i+1
            k=k+1
    
        while j < len(righthalf):
            a[k]=righthalf[j]
            j=j+1
            k=k+1

 
def quickSort1(a):
    if len(a) > 1:
        pivotPos = 0
        pivot = a[pivotPos]
        
        rest = a[1:]
        left, right = [],[]
        for i in range(len(rest)):
            if rest[i] <= pivot:
                left.append(rest[i])
            else:
                right.append(rest[i])

        quickSort1(left)
        quickSort1(right)

        temp = left+[pivot]+right
        for i in range(len(a)):
            a[i] = temp[i]
            
def quickSortRandom(a):
    if len(a) > 1:
        pivotPos = random.randint(0,len(a)-1)
        pivot = a[pivotPos]
        rest = a[:pivotPos-1]+a[pivotPos:]
        left, right = [],[]
        for i in range(len(rest)):
            if rest[i] <= pivot:
                left.append(rest[i])
            else:
                right.append(rest[i])

        quickSort1(left)
        quickSort1(right)

        temp = left+[pivot]+right
        for i in range(len(a)):
            a[i] = temp[i]
            
            
def quickSortMedian3(a):
    if len(a) > 1:
        cand1 = 1
        cand2 = len(a)//2
        cand3 = len(a)-1
        if a[cand1] > a[cand2]:
            if a[cand1] < a[cand3]:
                pivotPos = cand1
            elif a[cand2] > a[cand3]:
                pivotPos = cand2
            else:
                pivotPos = cand3
        else:
            if a[cand1] > a[cand3]:
                pivotPos = cand1
            elif a[cand2] < a[cand3]:
                pivotPos = cand2
            else:
                pivotPos = cand3

        
        pivot = a[pivotPos]
        rest = a[:pivotPos-1]+a[pivotPos:]
        left, right = [],[]
        for i in range(len(rest)):
            if rest[i] <= pivot:
                left.append(rest[i])
            else:
                right.append(rest[i])

        quickSort1(left)
        quickSort1(right)

        temp = left+[pivot]+right
        for i in range(len(a)):
            a[i] = temp[i]
            
            
def heapify(a, n, i):
    largest = i  # Initialize largest as root
    l = 2 * i + 1     # left = 2*i + 1
    r = 2 * i + 2     # right = 2*i + 2
 
    # See if left child of root exists and is
    # greater than root
    if l < n and a[i] < a[l]:
        largest = l
 
    # See if right child of root exists and is
    # greater than root
    if r < n and a[largest] < a[r]:
        largest = r
 
    # Change root, if needed
    if largest != i:
        a[i],a[largest] = a[largest],a[i]  # swap
 
        # Heapify the root.
        heapify(a, n, largest)       

def heapSort(a):
    n = len(a)
 
    # Build a maxheap.
    for i in range(n, -1, -1):
        heapify(a, n, i)
 
    # One by one extract elements
    for i in range(n-1, 0, -1):
        a[i], a[0] = a[0], a[i]   # swap
        heapify(a, i, 0)
    
    
    
def eval(alg,n):
    #A = [i for i in random.sample(range(X), n)]
    A = list(range(n))
    RandomSwap(A, 5)
    alg(A)
    

t = np.arange(0, 1000, 100)
m = 5000

#bubble = [Timer(lambda: eval(bubbleSort,x)).timeit(number=m)/m for x in t]
#plt.plot(t, bubble, 'r--')
#
#selection = [Timer(lambda: eval(selectionSort,x)).timeit(number=m)/m for x in t]
#plt.plot(t, selection, 'g--')
#
#insertion = [Timer(lambda: eval(insertionSort,x)).timeit(number=m)/m for x in t]
#plt.plot(t, insertion, 'b--')

merge = [Timer(lambda: eval(mergeSort,x)).timeit(number=m)/m for x in t]
plt.plot(t, merge, 'r+-')

quick = [Timer(lambda: eval(quickSort1,x)).timeit(number=m)/m for x in t]
plt.plot(t, quick, 'g+-')

heap = [Timer(lambda: eval(heapSort,x)).timeit(number=m)/m for x in t]
plt.plot(t, heap, 'b+-')


#quick = [Timer(lambda: eval(quickSort1,x)).timeit(number=m)/m for x in t]
#plt.plot(t, quick, 'g+-')
#
#quick = [Timer(lambda: eval(quickSortRandom,x)).timeit(number=m)/m for x in t]
#plt.plot(t, quick, 'b+-')
#
#quick = [Timer(lambda: eval(quickSortMedian3,x)).timeit(number=m)/m for x in t]
#plt.plot(t, quick, 'r+-')
#
#tim = [Timer(lambda: eval(sorted,x)).timeit(number=m)/m for x in t]
#plt.plot(t, tim, 'r+-')

plt.show()