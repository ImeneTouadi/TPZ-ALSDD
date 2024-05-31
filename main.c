  /**--------------------------------------------------------**/
  /**       C o n v e r s i o n   Z vers C (Standard)        **/
  /**             Réalisée par Pr D.E ZEGOUR                 **/
  /**             E S I - Alger                              **/
  /**             Copywrite 2014                             **/
  /**--------------------------------------------------------**/

    // ============ TP2 ALSDD ============= //
   //        Traversals of a BST           //
  //   =========  2023 / 2024  ========   //
 //   SEGHOUANI Sirine & TOUADI Imene    //
// =============== G05 ================ // 

   
  /*=========================== VARIABLES =================================*/


  #include <stdio.h>
  #include <stdlib.h>
  #include <Time.h>
  #include <string.h>
  #include <unistd.h> // for sleep()
  #include <conio.h> // for getch()
  #include "DisplayTree.h"

  #define True 1
  #define False 0


  Type1_Tib Struct1_Tib ( Typestr_Tib S)
    {
      return  S->Champ1 ;
    }

  Type2_Tib Struct2_Tib ( Typestr_Tib S)
    {
      return  S->Champ2 ;
    }

  void Aff_struct1_Tib ( Typestr_Tib S, Type1_Tib Val )
    {
       S->Champ1 = Val ;
    }

  void Aff_struct2_Tib ( Typestr_Tib S, Type2_Tib Val )
    {
       S->Champ2 = Val ;
    }


  /** Arbres de recherche binaire **/

  Typeelem_ATib Info_ATib( Pointeur_ATib P )
    { return P->Val;   }

  Pointeur_ATib Fg_ATib( Pointeur_ATib P)
    { return P->Fg ; }

  Pointeur_ATib Fd_ATib( Pointeur_ATib P)
    { return P->Fd ; }

  Pointeur_ATib Pere_ATib( Pointeur_ATib P)
    { return P->Pere ; }

  void Aff_info_ATib ( Pointeur_ATib P, Typeelem_ATib Val)
    {
      Typeelem_ATib _Temp ;
      _Temp = malloc(sizeof(Type_Tib));
      /* Affectation globale de structure */
      _Temp->Champ1 = Val->Champ1;
      _Temp->Champ2 = Val->Champ2;
      Val = _Temp ;
       P->Val = Val ;
    }

  void Aff_fg_ATib( Pointeur_ATib P, Pointeur_ATib Q)
    { P->Fg =  Q;  }

  void Aff_fd_ATib( Pointeur_ATib P, Pointeur_ATib Q)
    { P->Fd =  Q ; }

  void Aff_pere_ATib( Pointeur_ATib P, Pointeur_ATib Q)
    { P->Pere =  Q ; }

  void Creernoeud_ATib( Pointeur_ATib *P)
    {
      *P = (struct Noeud_ATib *) malloc( sizeof( struct Noeud_ATib))   ;
      (*P)->Val = malloc(sizeof(Type_Tib));
      (*P)->Fg = NULL;
      (*P)->Fd = NULL;
      (*P)->Pere = NULL;
    }

  void Liberernoeud_ATib( Pointeur_ATib P)
    { free( P ) ; }


  Pointeur_Li Allouer_Li (Pointeur_Li *P)
    {
      *P = (struct Maillon_Li *) malloc( sizeof( struct Maillon_Li)) ;
      (*P)->Suiv = NULL;
    }

  void Aff_val_Li(Pointeur_Li P, Typeelem_Li Val)
    {
      P->Val = Val ;
    }

  void Aff_adr_Li( Pointeur_Li P,  Pointeur_Li Q)
    {
      P->Suiv = Q ;
    }

  Pointeur_Li Suivant_Li(  Pointeur_Li P)
    { return( P->Suiv ) ;  }

  Typeelem_Li Valeur_Li( Pointeur_Li P)
    { return( P->Val) ; }

  void Liberer_Li ( Pointeur_Li P)
    { free (P);}

  /** Variables du programme principal **/
  Pointeur_ATib Tree=NULL;
  Pointeur_ATib Ctree=NULL;
  Pointeur_Li Head_bblr=NULL;
  Pointeur_Li Head_bbrl=NULL;
  Pointeur_Li Head_lllr=NULL;
  Pointeur_Li Head_llrl=NULL;
  Typestr_Tib S;
  int Val;
  bool B;
  int Numberiterations;
  int M;
  int Choice;
  bool Iterationterminee;
  int _Px1;
  int _Px2;

  /** Fonctions standards **/

  int Aleanombre( int N )
    { return ( rand() % N ); }


  /** Prototypes des fonctions **/

  bool  Isuniquevalue (Pointeur_ATib *T , int *Val) ;
  bool  Isbst (Pointeur_ATib *T , int *Minimum , int *Maximum) ;
  int  Height (Pointeur_ATib *T) ;
  void Insert (Pointeur_ATib *T , int *Val);
  void Create_tree (Pointeur_ATib *T , int *N);
  Pointeur_ATib Clonetree (Pointeur_ATib *Original) ;
  void Arbreexemple (Pointeur_ATib *T);
  void Display (Pointeur_ATib *T);
  void Generatetree (Pointeur_ATib *Tree);
  void Displaylist (Pointeur_Li *Head);
  void Addtolist (Pointeur_Li *Head , int *Val);
  void Eliminateduplicates (Pointeur_Li *Head);
  Pointeur_ATib Mostleft (Pointeur_ATib *T) ;
  void Nextright (Pointeur_ATib *Leaf , Pointeur_ATib *Rightleaf);
  void Traversal_1 (Pointeur_ATib *T , Pointeur_Li *Head);
  void Normal_bblr (Pointeur_ATib *T , Pointeur_Li *Head);
  bool  Checktraversal_1 (Pointeur_ATib *Tree , Pointeur_Li *Head_bblr) ;
  Pointeur_ATib Mostright (Pointeur_ATib *T) ;
  void Nextleft (Pointeur_ATib *Leaf , Pointeur_ATib *Leftleaf);
  void Traversal_3 (Pointeur_ATib *T , Pointeur_Li *Head);
  void Normal_bbrl (Pointeur_ATib *T , Pointeur_Li *Head);
  bool  Checktraversal_3 (Pointeur_ATib *Tree , Pointeur_Li *Head_bbrl) ;
  void Ll_lr (Pointeur_ATib *T , Pointeur_Li *Headlist);
  void Traversal_2 (Pointeur_ATib *T , Pointeur_Li *Headlist);
  bool  Checktraversal_2 (Pointeur_ATib *T , Pointeur_Li *Headlist) ;
  void Ll_rl (Pointeur_ATib *T , Pointeur_Li *Headlist);
  void Traversal_4 (Pointeur_ATib *T , Pointeur_Li *Headlist);
  bool  Checktraversal_4 (Pointeur_ATib *T , Pointeur_Li *Headlist) ;
  void Traversals (Pointeur_ATib *T);

  /*=================== IMPLEMENTATION DES MODULES ======================*/
  /* Checks the unicity of a given val, Returns false if it already exists in the tree */
  bool  Isuniquevalue (Pointeur_ATib *T , int *Val) 
    {
      /** Variables locales **/
      bool  Isuniquevalue2 ;
      Pointeur_ATib _Px1=NULL;
      Pointeur_ATib _Px2=NULL;

      /** Corps du module **/
     if( *T == NULL)   {
       Isuniquevalue2  =  True ;
       }
     else
       {
       if( *Val == Struct1_Tib ( Info_ATib ( *T )  ))   {
         Isuniquevalue2  =  False ;
         }
       else
         {
         if( *Val < Struct1_Tib ( Info_ATib ( *T )  ))   {
           _Px1 =  Fg_ATib ( *T ) ;
           Isuniquevalue2  =  Isuniquevalue ( &_Px1, & *Val ) ;
           }
         else
           {
           _Px2 =  Fd_ATib ( *T ) ;
           Isuniquevalue2  =  Isuniquevalue ( &_Px2, & *Val ) ;
          
         } ;
        
       } ;
      
     } ;
    
     return Isuniquevalue2 ;
    }
  /* Checks wether the tree satisfies the proprieties of the BST */
  bool  Isbst (Pointeur_ATib *T , int *Minimum , int *Maximum) 
    {
      /** Variables locales **/
      bool  Isbst2 ;
      int Val;
      bool Valid;
      Pointeur_ATib _Px1=NULL;
      Pointeur_ATib _Px2=NULL;

      /** Corps du module **/
     if( *T == NULL) {
       Isbst2  =  True ;
       }
     else
       {
       Val  =  Struct1_Tib ( Info_ATib ( *T )  ) ;
       if( ( Val <= *Minimum ) || ( Val >= *Maximum ))   {
         Isbst2  =  False ;
         }
       else
         {
         _Px1 =  Fg_ATib ( *T ) ;
         _Px2 =  Fd_ATib ( *T ) ;
         Valid  =  Isbst ( &_Px1, & *Minimum , & Val ) && Isbst ( &_Px2, & Val , & *Maximum ) ;
         Isbst2  =  Valid ;
        
       } ;
      
     } ;
    
     return Isbst2 ;
    }
  /* Calculates the height of a tree */
  int  Height (Pointeur_ATib *T) 
    {
      /** Variables locales **/
      int  Height2 ;
      int Lh;
      int Rh;
      Pointeur_ATib _Px1=NULL;
      Pointeur_ATib _Px2=NULL;

      /** Corps du module **/
     if( *T == NULL) {
       Height2  =  0 ;
       }
     else
       {
       _Px1 =  Fg_ATib ( *T ) ;
       Lh  =  Height ( &_Px1) ;
       _Px2 =  Fd_ATib ( *T ) ;
       Rh  =  Height ( &_Px2) ;
       if( Lh > Rh) {
         Height2  =  Lh + 1 ;
         }
       else
         {
         Height2  =  Rh + 1 ;
        
       } ;
      
     } ;
    
     return Height2 ;
    }
  /*inserts a node in binary search tree with a given value, initialized at false (not visited)*/
  /*doesn't treat case of value exists cause it will be treated when creating the tree and generating the values*/
  void Insert (Pointeur_ATib *T , int *Val)
    {
      /** Variables locales **/
      Pointeur_ATib R=NULL;
      Typestr_Tib S;

      /** Corps du module **/
     S = malloc(sizeof(Type_Tib));
     Aff_struct1_Tib ( S  , *Val ) ;
     Aff_struct2_Tib ( S  , False ) ;
     if( *T == NULL) {
       Creernoeud_ATib (& *T ) ;
       Aff_info_ATib ( *T , S ) ;
       Aff_fg_ATib ( *T , NULL ) ;
       Aff_fd_ATib ( *T , NULL ) ;
       R  =  *T ;
       }
     else
       {
       if( *Val < Struct1_Tib ( Info_ATib ( *T )  )) {
         R  =  Fg_ATib ( *T ) ;
         Insert ( & R , & *Val ) ;
         Aff_fg_ATib ( *T , R ) ;
         }
       else
         {
         R  =  Fd_ATib ( *T ) ;
         Insert ( & R , & *Val ) ;
         Aff_fd_ATib ( *T , R ) ;
        
       } ;
       Aff_pere_ATib ( R , *T ) ;
      
     } ;
    
    }
  /* Generates a tree with 100 random data initialized at false */
  /* All n values are checked to be unique */
  void Create_tree (Pointeur_ATib *T , int *N)
    {
      /** Variables locales **/
      int I;
      int Value;
      bool Check;

      /** Corps du module **/
     for( I  =  1 ;I <=  *N ; ++I){
       Value  =  Aleanombre(1000 ) ;
       Check  =  Isuniquevalue ( & *T , & Value ) ;
      /*if it indicates that the value exists in the tree, it will generate other until it's unique */
       while( Check == False) {
         Value  =  Aleanombre(1000 ) ;
         Check  =  Isuniquevalue ( & *T , & Value ) ;
        
       } ;
       Insert ( & *T , & Value ) ;
      
     } ;
    
    }
  Pointeur_ATib Clonetree (Pointeur_ATib *Original) 
    {
      /** Variables locales **/
      Pointeur_ATib Clonetree2 =NULL;
      Pointeur_ATib Clone=NULL;
      Pointeur_ATib _Px1=NULL;
      Pointeur_ATib _Px2=NULL;

      /** Corps du module **/
     if( *Original == NULL) {
       Clone  =  NULL;
     } ;
     Creernoeud_ATib (& Clone ) ;
     Aff_info_ATib ( Clone , Info_ATib ( *Original ) ) ;
     if( Fg_ATib ( *Original ) != NULL) {
       _Px1 =  Fg_ATib ( *Original ) ;
       Aff_fg_ATib ( Clone , Clonetree ( &_Px1) ) ;
      
     } ;
     if( Fd_ATib ( *Original ) != NULL) {
       _Px2 =  Fd_ATib ( *Original ) ;
       Aff_fd_ATib ( Clone , Clonetree ( &_Px2) ) ;
      
     } ;
     if( Fg_ATib ( Clone ) != NULL) {
       Aff_pere_ATib ( Fg_ATib ( Clone ) , Clone ) ;
      
     } ;
     if( Fd_ATib ( Clone ) != NULL) {
       Aff_pere_ATib ( Fd_ATib ( Clone ) , Clone ) ;
      
     } ;
     Clonetree2  =  Clone ;
    
     return Clonetree2 ;
    }
  /* Just an exemple of a tree to test the functions */
  void Arbreexemple (Pointeur_ATib *T)
    {
      /** Variables locales **/
      Pointeur_ATib R=NULL;
      Pointeur_ATib R2=NULL;
      Typestr_Tib S;
      int _Px1;
      int _Px2;
      int _Px3;
      int _Px4;
      int _Px5;
      int _Px6;
      int _Px7;
      int _Px8;
      int _Px9;
      int _Px10;
      int _Px11;
      int _Px12;
      int _Px13;
      int _Px14;
      int _Px15;
      int _Px16;
      int _Px17;
      int _Px18;

      /** Corps du module **/
     S = malloc(sizeof(Type_Tib));
     _Px1 =  45 ;
     Insert ( & *T , &_Px1) ;
     _Px2 =  20 ;
     Insert ( & *T , &_Px2) ;
     _Px3 =  10 ;
     Insert ( & *T , &_Px3) ;
     _Px4 =  35 ;
     Insert ( & *T , &_Px4) ;
     _Px5 =  65 ;
     Insert ( & *T , &_Px5) ;
     _Px6 =  55 ;
     Insert ( & *T , &_Px6) ;
     _Px7 =  50 ;
     Insert ( & *T , &_Px7) ;
     _Px8 =  58 ;
     Insert ( & *T , &_Px8) ;
     _Px9 =  56 ;
     Insert ( & *T , &_Px9) ;
     _Px10 =  57 ;
     Insert ( & *T , &_Px10) ;
     _Px11 =  60 ;
     Insert ( & *T , &_Px11) ;
     _Px12 =  62 ;
     Insert ( & *T , &_Px12) ;
     _Px13 =  85 ;
     Insert ( & *T , &_Px13) ;
     _Px14 =  75 ;
     Insert ( & *T , &_Px14) ;
     _Px15 =  95 ;
     Insert ( & *T , &_Px15) ;
     _Px16 =  90 ;
     Insert ( & *T , &_Px16) ;
     _Px17 =  98 ;
     Insert ( & *T , &_Px17) ;
     _Px18 =  88 ;
     Insert ( & *T , &_Px18) ;
    
    }
  /* Displays a tree inorder (did it just for check) */
  void Display (Pointeur_ATib *T)
    {
      /** Variables locales **/
      Pointeur_ATib _Px1=NULL;
      Type_Tib _Struct_Temp1;
      Pointeur_ATib _Px2=NULL;

      /** Corps du module **/
     if( *T != NULL) {
       _Px1 =  Fg_ATib ( *T ) ;
       Display ( &_Px1) ;
       /** Ecriture d'une structure */
       _Struct_Temp1 = *Info_ATib(*T);
       printf ( " %d", _Struct_Temp1.Champ1 );
       printf ( " %d", _Struct_Temp1.Champ2 );
       printf ( " %s", "  " ) ;
       _Px2 =  Fd_ATib ( *T ) ;
       Display ( &_Px2) ;
      
     } ;
    
    }
  void Generatetree (Pointeur_ATib *Tree)
    {
      /** Variables locales **/
      int Choicecreatetree;
      int N;

      *Tree  =  NULL ;

      int key;
      int SelecterTree = 0;
      const char *tree[] = {"1. Generate a defined tree ( the tree exemple in the tp )", "2. Generate a random tree"};
      int numTree = sizeof(tree) / sizeof(tree[0]);

      /** Corps du module **/
    bool treeMenuRunning = 1;
    while (treeMenuRunning) {
        system("cls");
        printf ("\n\t   *** Generating a binary search tree ***\n");
        printf(" \n\tDo you want to: \n");
        for (int i = 0; i < numTree; i++) {  // Fixing the loop condition
            if (i == SelecterTree) {
                printf("\t> %s <\n", tree[i]);
            } else {
                printf("\t%s\n", tree[i]);
            }
            }
     printf ( " %s", " " ) ;
     printf ("\n");
     key = getch();
     switch (key) {
      case 72:
        SelecterTree = (SelecterTree - 1 + numTree) % numTree;
        break;
      case 80:
        SelecterTree = (SelecterTree + 1) % numTree;
        break;
      case 13:
        switch (SelecterTree) {
          case 0:
            Arbreexemple ( & *Tree ) ;
            break;
          case 1:
            printf ( " %s", " Enter the number of random data (you can take n=100) : " ) ;
            printf ( " %s", " " ) ;
            scanf ( " %d", &N ) ;
            Create_tree ( & *Tree , & N ) ;
            printf ( "\n" ) ;
            break;
        }
        //getch();
        treeMenuRunning = 0;
        break;
    
     }
    }
    }

  /*Displays the values of a list */
  void Displaylist (Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_Li Current=NULL;
      int choice;
      /** Corps du module **/
     printf("\t Do you want to : \n");
     printf("\t 1. Display the traversal at once. \n");
     printf("\t 2. Animate it one by one (this may take some time for 100 data) \n\n");
     while( ( choice > 2 ) || ( choice < 1 )) {
        printf ("   Enter your choice (1/2) : ");
        scanf ( " %d", &choice ) ;
      } ;

     switch (choice)
     {
     case 1:
        Current  =  *Head ;
        printf("\n");
        while( Current != NULL) {
        printf ( " %d", Valeur_Li(Current) ) ;
        Current  =  Suivant_Li ( Current ) ;
        };
        printf ("\n\n\t Press any key to continue.. ");
        getch();
        break;
    
     case 2:
        Current  =  *Head ;
        printf("\n");
        while( Current != NULL) {
        printf ( " %d", Valeur_Li(Current) ) ;
        fflush(stdout); // Ensure the data is printed immediately
        sleep(1); // Pause for a second to simulate animation
        Current  =  Suivant_Li ( Current ) ;
        };
        printf ("\n\n\t Press any key to continue.. ");
        getch();
        break;

     }
    }

  /*Insertion at the end of the list*/
  void Addtolist (Pointeur_Li *Head , int *Val)
    {
      /** Variables locales **/
      Pointeur_Li Cell=NULL;
      Pointeur_Li Current=NULL;

      /** Corps du module **/
     Allouer_Li (& Cell ) ;
     Aff_val_Li ( Cell , *Val ) ;
     Aff_adr_Li ( Cell , NULL ) ;
     if( *Head == NULL) {
       *Head  =  Cell ;
       }
     else
       {
       Current  =  *Head ;
       while( Suivant_Li ( Current ) != NULL) {
         Current  =  Suivant_Li ( Current ) ;
        
       } ;
       Aff_adr_Li ( Current , Cell ) ;
      
     } ;
    
    }
  /*Eliminates duplicated values in a list*/
  void Eliminateduplicates (Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_Li Current=NULL;
      Pointeur_Li Comparer=NULL;
      Pointeur_Li Previous=NULL;

      /** Corps du module **/
     Current  =  *Head ;
     while( Current != NULL) {
       Previous  =  Current ;
       Comparer  =  Suivant_Li ( Current ) ;
       while( Comparer != NULL) {
         if( Valeur_Li ( Comparer ) == Valeur_Li ( Current )) {
           Aff_adr_Li ( Previous , Suivant_Li ( Comparer ) ) ;
           Liberer_Li ( Comparer ) ;
           Comparer  =  Suivant_Li ( Previous ) ;
           }
         else
           {
           Previous  =  Comparer ;
           Comparer  =  Suivant_Li ( Comparer ) ;
          
         } ;
        
       } ;
       Current  =  Suivant_Li ( Current ) ;
      
     } ;
    
    }
  /* ============= TRAVERSAL 1 : BB_LR ============= */
  /* Gives the most left leaf of a given tree ( or sub-tree ) */
  Pointeur_ATib Mostleft (Pointeur_ATib *T) 
    {
      /** Variables locales **/
      Pointeur_ATib Mostleft2 =NULL;
      Pointeur_ATib P=NULL;
      bool Stop;

      /** Corps du module **/
     P  =  *T ;
     Stop  =  False ;
     while( ! Stop) {
      /*Descend left until the first Nil LC*/
       while( Fg_ATib ( P ) != NULL) {
         P  =  Fg_ATib ( P );
       } ;
      /*If the node has no RC then we're in the most LC*/
       if( Fd_ATib ( P ) == NULL) {
         Stop  =  True; }
       else
         {
        /*Else we go right once and procceed to descend left again*/
         P  =  Fd_ATib ( P );
       }
     } ;
     Mostleft2  =  P;
     return Mostleft2 ;
    }
  /* Gives the next leaf on the right of a given leaf */
  void Nextright (Pointeur_ATib *Leaf , Pointeur_ATib *Rightleaf)
    {
      /** Variables locales **/
      Pointeur_ATib P=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib F=NULL;
      bool Up;
      Pointeur_ATib _Px1=NULL;

      /** Corps du module **/
     Q  =  *Leaf ;
     Up  =  True ;
     P  =  Pere_ATib ( Q ) ;
    /*We're in the leaf and we go up*/
     while( ( P != NULL ) && Up) {
       if( Q == Fd_ATib ( P )) {
         Q  =  P ;
         P  =  Pere_ATib ( Q ); }
       else
         {
        /*if p has a RC then we stop going up*/
         if( Fd_ATib ( P ) != NULL) {
           Up  =  False; }
         else
           {
           Q  =  P ;
           P  =  Pere_ATib ( Q );
         }
       }
     } ;
    /*Once we get to the parent of the wanted next leaf we descend to the most LC to reach it*/
     if( P != NULL) {
       _Px1 =  Fd_ATib ( P ) ;
       F  =  Mostleft ( &_Px1) ;
       }
     else
       {
       F  =  NULL ;
      
     } ;
     *Rightleaf  =  F ;
    
    }
  /*Traverses the tree by BB-LR and returns the values in a list*/
  void Traversal_1 (Pointeur_ATib *T , Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_ATib Clonet=NULL;
      Pointeur_ATib P=NULL;
      Pointeur_ATib F=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib S=NULL;
      bool Up;
      int _Px1;
      int _Px2;

      /** Corps du module **/
     Clonet  =  Clonetree ( & *T ) ;
     P  =  Mostleft ( & Clonet ) ;
    /*We start from the most LC*/
     F  =  P ;
     while( F != NULL) {
       S  =  F ;
      /*S is to save the current leaf so that we can move to exactly the next leaf*/
      /*We ascend while processing the nodes*/
       if( Struct2_Tib ( Info_ATib ( F )  ) == False) {
         Aff_struct2_Tib ( Info_ATib ( F )  , True ) ;
        /*We mark the processed nodes as visited*/
         _Px1 =  Struct1_Tib ( Info_ATib ( F )  ) ;
         Addtolist ( & *Head , &_Px1) ;
        
       } ;
       Q  =  F ;
       P  =  Pere_ATib ( Q ) ;
       Up  =  True ;
       while( ( P != NULL ) && Up) {
        /*While ascending if we found an already visited node we stop*/
         if( Struct2_Tib ( Info_ATib ( P )  )) {
           Up  =  False ;
           }
        /*Else we keep going up*/
         else
           {
           Aff_struct2_Tib ( Info_ATib ( P )  , True ) ;
           _Px2 =  Struct1_Tib ( Info_ATib ( P )  ) ;
           Addtolist ( & *Head , &_Px2) ;
           Q  =  P ;
           P  =  Pere_ATib ( P ) ;
          
         } ;
        
       } ;
      /*once we stop ascending, either we reached the root or a visited node*/
      /*we move on to the next leaf to start again*/
       Nextright ( & S , & F ) ;
      
     } ;
    
    }
  /* Normal branche by branche from left to right traversal (repeated nodes)*/
  /* Returns the head of the constructed list  */
  void Normal_bblr (Pointeur_ATib *T , Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_ATib P=NULL;
      Pointeur_ATib F=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib S=NULL;
      int _Px1;
      int _Px2;

      /** Corps du module **/
     P  =  Mostleft ( & *T ) ;
     F  =  P ;
     while( F != NULL) {
       S  =  F ;
       _Px1 =  Struct1_Tib ( Info_ATib ( F )  ) ;
       Addtolist ( & *Head , &_Px1) ;
       Q  =  F ;
       P  =  Pere_ATib ( Q ) ;
       while( ( P != NULL )) {
         _Px2 =  Struct1_Tib ( Info_ATib ( P )  ) ;
         Addtolist ( & *Head , &_Px2) ;
         Q  =  P ;
         P  =  Pere_ATib ( P ) ;
        
       } ;
       Nextright ( & S , & F ) ;
      
     } ;
    
    }
  bool  Checktraversal_1 (Pointeur_ATib *Tree , Pointeur_Li *Head_bblr) 
    {
      /** Variables locales **/
      bool  Checktraversal_12 ;
      Pointeur_Li Head_check=NULL;

      /** Corps du module **/
     Normal_bblr ( & *Tree , & Head_check ) ;
     Eliminateduplicates ( & Head_check ) ;
     while( ( *Head_bblr != NULL ) && ( Head_check != NULL )) {
       if( Valeur_Li ( *Head_bblr ) != Valeur_Li ( Head_check )) {
         Checktraversal_12  =  False ;
        
       } ;
       *Head_bblr  =  Suivant_Li ( *Head_bblr ) ;
       Head_check  =  Suivant_Li ( Head_check ) ;
      
     } ;
     if( ( *Head_bblr == NULL ) && ( Head_check == NULL )) {
       Checktraversal_12  =  True ;
       }
     else
       {
       Checktraversal_12  =  False ;
      
     } ;
    
     return Checktraversal_12 ;
    }
  /* ============= TRAVERSAL 3 : BB_RL ============= */
  /* Gives the most right leaf of a given tree ( or sub-tree ) */
  Pointeur_ATib Mostright (Pointeur_ATib *T) 
    {
      /** Variables locales **/
      Pointeur_ATib Mostright2 =NULL;
      Pointeur_ATib P=NULL;
      bool Stop;

      /** Corps du module **/
     P  =  *T ;
     Stop  =  False ;
     while( ! Stop) {
      /*Descend right until the first Nil RC*/
       while( Fd_ATib ( P ) != NULL) {
         P  =  Fd_ATib ( P );
       } ;
      /*If the node has no LC then we're in the most RC*/
       if( Fg_ATib ( P ) == NULL) {
         Stop  =  True ;
         }
       else
         {
         P  =  Fg_ATib ( P ) ;
        /*Else we go left once and procceed to descend right again*/
        
       }
     } ;
     Mostright2  =  P ;
    
     return Mostright2 ;
    }
  /* Gives the next leaf on the left of a given leaf */
  void Nextleft (Pointeur_ATib *Leaf , Pointeur_ATib *Leftleaf)
    {
      /** Variables locales **/
      Pointeur_ATib P=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib F=NULL;
      bool Up;
      Pointeur_ATib _Px1=NULL;

      /** Corps du module **/
     Q  =  *Leaf ;
     Up  =  True ;
     P  =  Pere_ATib ( Q ) ;
    /*We're in the leaf and we go up*/
     while( ( P != NULL ) && Up) {
       if( Q == Fg_ATib ( P )) {
         Q  =  P ;
         P  =  Pere_ATib ( Q ) ;
         }
       else
         {
        /*If p has a LC then we stop going up*/
         if( Fg_ATib ( P ) != NULL) {
           Up  =  False ;
           }
         else
           {
           Q  =  P ;
           P  =  Pere_ATib ( Q ) ;
          
         } ;
        
       } ;
      
     } ;
    /*Once we get to the parent of the wanted next leaf we descend to the most RC to reach it*/
     if( P != NULL) {
       _Px1 =  Fg_ATib ( P ) ;
       F  =  Mostright ( &_Px1) ;
       }
     else
       {
       F  =  NULL ;
      
     } ;
     *Leftleaf  =  F ;
    
    }
  /*Traverses the tree BB-RL and returns the values in a list*/
  void Traversal_3 (Pointeur_ATib *T , Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_ATib Clonet=NULL;
      Pointeur_ATib P=NULL;
      Pointeur_ATib F=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib S=NULL;
      bool Up;
      int _Px1;
      int _Px2;

      /** Corps du module **/
     Clonet  =  Clonetree ( & *T ) ;
     P  =  Mostright ( & Clonet ) ;
    /*We start from the most RC*/
     F  =  P ;
     while( F != NULL) {
       S  =  F ;
      /*S is to save the current leaf so that we can move to exactly the next leaf*/
      /*We ascend while processing the nodes*/
       if( Struct2_Tib ( Info_ATib ( F )  ) == False) {
         Aff_struct2_Tib ( Info_ATib ( F )  , True ) ;
        /*We mark the processed nodes as visited*/
         _Px1 =  Struct1_Tib ( Info_ATib ( F )  ) ;
         Addtolist ( & *Head , &_Px1) ;
        
       } ;
       Q  =  F ;
       P  =  Pere_ATib ( Q ) ;
       Up  =  True ;
       while( ( P != NULL ) && Up) {
         if( Struct2_Tib ( Info_ATib ( P )  )) {
           Up  =  False ;
          /*While ascending if we found an already visited node we stop*/
           }
        /*Else we keep going up*/
         else
           {
           Aff_struct2_Tib ( Info_ATib ( P )  , True ) ;
           _Px2 =  Struct1_Tib ( Info_ATib ( P )  ) ;
           Addtolist ( & *Head , &_Px2) ;
           Q  =  P ;
           P  =  Pere_ATib ( P ) ;
          
         } ;
        
       } ;
      /*once we stop ascending, either we reached the root or a visited node*/
      /*we move on to the next leaf to start again*/
       Nextleft ( & S , & F ) ;
      
     } ;
    
    }
  /* Normal branche by branche from right to left traversal (repeated nodes)*/
  /* Returns the head of the constructed list */
  void Normal_bbrl (Pointeur_ATib *T , Pointeur_Li *Head)
    {
      /** Variables locales **/
      Pointeur_ATib P=NULL;
      Pointeur_ATib F=NULL;
      Pointeur_ATib Q=NULL;
      Pointeur_ATib S=NULL;
      int _Px1;
      int _Px2;

      /** Corps du module **/
     P  =  Mostright ( & *T ) ;
     F  =  P ;
     while( F != NULL) {
       S  =  F ;
       _Px1 =  Struct1_Tib ( Info_ATib ( F )  ) ;
       Addtolist ( & *Head , &_Px1) ;
       Q  =  F ;
       P  =  Pere_ATib ( Q ) ;
       while( ( P != NULL )) {
         _Px2 =  Struct1_Tib ( Info_ATib ( P )  ) ;
         Addtolist ( & *Head , &_Px2) ;
         Q  =  P ;
         P  =  Pere_ATib ( P ) ;
        
       } ;
       Nextleft ( & S , & F ) ;
      
     } ;
    
    }
  bool  Checktraversal_3 (Pointeur_ATib *Tree , Pointeur_Li *Head_bbrl) 
    {
      /** Variables locales **/
      bool  Checktraversal_32 ;
      Pointeur_Li Head_check=NULL;

      /** Corps du module **/
     Normal_bbrl ( & *Tree , & Head_check ) ;
     Eliminateduplicates ( & Head_check ) ;
     while( ( *Head_bbrl != NULL ) && ( Head_check != NULL )) {
       if( Valeur_Li ( *Head_bbrl ) != Valeur_Li ( Head_check )) {
         Checktraversal_32  =  False ;
        
       } ;
       *Head_bbrl  =  Suivant_Li ( *Head_bbrl ) ;
       Head_check  =  Suivant_Li ( Head_check ) ;
      
     } ;
     if( ( *Head_bbrl == NULL ) && ( Head_check == NULL )) {
       Checktraversal_32  =  True ;
       }
     else
       {
       Checktraversal_32  =  False ;
      
     } ;
    
     return Checktraversal_32 ;
    }
  /* ============= TRAVERSAL 2 : LL_LR ============= */
  /* Gives the leaves of the tree from left to right (Their children are NIL or visited) */
  void Ll_lr (Pointeur_ATib *T , Pointeur_Li *Headlist)
    {
      /** Variables locales **/
      int _Px1;
      int _Px2;
      Pointeur_ATib _Px3=NULL;
      int _Px4;
      int _Px5;
      Pointeur_ATib _Px6=NULL;
      Pointeur_ATib _Px7=NULL;
      Pointeur_ATib _Px8=NULL;

      /** Corps du module **/
     if( *T != NULL) {
       if( Fg_ATib ( *T ) == NULL) {
        /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
         if( Fd_ATib ( *T ) == NULL) {
           Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
           _Px1 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
           Addtolist ( & *Headlist , &_Px1) ;
           }
         else
           {
          /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
           if( Struct2_Tib ( Info_ATib ( Fd_ATib ( *T ) )  ) == True) {
             Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
             _Px2 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
             Addtolist ( & *Headlist , &_Px2) ;
             }
           else
             {
             _Px3 =  Fd_ATib ( *T ) ;
             Ll_lr ( &_Px3, & *Headlist ) ;
            
           } ;
          
         } ;
         }
       else
         {
         if( Struct2_Tib ( Info_ATib ( Fg_ATib ( *T ) )  ) == True) {
          /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
           if( Fd_ATib ( *T ) == NULL) {
             Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
             _Px4 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
             Addtolist ( & *Headlist , &_Px4) ;
             }
           else
             {
            /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
             if( Struct2_Tib ( Info_ATib ( Fd_ATib ( *T ) )  ) == True) {
               Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
               _Px5 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
               Addtolist ( & *Headlist , &_Px5) ;
               }
             else
               {
               _Px6 =  Fd_ATib ( *T ) ;
               Ll_lr ( &_Px6, & *Headlist ) ;
              
             } ;
            
           } ;
           }
         else
           {
           _Px7 =  Fg_ATib ( *T ) ;
           Ll_lr ( &_Px7, & *Headlist ) ;
           if( Fd_ATib ( *T ) != NULL) {
             if( Struct2_Tib ( Info_ATib ( Fd_ATib ( *T ) )  ) == False) {
               _Px8 =  Fd_ATib ( *T ) ;
               Ll_lr ( &_Px8, & *Headlist ) ;
              
             } ;
            
           } ;
          
         } ;
        
       } ;
      
     } ;
    
    }
  /* Reapeat the action LL_LR 'till it reaches the height of the tree so it treats all the nodes */
  void Traversal_2 (Pointeur_ATib *T , Pointeur_Li *Headlist)
    {
      /** Variables locales **/
      Pointeur_ATib Clonet=NULL;
      int I;
      int Hauteur;

      /** Corps du module **/
     Hauteur  =  Height ( & *T ) ;
     Clonet  =  Clonetree ( & *T ) ;
     for( I  =  1 ;I <=  Hauteur ; ++I){
       Ll_lr ( & Clonet , & *Headlist ) ;
      
     } ;
    
    }
  /* Checks if the traversal 2 (LL_LR) is correct by deleting the visited leaves and comparing them with List_LL */
  bool  Checktraversal_2 (Pointeur_ATib *T , Pointeur_Li *Headlist) 
    {
      /** Variables locales **/
      bool  Checktraversal_22 ;
      Pointeur_ATib Clonet=NULL;
      Pointeur_ATib R=NULL;
      Pointeur_ATib R2=NULL;
      Pointeur_ATib P=NULL;
      Pointeur_Li Q=NULL;
      bool Check;

      /** Corps du module **/
     Clonet  =  Clonetree ( & *T ) ;
     Q  =  *Headlist ;
     R  =  NULL ;
     Check  =  True ;
     while( ( Clonet != NULL ) && ( Q != NULL ) && ( Check == True )) {
       if( R == NULL) {
         R  =  Mostleft ( & Clonet ) ;
        
       } ;
       Nextright ( & R , & R2 ) ;
       P  =  Pere_ATib ( R ) ;
       if( Struct1_Tib ( Info_ATib ( R )  ) == Valeur_Li ( Q )) {
         if( P != NULL) {
           if( R == Fg_ATib ( P )) {
             Aff_fg_ATib ( P , NULL ) ;
             }
           else
             {
             Aff_fd_ATib ( P , NULL ) ;
            
           } ;
           }
         else
           {
           Clonet  =  NULL ;
          
         } ;
         }
       else
         {
         Check  =  False ;
        
       } ;
       Q  =  Suivant_Li ( Q ) ;
       R  =  R2 ;
      
     } ;
     Checktraversal_22  =  Check ;
    
     return Checktraversal_22 ;
    }
  /* ============= TRAVERSAL 4 : LL_RL ============= */
  /* Gives the leaves of the tree from right to left (Their children are NIL or visited) */
  void Ll_rl (Pointeur_ATib *T , Pointeur_Li *Headlist)
    {
      /** Variables locales **/
      int _Px1;
      int _Px2;
      Pointeur_ATib _Px3=NULL;
      int _Px4;
      int _Px5;
      Pointeur_ATib _Px6=NULL;
      Pointeur_ATib _Px7=NULL;
      Pointeur_ATib _Px8=NULL;

      /** Corps du module **/
     if( *T != NULL) {
       if( Fd_ATib ( *T ) == NULL) {
        /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
         if( Fg_ATib ( *T ) == NULL) {
           Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
           _Px1 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
           Addtolist ( & *Headlist , &_Px1) ;
           }
         else
           {
          /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
           if( Struct2_Tib ( Info_ATib ( Fg_ATib ( *T ) )  ) == True) {
             Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
             _Px2 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
             Addtolist ( & *Headlist , &_Px2) ;
             }
           else
             {
             _Px3 =  Fg_ATib ( *T ) ;
             Ll_rl ( &_Px3, & *Headlist ) ;
            
           } ;
          
         } ;
         }
       else
         {
         if( Struct2_Tib ( Info_ATib ( Fd_ATib ( *T ) )  ) == True) {
          /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
           if( Fg_ATib ( *T ) == NULL) {
             Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
             _Px4 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
             Addtolist ( & *Headlist , &_Px4) ;
             }
           else
             {
            /* ECRIRE ( INFO ( *T ) , ' ' ) ; */
             if( Struct2_Tib ( Info_ATib ( Fg_ATib ( *T ) )  ) == True) {
               Aff_struct2_Tib ( Info_ATib ( *T )  , True ) ;
               _Px5 =  Struct1_Tib ( Info_ATib ( *T )  ) ;
               Addtolist ( & *Headlist , &_Px5) ;
               }
             else
               {
               _Px6 =  Fg_ATib ( *T ) ;
               Ll_rl ( &_Px6, & *Headlist ) ;
              
             } ;
            
           } ;
           }
         else
           {
           _Px7 =  Fd_ATib ( *T ) ;
           Ll_rl ( &_Px7, & *Headlist ) ;
           if( Fg_ATib ( *T ) != NULL) {
             if( Struct2_Tib ( Info_ATib ( Fg_ATib ( *T ) )  ) == False) {
               _Px8 =  Fg_ATib ( *T ) ;
               Ll_rl ( &_Px8, & *Headlist ) ;
              
             } ;
            
           } ;
          
         } ;
        
       } ;
      
     } ;
    
    }
  /* Reapeat the action LL_RL 'till it reaches the height of the tree so it treats all the nodes */
  void Traversal_4 (Pointeur_ATib *T , Pointeur_Li *Headlist)
    {
      /** Variables locales **/
      Pointeur_ATib Clonet=NULL;
      int I;
      int Hauteur;

      /** Corps du module **/
     Hauteur  =  Height ( & *T ) ;
     Clonet  =  Clonetree ( & *T ) ;
     for( I  =  1 ;I <=  Hauteur ; ++I){
       Ll_rl ( & Clonet , & *Headlist ) ;
      
     } ;
    
    }
  /* Checks if the traversal 4 (LL_RL) is correct by deleting the visited leaves and comparing them with List_LL */
  bool  Checktraversal_4 (Pointeur_ATib *T , Pointeur_Li *Headlist) 
    {
      /** Variables locales **/
      bool  Checktraversal_42 ;
      Pointeur_ATib Clonet=NULL;
      Pointeur_ATib R=NULL;
      Pointeur_ATib R2=NULL;
      Pointeur_ATib P=NULL;
      Pointeur_Li Q=NULL;
      bool Check;

      /** Corps du module **/
     Clonet  =  Clonetree ( & *T ) ;
     Q  =  *Headlist ;
     R  =  NULL ;
     Check  =  True ;
     while( ( Clonet != NULL ) && ( Q != NULL ) && ( Check == True )) {
       if( R == NULL) {
         R  =  Mostright ( & Clonet ) ;
        
       } ;
       Nextleft ( & R , & R2 ) ;
       P  =  Pere_ATib ( R ) ;
       if( Struct1_Tib ( Info_ATib ( R )  ) == Valeur_Li ( Q )) {
         if( P != NULL) {
           if( R == Fg_ATib ( P )) {
             Aff_fg_ATib ( P , NULL ) ;
             }
           else
             {
             Aff_fd_ATib ( P , NULL ) ;
            
           } ;
           }
         else
           {
           Clonet  =  NULL ;
          
         } ;
         }
       else
         {
         Check  =  False ;
        
       } ;
       Q  =  Suivant_Li ( Q ) ;
       R  =  R2 ;
      
     } ;
     Checktraversal_42  =  Check ;
    
     return Checktraversal_42 ;
    }
  void Traversals (Pointeur_ATib *T)
    {
      /** Variables locales **/
      bool Treetraversals;
      int Traversal;
      int Check;
      Pointeur_Li Head_bblr=NULL;
      Pointeur_Li Head_bbrl=NULL;
      Pointeur_Li Head_lllr=NULL;
      Pointeur_Li Head_llrl=NULL;

      int key;
      int SelecterTraversal = 0;
      const char *traversals[] = {"BB_LR", "LL_LR", "BB_RL", "LL_RL", "RETURN"};
      int numTraversals = sizeof(traversals) / sizeof(traversals[0]);

      /** Corps du module **/
     Treetraversals  =  True ;
     while( Treetraversals == True) {
        system ("cls");
       printf ( "\n" ) ;
       printTree(Tree, NULL, 0);
       printf ( "\n" ) ;
       printf ( " %s", "\t ======= TRAVERSALS ======= \n" ) ;
       for (int i=0; i < numTraversals; i++) {
          if (i == SelecterTraversal) {
            printf ("\t\t > %s <\n", traversals[i]);
          } 
          else {
            printf ("\t\t   %s\n", traversals[i]);
          }
       }

       key = getch();
       switch (key) {
          case 72: // Up
            SelecterTraversal = (SelecterTraversal - 1 + numTraversals) % numTraversals;
            break;
          case 80: // Down
            SelecterTraversal = (SelecterTraversal + 1) % numTraversals;
            break;
          case 13: // Enter key
            if (SelecterTraversal == numTraversals - 1) {
              return;
              exit(0);
            }
            else {
              printf ("\n");
              switch (SelecterTraversal) {
                case 0:
                  Head_bblr  =  NULL ;
                  Traversal_1 ( & Tree , & Head_bblr ) ;
                  printf ("   Traversal branch by branch from left to right : \n\n");
                  Displaylist ( & Head_bblr ) ;
                  printf ( " %s", " " ) ;
                  printf ( "\n\n" ) ;
                  printf ( " %s", "   Do you want to check Traversal 1 (BB_LR) ?\n" ) ;
                  printf ( " %s", "\t 1. YES \n" ) ;
                  printf ( " %s", "\t 2. NO \n" ) ;
                  Check  =  0 ;
                  while( ( Check > 2 ) || ( Check < 1 )) {
                    printf ("\n   Enter your choice (1/2) : ");
                    scanf ( " %d", &Check ) ;
          
                  } ;
                  if( Check == 1) {
                    if( Checktraversal_1 ( & *T , & Head_bblr )) {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is correct " ) ;
                      printf ( "\n" ) ;
                      getch ();

                      }
                    else
                      {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is wrong " ) ;
                      printf ( "\n" ) ;

                    } ;
          
                  } ;
                  
                  break;
                case 1:
                  Head_lllr  =  NULL ;
                  Traversal_2 ( & Tree , & Head_lllr ) ;
                  printf ("   Traversal leaf by leaf from left to right : \n\n");
                  Displaylist ( & Head_lllr ) ;
                  printf ( " %s", " " ) ;
                  printf ( "\n\n" ) ;
                  printf ( " %s", "   Do you want to check Traversal 2 (LL_LR) ?\n" ) ;
                  printf ( " %s", "\t 1. YES \n" ) ;
                  printf ( " %s", "\t 2. NO \n" ) ;
                  Check  =  0 ;
                  while( ( Check > 2 ) || ( Check < 1 )) {
                    printf ("\n   Enter your choice (1/2) : ");
                    scanf ( " %d", &Check ) ;
          
                  } ;
                  if( Check == 1) {
                    if( Checktraversal_2 ( & *T , & Head_lllr )) {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is correct " ) ;
                      printf ( "\n" ) ;
                      getch();

                      }
                    else
                      {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is wrong " ) ;
                      printf ( "\n" ) ;

                    } ;
          
                  } ;
            
                  break;
                
                case 2:
                  Head_bbrl  =  NULL ;
                  Traversal_3 ( & Tree , & Head_bbrl ) ;
                  printf ("   Traversal branch by branch from right to left : \n\n");
                  Displaylist ( & Head_bbrl ) ;
                  printf ( " %s", " " ) ;
                  printf ( "\n\n" ) ;
                  printf ( " %s", "   Do you want to check Traversal 3 (BB_RL) ?\n" ) ;
                  printf ( " %s", "\t 1. YES \n" ) ;
                  printf ( " %s", "\t 2. NO \n" ) ;
                  Check  =  0 ;
                  while( ( Check > 2 ) || ( Check < 1 )) {
                    printf ("\n   Enter your choice (1/2) : ");
                    scanf ( " %d", &Check ) ;
          
                  } ;
                  if( Check == 1) {
                    if( Checktraversal_3 ( & *T , & Head_bbrl )) {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is correct " ) ;
                      printf ( "\n" ) ;
                      getch();

                      }
                    else
                      {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is wrong " ) ;
                      printf ( "\n" ) ;

                    } ;
          
                  } ;
            
            break;
                case 3:
                  Head_llrl  =  NULL ;
                  Traversal_4 ( & Tree , & Head_llrl ) ;
                  printf ("   Traversal leaf by leaf from right to left : \n\n");
                  Displaylist ( & Head_llrl ) ;
                  printf ( " %s", " " ) ;
                  printf ( "\n\n" ) ;
                  printf ( " %s", "   Do you wnat to check Traversal 4 (LL_RL) ?\n" ) ;
                  printf ( " %s", "\t 1. YES \n" ) ;
                  printf ( " %s", "\t 2. NO \n" ) ;
                  Check  =  0 ;
                  while( ( Check > 2 ) || ( Check < 1 )) {
                    printf ("\n   Enter your choice (1/2) : ");
                    scanf ( " %d", &Check ) ;
          
                  } ;
                  if( Check == 1) {
                    if( Checktraversal_4 ( & *T , & Head_llrl )) {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is correct " ) ;
                      printf ( "\n" ) ;
                      getch();

                      }
                    else
                      {
                      printf ( " %s", " " ) ;
                      printf ( "\n" ) ;
                      printf ( " %s", "\t\t--> The traversal is wrong " ) ;
                      printf ( "\n" ) ;

                    } ;
          
                  } ;
            
                  break;
                
                default:
                  Treetraversals  =  False ;  
              }  
            }
       }
     }
    
    }

  int main(int argc, char *argv[])
    {
     bool done = False;
     srand(time(NULL));
     S = malloc(sizeof(Type_Tib));
     system ("color 02"); // 0 for the color of the background and 2 for the color of the text
     printf ( " %s", "\n\t\t\tWelcome to  ALSDD  TP 02  !!\n" ) ;
     printf ( "\t\t\t\tTree Traversals\n");
     printf ( " %s\n", "" ) ;
     printf ( " %s", " We hope to be able to show you our efforts with this program\n" ) ;
     printf ( " %s", "                          Realised by : Seghouani Sirine//Touadi Imene//Section B : G05\n\n\n" ) ;
     printf ( " %s", "" ) ;
     printf ( " %s", "" ) ;
     printf ( " %s", "" ) ;
     printf ( " %s", " Enter the number of iterations (You can take m=10) : " ) ;
     scanf ( " %d", &Numberiterations ) ;

      int key;
      int SelecterMenu = 0;
      const char *menu[] = {"1. Generate a binary search tree",
                            "2. Verify that the tree is correctly constructed",
                            "3. Apply the traversals"};
      int numMenu = sizeof(menu) / sizeof(menu[0]);

     for( M  =  1 ;M <=  Numberiterations ; ++M){
       Iterationterminee  =  False ;
       while( Iterationterminee == False) {
          system ("cls");
         printf ( "\n\n" ) ;
         printf ("\t\t\t*** TP ALSDD : Tree Traversals ***\n\n");
         printf ( " %s", "\t\t========== MENU ========== " ) ;
         printf ( "\n" ) ;
         for (int i=0; i<numMenu; i++) {
          if (i == SelecterMenu) {
            printf ("\t> %s <\n", menu[i]);
          }
          else {
            printf ("\t%s\n", menu[i]);
          }
         }
        printf("\n\tPlease use the Up and Down arrow keys to navigate through the options and press Enter to select.\n");
         key = getch();
         switch (key) {
          case 72: //up
            SelecterMenu = (SelecterMenu - 1 + numMenu) % numMenu;
            break;
          case 80: //down
            SelecterMenu = (SelecterMenu + 1) % numMenu;
            break;
          case 13:
              printf ("\n");
              switch (SelecterMenu) {
                case 0:
                  Generatetree ( & Tree ) ;
                  printTree(Tree, NULL, 0);
                  done = True;
                  break;
                case 1:
                  if (done == False)
                  {   printf("\n");
                      printf("\t  --> Would you generate the tree first, please?");
                      printf("\n");

                  }
            
                 else {
                  printf ( "\n" ) ;
                  printTree(Tree, NULL, 0);
                   _Px1 =  - 1000 ;
                   _Px2 =  1000 ;
                   B  =  Isbst ( & Tree , &_Px1, &_Px2) ;
                  /* Min and Max values are put -1000 to 1000 */
                  /* because of the interval of generating the random numbers */
                   if( B == True) {
                      printf ( "\n" ) ;
                      printf ( " %s", " Tree satisfies the proprieties of a BST, well constructed. \n\n" ) ;
                     }
                   else
                     {
                      printf ( "\n" ) ;
                      printf ( " %s", " Tree does not satisfy the proprieties of a BST. \n\n" ) ;
              
                    } ;
                  }
                  break;
                case 2:
                    if (done == False)
                    {
                      printf("\n");
                      printf("\t  --> Would you generate the tree first, please?");
                      printf("\n");
                    }
                    else {
                      Traversals ( & Tree ) ;
                      Iterationterminee  =  True ;
                    }
                  break;
              };
              printf ("\n\tPress any key to continue...\n\n");
              getch();
        };
       };
     };
   
      system("PAUSE");
      return 0;
    }
