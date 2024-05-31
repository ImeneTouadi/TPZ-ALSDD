#ifndef DISPLAYTREE_H
#define DISPLAYTREE_H

typedef int bool ;

/* ===================== STRUCTURES ====================== */

/** Implémentation **\: ARBRE BINAIRE DE STRUCTURES**/

  /** Structures statiques **/

  typedef struct Tib Type_Tib  ;
  typedef Type_Tib * Typestr_Tib ;
  typedef int Type1_Tib  ;
  typedef bool Type2_Tib  ;
  struct Tib
    {
      Type1_Tib Champ1 ;
      Type2_Tib Champ2 ;
    };


 /** Arbres de recherche binaire **/

  typedef Typestr_Tib Typeelem_ATib   ;
  typedef struct Noeud_ATib * Pointeur_ATib ;

  struct Noeud_ATib
    {
      Typeelem_ATib  Val ;
      Pointeur_ATib Fg ;
      Pointeur_ATib Fd ;
      Pointeur_ATib Pere ;
     } ;

/** Listes linéaires chaénées **/
  typedef int Typeelem_Li   ;
  typedef struct Maillon_Li * Pointeur_Li ;

  struct Maillon_Li
    {
      Typeelem_Li  Val ;
      Pointeur_Li Suiv ;
    } ;

struct Trunk
{
    struct Trunk *prev;
    char *str;
};

Type1_Tib Struct1_Tib ( Typestr_Tib S);
Typeelem_ATib Info_ATib( Pointeur_ATib P );
Pointeur_ATib Fg_ATib( Pointeur_ATib P);
Pointeur_ATib Fd_ATib( Pointeur_ATib P);

/** ADDED MODULES TO DISPLAY **/

struct Trunk* createTrunk(struct Trunk *prev, const char *str);
void showTrunks(struct Trunk *p);
void printTree(Pointeur_ATib root, struct Trunk *prev, int isLeft);

#endif
