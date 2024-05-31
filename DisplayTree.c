#include <stdio.h>
#include <stdlib.h>
#include <Time.h>
#include <string.h>
#include <unistd.h>
#include <conio.h>
#include "DisplayTree.h"

#define True 1
#define False 0

/** BODY OF DISPLAY MODULES ADDED **/

// Function to create a new trunk
struct Trunk* createTrunk(struct Trunk *prev, const char *str)
{
    struct Trunk* trunk = (struct Trunk*)malloc(sizeof(struct Trunk));
    trunk->prev = prev;
    trunk->str = (char*)malloc(strlen(str) + 1);
    strcpy(trunk->str, str);
    return trunk;
}

// Helper function to print branches of the binary tree
void showTrunks(struct Trunk *p)
{
    if (p == NULL) {
        return;
    }

    showTrunks(p->prev);
    printf("%s", p->str);
}

void printTree(Pointeur_ATib root, struct Trunk *prev, int isLeft)
{
    if (root == NULL) {
        return;
    }

    const char* prev_str = "    ";
    struct Trunk *trunk = createTrunk(prev, prev_str);

    printTree(Fd_ATib(root), trunk, 1);

    if (!prev) {
        trunk->str = "---";
    }
    else if (isLeft)
    {
        trunk->str = ".---";
        prev_str = "   |";
    }
    else {
        trunk->str = "`---";
        prev->str = (char*)prev_str;
    }

    showTrunks(trunk);
    printf(" %d\n", Struct1_Tib ( Info_ATib ( root )  ));

    if (prev) {
        prev->str = (char*)prev_str;
    }
    trunk->str = "   |";

    printTree(Fg_ATib(root), trunk, 0);
}
