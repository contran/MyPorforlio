//
//  main.cpp
//  sumfunc
//
//  Created by Cong Tran on 2017-08-16.
//  Copyright © 2017 minhtran. All rights reserved.
//

#include <iostream>

long long calfunc(long n);
long long moveCount = 0;
void move(int n);
int depth = 0;

typedef struct node {
    int val;
    struct node *left;
    struct node *right;
} node;
void sameDepthList(node *binNode);
node *listSameDepth;

int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    long long val = calfunc(8181);
    //move(610);
    //std::cout << moveCount;
    std::cout << val;
    listSameDepth = new node();
    listSameDepth->val = depth;
    listSameDepth->left = NULL;
    listSameDepth->right = NULL;
    
    node *rootNode;
    // get rootNode value from given binary tree
    // sameDepthList(rootNode);
    // the new binary tree with rootNode listSameDepth
    // is the output of same depth list with right link shows
    // all the nodes with the same depth and left link show the depth value.
    return 0;
}

long long calfunc(long n) {
    if (n == 1 || n == 2)
        return 1;
    else if (n > 2) {
        //std::cout << n << " ";
        return calfunc(n-1)+calfunc(n-2);
    } else
        return 0;
}

long countSwitchOrder(int level)
{
    if (level == 1) // 1 possible move
        return 1;
    if (level == 2) // 2 possible moves
        return 2;
    if (level == 3) // 3! possible moves
        return 6;
    if (level == 4) // 4! possible moves
        return 24;
    if (level == 5) //5! possible moves
        return 128;
    if (level == 6) // 6! possible moves
        return 768;
    return 0;
}

void move(int n)
{
    for (int i=0;i<n/6+1;i++) {
        if (6*i == n) {
            moveCount += countSwitchOrder(1);
            continue;
        }
        for (int j=0;j<n/5+1;j++) {
            if (6*i+5*j == n) {
                if (i == 0)
                    moveCount += countSwitchOrder(1);
                else
                    moveCount += countSwitchOrder(2);
                continue;
            }
            for (int h=0;h<n/4+1;h++) {
                if (6*i+5*j+4*h == n) {
                    if (i==0 && j==0)
                        moveCount += countSwitchOrder(1);
                    else if (i==0 || j==0)
                        moveCount += countSwitchOrder(2);
                    else
                        moveCount += countSwitchOrder(3);
                    continue;
                }
                for (int k=0;k<n/3+1;k++) {
                    if (6*i+5*j+4*h+3*k == n) {
                        if (i==0 && j==0 && k==0)
                            moveCount += countSwitchOrder(1);
                        else if ((i==0 && j==0) || (i==0 &&h==0) || (j==0&&h==0))
                            moveCount += countSwitchOrder(2);
                        else if (i==0 || j==0 || h==0)
                            moveCount += countSwitchOrder(3);
                        else
                            moveCount += countSwitchOrder(4);
                        continue;
                    }
                    for (int l=0;l<n/2+1;l++) {
                        if (6*i+5*j+4*h+3*k+2*l == n) {
                            if (i==0 && j==0 && k==0 && h==0)
                                moveCount += countSwitchOrder(1);
                            else if ((i==0 && j==0 &&h==0) || (i==0 &&h==0&&k==0) || (j==0&&h==0&&k==0) || (i==0&&j==0&&k==0))
                                moveCount += countSwitchOrder(2);
                            else if ((i==0 && j==0) || (i==0 &&h==0) || (j==0&&h==0) || (i==0&&k==0) || (j==0&&k==0) || (h==0&&k==0))
                                     moveCount += countSwitchOrder(3);
                                     else if (i==0 || j==0 || h==0 || k==0)
                                     moveCount += countSwitchOrder(4);
                                     else
                                     moveCount += countSwitchOrder(5);
                                     continue;
                                     }
                                     for (int m=0;m<n+1;m++) {
                                         if (6*i+5*j+4*h+3*k+2*l+m == n) {
                                             if (i==0 && j==0 && k==0 && h==0 && k==0 && l==0)
                                                 moveCount += countSwitchOrder(1);
                                             else if ((i==0 && j==0 &&h==0&&k==0) || (i==0 &&h==0&&k==0&&l==0) || (j==0&&h==0&&k==0&&l==0) || (i==0&&j==0&&k==0&&l==0) || (i==0&&j==0&&h==0&&l==0))
                                                 moveCount += countSwitchOrder(2);
                                             else if ((i==0 && j==0 &&h==0) || (i==0 &&h==0&&k==0) || (j==0&&h==0&&k==0) || (i==0&&j==0&&k==0) || (i==0&&j==0&&l==0) ||
                                                      (j==0&&h==0&&l==0) || (i==0&&h==0&&l==0) || (i==0&&h==0&&l==0) || (j==0&&k==0&&l==0) ||
                                                                             (h==0&&k==0&&l==0))
                                                      moveCount += countSwitchOrder(3);
                                                      else if ((i==0 && j==0) || (i==0 &&h==0) || (j==0&&h==0) || (i==0&&k==0) || (j==0&&k==0) || (h==0&&k==0) || (i==0&&l==0) || (j==0&&l==0) || (h==0&&l==0) || (k==0&&l==0))
                                                               moveCount += countSwitchOrder(4);
                                                               else if (i==0 || j==0 || h==0 || k==0 || l==0)
                                                               moveCount += countSwitchOrder(5);
                                                               else
                                                               moveCount += countSwitchOrder(6);
                                                               continue;
                                                               }
                                                               }
                                                               }
                                                               }
                                                               }
                                                               }
                                                               }
                                                               }






void sameDepthList(node *binNode) {
    if (binNode->left) {
        node *tmpNode = listSameDepth;
        while (tmpNode->left) {
            tmpNode = tmpNode->left;
        }
        while (tmpNode->right) {
            tmpNode = tmpNode->right;
        }
        node *newNode = new node();
        newNode->val = binNode->left->val;
        newNode->left = NULL;
        newNode->right = NULL;
        tmpNode->right = newNode;
    }
    if (binNode->right) {
        node *tmpNode = listSameDepth;
        while (tmpNode->left) {
            tmpNode = tmpNode->left;
        }
        while (tmpNode->right) {
            tmpNode = tmpNode->right;
        }
        node *newNode = new node();
        newNode->val = binNode->right->val;
        newNode->left = NULL;
        newNode->right = NULL;
        tmpNode->right = newNode;
    }
    depth++;
    node *newNode = new node();
    newNode->val = depth;
    newNode->left = NULL;
    newNode->right = NULL;
    node *tmpNode = listSameDepth;
    while (tmpNode->left) {
        tmpNode = tmpNode->left;
    }
    tmpNode->left = newNode;
    sameDepthList(binNode->left);
    sameDepthList(binNode->right);
}
