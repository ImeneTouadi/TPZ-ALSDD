
   SOIENT
{=========================== VARIABLES =================================}

       Tree : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       Head_BBLR , Head_BBRL DES POINTEURS VERS UNE LISTE DE ENTIER ;
       Head_LLLR , Head_LLRL DES POINTEURS VERS UNE LISTE DE ENTIER ;  
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;
       B UN BOOLEEN ;

{=========================== MODULES =================================}

       Isuniquevalue : FONCTION ( BOOLEEN ) ;
       Isbst : FONCTION ( BOOLEEN ) ;
       HEIGHT : FONCTION ( ENTIER ) ;
          { Creation of the tree }
       Insert UNE ACTION ;
       Create_tree UNE ACTION ;
       CloneTree : FONCTION (POINTEUR VERS UN ARB DE (ENTIER, BOOLEEN));
       ArbreExemple UNE ACTION ;
       Display UNE ACTION ;      {inorder/for check}
          { Lists }
       Displaylist UNE ACTION ;
       AddToList UNE ACTION ;
       EliminateDuplicates UNE ACTION ;

          {BB-LR}
       Mostleft : FONCTION (POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )) ;
       Nextright UNE ACTION ;
       Traversal_1 UNE ACTION ;
       Normal_BBLR UNE ACTION ; {branche by branche traversal with repeated nodes}
       CheckTraversal_1 : FONCTION ( BOOLEEN ) ;

          {BB-RL}
       Mostright : FONCTION (POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )) ;
       Nextleft UNE ACTION ;
       Traversal_3 UNE ACTION ;
       Normal_BBRL UNE ACTION ;
       CheckTraversal_3 : FONCTION ( BOOLEEN ) ;

          {LL-LR}
       LL_LR UNE ACTION ;
       Traversal_2 UNE ACTION ;
       CheckTraversal_2 : FONCTION ( BOOLEEN ) ;

          {LL-RL}
       LL_RL UNE ACTION ;
       Traversal_4 UNE ACTION ;
       CheckTraversal_4 : FONCTION ( BOOLEEN ) ;

{====================== PROGRAMME PRINCIPALE ======================}
   DEBUT
       {APPEL Create_tree ( Tree ) ;}
       APPEL ArbreExemple ( Tree );
       APPEL Display ( Tree ) ;
       B := Isbst ( Tree , -1000 , 1000 ) ;
      { Min and Max values are put -1000 to 1000 because of the interval of generating the random numbers }
       SI B = VRAI
           ECRIRE ( 'Tree is a BST.' ) ;

       SINON
           ECRIRE ( 'Tree is NOT a BST.' ) ;

       FSI ;

       ECRIRE ( ' LEAVES BB_RL ' ) ;
       APPEL traversal_3( Tree , Head_BBRL );
       ECRIRE ( ' LIST ' ) ;
       APPEL Displaylist( Head_BBRL );

       SI CheckTraversal_3( Tree, Head_BBRL)
          ecrire('Your traversal is correct');
       SINON
          ecrire('Your traversal is wrong');
       FSI

   FIN

{=================== IMPLEMENTATION DES MODULES ======================}

{ Checks the unicity of a given val, Returns false if it already exists in the tree }
   FONCTION Isuniquevalue ( T , Val ) : BOOLEEN
   SOIENT
       T : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;

   DEBUT
       SI T = NIL :
           Isuniquevalue := VRAI ;
       SINON
           SI Val = STRUCT ( INFO ( T ) , 1 ) :
               Isuniquevalue := FAUX ;
           SINON
               SI Val < STRUCT ( INFO ( T ) , 1 ) :
                   Isuniquevalue := Isuniquevalue ( FG ( T ) , Val ) ;
               SINON
                   Isuniquevalue := Isuniquevalue ( FD ( T ) , Val ) ;
               FSI ;
           FSI ;
       FSI ;

   FIN

{ Checks wether the tree satisfies the proprieties of the BST }
   FONCTION Isbst ( T , Minimum , Maximum ) : BOOLEEN
   SOIENT
       Val , Minimum , Maximum UN ENTIER ;
       Valid UN BOOLEEN ;
       T : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;

   DEBUT
       SI T = NIL
           Isbst := VRAI ;
       SINON
           Val := STRUCT ( INFO ( T ) , 1 ) ;
           SI ( Val <= Minimum ) OU ( Val >= Maximum ) :
               Isbst := FAUX ;
           SINON
               Valid := Isbst ( FG ( T ) , Minimum , Val ) ET Isbst ( FD ( T ) , Val , Maximum ) ;
               Isbst := Valid ;
           FSI ;
       FSI ;

   FIN

{ Calculates the height of a tree }
   FONCTION HEIGHT ( T ) : ENTIER
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         LH , RH UN ENTIER ;

   DEBUT
        SI T = NIL
           HEIGHT := 0 ;
        SINON
           LH := HEIGHT (FG(T)) ;
           RH := HEIGHT (FD(T)) ;

           SI LH > RH
              HEIGHT := LH + 1 ;
           SINON
              HEIGHT := RH + 1 ;
           FSI ;
        FSI ;
   FIN

{inserts a node in binary search tree with a given value, initialized at false (not visited)}
{doesn't treat case of value exists cause it will be treated when creating the tree and generating the values}
   ACTION Insert ( T , Val )
   SOIENT
       T , R DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;

   DEBUT
       AFF_STRUCT ( S , 1 , Val ) ;
       AFF_STRUCT ( S , 2 , FAUX ) ;
       SI T = NIL
           CREERNOEUD ( T ) ;
           AFF_INFO ( T , S ) ;
           AFF_FG ( T , NIL ) ;
           AFF_FD ( T , NIL ) ;
           R := T ;

       SINON
           SI Val < STRUCT ( INFO ( T ) , 1 )
               R := FG ( T ) ;
               APPEL Insert ( R , Val ) ;
               AFF_FG ( T , R ) ;

           SINON
               R := FD ( T ) ;
               APPEL Insert ( R , Val ) ;
               AFF_FD ( T , R ) ;

           FSI ;

           AFF_PERE ( R , T ) ;

       FSI ;

   FIN

{ Generates a tree with 100 random data initialized at false }
{ All 100 value are checked to be unique }
   ACTION Create_tree ( T )
   SOIENT
       T : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       I , Value UN ENTIER ;
       Check UN BOOLEEN ;

   DEBUT
       POUR I := 1 , 100
           Value := ALEANOMBRE ( 1000 ) ;
           Check := Isuniquevalue ( T , Value ) ;
           TANTQUE Check = FAUX
   {if it indicates that the value exists in the tree, it will generate other until it's unique }
               Value := ALEANOMBRE ( 1000 ) ;
               Check := Isuniquevalue ( T , Value ) ;

           FTQ ;
           APPEL Insert ( T , Value ) ;

       FINPOUR ;

   FIN

FONCTION CloneTree(Original): POINTEUR VERS UN ARB DE (ENTIER, BOOLEEN);
SOIENT
    Original, clone DES POINTEURS VERS UN ARB DE (ENTIER, BOOLEEN);
DEBUT
    SI original = NIL
        clone := NIL
    FSI;

    CREERNOEUD ( Clone ) ;
    AFF_INFO ( Clone , INFO(Original) ) ;

    SI FG(Original) <> NIL
    AFF_FG(clone, CloneTree(FG(original)));
    FSI;

    SI FD(Original) <> NIL
    AFF_FD(clone, CloneTree(FD(original)));
    FSI;

    SI FG(Clone) <> NIL
       AFF_PERE(FG(Clone),Clone);
    FSI;

    SI FD(Clone) <> NIL
       AFF_PERE(FD(Clone),Clone);
    FSI;

    CloneTree := Clone;

FIN  

{ Displays a tree inorder (did it just for check) }
   ACTION Display ( T )
   SOIENT
       T : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;

   DEBUT
       SI T <> NIL
           APPEL Display ( FG ( T ) ) ;
           ECRIRE ( INFO ( T ) , '  ' ) ;
           APPEL Display ( FD ( T ) ) ;
       FSI ;

   FIN

{ Just an exemple of a tree to test the functions }
   ACTION ArbreExemple ( T )
   SOIENT
         T , R , R2 DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;

   DEBUT
        CREERNOEUD ( T ) ;
        AFF_STRUCT ( S , 1 , 45 ) ;
        AFF_STRUCT ( S , 2 , FAUX ) ;
        AFF_INFO ( T , S ) ;
        AFF_PERE (T , NIL );

        CREERNOEUD ( R ) ;
        AFF_STRUCT ( S , 1 , 20 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R , S ) ;
        AFF_FG ( T , R ) ;
        AFF_PERE ( R , T );

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 10 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FG ( R , R2 ) ;
        AFF_PERE ( R2 , R );
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 35 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FD ( R , R2 ) ;
        AFF_PERE ( R2 , R );
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;

        CREERNOEUD ( R ) ;
        AFF_STRUCT ( S , 1 , 65 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R , S ) ;
        AFF_FD ( T , R ) ;
        AFF_PERE ( R , T );
        AFF_FG ( R , NIL ) ;

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 55 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FG ( R , R2 ) ;
        AFF_PERE ( R2 , R );
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;
   FIN

{Displays the values of a list }
   ACTION DisplayList ( Head )
   SOIENT
         Head , current DES POINTEURS VERS UNE LISTE DE ENTIER ;

   DEBUT
        current := Head ;
        TQ current <> NIL
           ECRIRE ( VALEUR(current) ) ;
           current := SUIVANT (current) ;
        FTQ ;
   FIN

{Insertion at the end of the list}
   ACTION AddToList ( Head, val )
   SOIENT
         Head , Cell , current DES POINTEURS VERS UNE LISTE DE ENTIER ;
         val UN ENTIER ;

   DEBUT
        ALLOUER (Cell) ;
        AFF_VAL ( Cell , val ) ;
        AFF_ADR ( Cell , NIL ) ;
        SI Head = NIL
           head := Cell ;
        SINON
           current := Head ;
           TQ SUIVANT(current) <> NIL
              current := SUIVANT (current) ;
           FTQ ;
           AFF_ADR ( current , Cell ) ;
        FSI ;
   FIN

{Eliminates duplicated values in a list}
   ACTION EliminateDuplicates ( Head )
   SOIENT
         Head , current , comparer , previous DES POINTEURS VERS UNE LISTE DE ENTIER ;

   DEBUT
        current := Head ;
        TQ current <> NIL
           previous := current ;
           comparer := SUIVANT(current) ;

           TQ comparer <> NIL
              SI VALEUR(comparer) = VALEUR(current)
                 AFF_ADR( previous , SUIVANT(comparer) ) ;
                 LIBERER ( comparer ) ;
                 comparer := SUIVANT( previous ) ;
              SINON
                 previous := comparer ;
                 comparer := SUIVANT (comparer) ;
              FSI ;
           FTQ ;

           current := SUIVANT (current) ;
        FTQ ;
   FIN

       { ============= TRAVERSAL 1 : BB_LR ============= }

{ Gives the most left leaf of a given tree ( or sub-tree ) }
   FONCTION Mostleft ( T ) : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )
   SOIENT
       T , P DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       Stop : BOOLEEN ;

   DEBUT
       P := T ;
       Stop := FAUX ;
       TQ NON Stop
           TQ FG ( P ) <> NIL      {Descend left until the first Nil LC}
               P := FG ( P )
           FTQ ;
           SI FD ( P ) = NIL     {If the node has no RC then we're in the most LC}
               Stop := VRAI
           SINON
               P := FD ( P )     {Else we go right once and procceed to descend left again}
           FSI
       FTQ ;
       Mostleft := P
   FIN

   { Gives the next leaf on the right of a given leaf }
   ACTION Nextright ( Leaf , Rightleaf ) ;
   SOIENT
       Leaf , P , Q , F , Rightleaf DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       Up UN BOOLEEN ;

   DEBUT
       Q := Leaf ;
       Up := VRAI ;
       P := PERE ( Q ) ;
       TQ ( P <> NIL ) ET Up       {We're in the leaf and we go up}
           SI Q = FD ( P )
               Q := P ;
               P := PERE ( Q )
           SINON
               SI FD ( P ) <> NIL   {if p has a RC then we stop going up}
                   Up := FAUX
               SINON
                   Q := P ;
                   P := PERE ( Q )
               FSI
           FSI
       FTQ ;
       SI P <> NIL
{Once we get to the parent of the wanted next leaf we descend to the most LC to reach it}
           F := Mostleft ( FD ( P ) ) ;
       SINON
            F := NIL;
       FSI ;
       Rightleaf := F ;

   FIN

      {Traverses the tree by BB-LR and returns the values in a list}
   ACTION Traversal_1 ( T , Head )
   SOIENT
       T , CloneT DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       Head UN POINTEURS VERS UNE LISTE DE ENTIER ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE (ENTIERS,BOOLEEN) ;
       Up UN BOOLEEN ;

   DEBUT
       CloneT := CloneTree ( T ) ;
       P := Mostleft ( CloneT ) ;  {We start from the most LC}
       F := P ;
       TQ F <> NIL
           S := F ;      {S is to save the current leaf so that we can move to exactly the next leaf}
           SI STRUCT(INFO(F),2) = FAUX
        {We ascend while processing the nodes}
           AFF_STRUCT ( INFO(F), 2 , VRAI ) ; {We mark the processed nodes as visited}
           APPEL AddToList( Head , STRUCT(INFO(F),1) ) ;
           FSI ;
           Q := F ;
           P := PERE ( Q ) ;
           Up := VRAI ;
           TQ ( P <> NIL ) ET Up
               SI STRUCT(INFO(P),2)  {While ascending if we found an already visited node we stop}
                   Up := FAUX ;
               SINON                  {Else we keep going up}
                   AFF_STRUCT ( INFO(P), 2 , VRAI );
                   APPEL AddToList(Head, STRUCT(INFO(P),1));
                   Q := P ;
                   P := PERE ( P );
               FSI ;
           FTQ ;
 {once we stop ascending, either we reached the root or a visited node}
 {we move on to the next leaf to start again}
         APPEL Nextright ( S , F ) ;
       FTQ ;
   FIN

   { Normal branche by branche from left to right traversal (repeated nodes)}
   { Returns the head of the constructed list  }
   ACTION Normal_BBLR ( T , Head )
   SOIENT
       Head UN POINTEUR VERS UNE LISTE DE ENTIER ;
       T UN POINTEUR VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;

   DEBUT
       P := Mostleft(T) ;
       F := P ;
       TQ F <> NIL
          S := F ;
          APPEL AddToList( Head, STRUCT(INFO(F),1) ) ;

          Q := F ;
          P := PERE ( Q ) ;
          TQ ( P <> NIL )
             APPEL AddToList( Head , STRUCT(INFO(P),1) ) ;
             Q := P ;
             P := PERE ( P ) ;
          FTQ ;
          APPEL Nextright ( S , F ) ;
       FTQ ;
   FIN


   FONCTION CheckTraversal_1 ( Tree , Head_BBLR ):BOOLEEN
   SOIENT
         Tree UN POINTEUR VERS UN ARB DE (ENTIER,BOOLEEN) ;
         Head_BBLR , Head_Check DES POINTEURS VERS UNE LISTE DE ENTIER ;

   DEBUT
        APPEL normal_BBLR ( Tree , Head_Check ) ;
        APPEL EliminateDuplicates (Head_Check) ;

        TQ (Head_BBLR <> NIL) ET (Head_Check <> NIL)
           SI VALEUR(Head_BBLR) <> VALEUR(Head_Check)
              CheckTraversal_1 := FAUX ;
           FSI ;
           Head_BBLR := SUIVANT (Head_BBLR) ;
           Head_Check := SUIVANT (Head_Check) ;
        FTQ ;

        SI (Head_BBLR = NIL) ET (Head_Check = NIL)
           CheckTraversal_1 := VRAI ;
        SINON
           CheckTraversal_1 := FAUX ;
        FSI ;

   FIN

       { ============= TRAVERSAL 3 : BB_RL ============= }

   { Gives the most right leaf of a given tree ( or sub-tree ) }
   FONCTION Mostright ( T ) : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )
   SOIENT
       T , P DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       Stop : BOOLEEN ;

   DEBUT
       P := T ;
       Stop := FAUX ;
       TQ NON Stop
           TQ FD ( P ) <> NIL     {Descend right until the first Nil RC}
               P := FD ( P )
           FTQ ;
           SI FG ( P ) = NIL      {If the node has no LC then we're in the most RC}
               Stop := VRAI ;
           SINON
               P := FG ( P ) ;  {Else we go left once and procceed to descend right again}
           FSI
       FTQ ;
       Mostright := P ;
   FIN

   { Gives the next leaf on the left of a given leaf }
   ACTION Nextleft ( Leaf , leftleaf ) ;
   SOIENT
       Leaf , P , Q , F , leftleaf DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       Up UN BOOLEEN ;

   DEBUT
       Q := Leaf ;
       Up := VRAI ;
       P := PERE ( Q ) ;
       TQ ( P <> NIL ) ET Up        {We're in the leaf and we go up}
           SI Q = FG ( P )
               Q := P ;
               P := PERE ( Q ) ;
           SINON
               SI FG ( P ) <> NIL    {If p has a LC then we stop going up}
                   Up := FAUX ;
               SINON
                   Q := P ;
                   P := PERE ( Q ) ;
               FSI ;
           FSI ;
       FTQ ;
       SI P <> NIL
 {Once we get to the parent of the wanted next leaf we descend to the most RC to reach it}
           F := Mostright ( FG ( P ) ) ;
       SINON
            F := NIL;
       FSI ;
       leftleaf := F ;

   FIN

      {Traverses the tree BB-RL and returns the values in a list}
   ACTION Traversal_3 ( T , Head )
   SOIENT
       T , CloneT DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       Head UN POINTEURS VERS UNE LISTE DE ENTIER ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE (ENTIERS,BOOLEEN) ;
       Up UN BOOLEEN ;

   DEBUT
       CloneT := CloneTree ( T ) ;
       P := Mostright ( CloneT ) ;        {We start from the most RC}
       F := P ;
       TQ F <> NIL
           S := F ;  {S is to save the current leaf so that we can move to exactly the next leaf}
           SI STRUCT(INFO(F),2)=FAUX
       {We ascend while processing the nodes}
           AFF_STRUCT ( INFO(F), 2 , VRAI ); {We mark the processed nodes as visited}
           APPEL AddToList( Head , STRUCT(INFO(F),1) ) ;
           FSI ;
           Q := F ;
           P := PERE ( Q ) ;
           Up := VRAI ;
           TQ ( P <> NIL ) ET Up
               SI STRUCT(INFO(P),2)
                   Up := FAUX ;   {While ascending if we found an already visited node we stop}
               SINON              {Else we keep going up}

                   AFF_STRUCT ( INFO(P), 2 , VRAI ) ;
                   APPEL AddToList( Head , STRUCT(INFO(P),1) ) ;
                   Q := P ;
                   P := PERE ( P ) ;
               FSI ;
           FTQ ;
 {once we stop ascending, either we reached the root or a visited node}
 {we move on to the next leaf to start again}
         APPEL Nextleft ( S , F ) ;
       FTQ ;
   FIN

   { Normal branche by branche from right to left traversal (repeated nodes)}
   { Returns the head of the constructed list }
   ACTION Normal_BBRL ( T , Head )
   SOIENT
       Head UN POINTEUR VERS UNE LISTE DE ENTIER ;
       T UN POINTEUR VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE (ENTIERS,BOOLEEN) ;

   DEBUT
       P := Mostright(T) ;
       F := P ;
       TQ F <> NIL
           S := F ;
           APPEL AddToList( Head , STRUCT(INFO(F),1) ) ;

           Q := F ;
           P := PERE ( Q ) ;
           TQ ( P <> NIL )
              APPEL AddToList( Head , STRUCT(INFO(P),1) ) ;
              Q := P ;
              P := PERE ( P ) ;
           FTQ ;
         APPEL Nextleft ( S , F ) ;
       FTQ ;
   FIN

   FONCTION CheckTraversal_3 ( Tree , Head_BBRL ) : BOOLEEN
   SOIENT
         Tree UN POINTEUR VERS UN ARB DE (ENTIER,BOOLEEN) ;
         Head_BBRL , Head_Check DES POINTEURS VERS UNE LISTE DE ENTIER ;

   DEBUT
        APPEL normal_BBRL ( Tree , Head_Check ) ;
        APPEL EliminateDuplicates ( Head_Check ) ;
        TQ (Head_BBRL <> NIL) ET (Head_Check <> NIL)
           SI VALEUR(Head_BBRL) <> VALEUR(Head_Check)
              CheckTraversal_3 := FAUX ;
           FSI;
           Head_BBRL := SUIVANT (Head_BBRL) ;
           Head_Check := SUIVANT (Head_Check) ;
        FTQ ;

        SI (Head_BBRL = NIL) ET (Head_Check = NIL)
           CheckTraversal_3 := VRAI ;
        SINON
           CheckTraversal_3 := FAUX ;
        FSI ;

    FIN

       { ============= TRAVERSAL 2 : LL_LR ============= }

{ Gives the leaves of the tree from left to right (Their children are NIL or visited) }
   ACTION LL_LR ( T , HeadList )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList UN POINTEUR VERS UNE LISTE DE ENTIER ;

   DEBUT

        SI T <> NIL
           SI FG(T) = NIL
              SI FD(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                 APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
              SINON
                 SI STRUCT( INFO(FD(T)) , 2 ) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                    APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
                 SINON
                    APPEL LL_LR ( FD(T) , HeadList ) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT( INFO(FG(T)) , 2 ) = VRAI
                 SI FD(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                    APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
                 SINON
                    SI STRUCT( INFO(FD(T)) , 2 ) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                       APPEL AddToList ( HeadList , STRUCT(INFO(T),1) ) ;
                    SINON
                       APPEL LL_LR ( FD(T) , HeadList ) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_LR ( FG(T) , HeadList ) ;
                 SI FD(T) <> NIL
                    SI STRUCT ( INFO(FD(T)) , 2 ) = FAUX
                       APPEL LL_LR ( FD(T) , HeadList ) ;
                    FSI ;
                 FSI ;
              FSI ;
           FSI ;
        FSI ;
   FIN

{ Reapeat the action LL_LR 'till it reaches the height of the tree so it treats all the nodes }
   ACTION Traversal_2 ( T , HeadList )
   SOIENT
         T , CloneT DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList UN POINTEUR VERS UNE LISTE DE ENTIER ;
         i , hauteur DES ENTIER ;

   DEBUT
        hauteur := HEIGHT ( T ) ;
        CloneT := CloneTree ( T ) ;
        POUR i:=1 , hauteur
             APPEL LL_LR  ( CloneT , HeadList ) ;
        FINPOUR ;
   FIN

{ Checks if the traversal 2 (LL_LR) is correct by deleting the visited leaves and comparing them with List_LL }
   FONCTION CheckTraversal_2 ( T , HeadList ) : BOOLEEN
   SOIENT
         T , R , R2 , P DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList , q UN POINTEUR VERS UNE LISTE DE ENTIER ;
         Check UN BOOLEEN ;

   DEBUT
        q := HeadList ;
        R := NIL ;
        Check := VRAI ;

        TQ ( T <> NIL ) ET ( q <> NIL ) ET ( Check = VRAI )
           SI R = NIL
              R := Mostleft ( T ) ;
           FSI ;

           APPEL Nextright ( R , R2 ) ;
           P := PERE ( R ) ;

           SI STRUCT(INFO(R),1) = VALEUR(q)
              SI p <> NIL
                 SI R = FG ( P )
                    AFF_FG ( P , NIL ) ;
                 SINON
                    AFF_FD ( P , NIL ) ;
                 FSI ;
              SINON
                 T := NIL ;
              FSI ;

           SINON
              Check := FAUX ;

           FSI ;

           q := SUIVANT ( q ) ;
           R := R2 ;
        FTQ ;

        CheckTraversal_2 := Check ;
   FIN

       { ============= TRAVERSAL 4 : LL_RL ============= }

{ Gives the leaves of the tree from right to left (Their children are NIL or visited) }
   ACTION LL_RL ( T , HeadList )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList UN POINTEUR VERS UNE LISTE DE ENTIER ;

   DEBUT

        SI T <> NIL
           SI FD(T) = NIL
              SI FG(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                 APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
              SINON
                 SI STRUCT ( INFO(FG(T)) , 2 ) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                    APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
                 SINON
                    APPEL LL_RL ( FG(T) , HeadList ) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT ( INFO(FD(T)) , 2 ) = VRAI
                 SI FG(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                    APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
                 SINON
                    SI STRUCT ( INFO(FG(T)) , 2 ) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( INFO ( T ) , 2 , VRAI ) ;
                       APPEL AddToList ( HeadList , STRUCT(INFO(T) , 1) ) ;
                    SINON
                       APPEL LL_RL ( FG(T) , HeadList ) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_RL ( FD(T) , HeadList ) ;
                 SI FG(T) <> NIL
                    SI STRUCT ( INFO(FG(T)) , 2 ) = FAUX
                       APPEL LL_RL ( FG(T) , HeadList ) ;
                    FSI ;
                 FSI ;
              FSI ;
           FSI ;
        FSI ;
   FIN

{ Reapeat the action LL_RL 'till it reaches the height of the tree so it treats all the nodes }
   ACTION Traversal_4 ( T , HeadList )
   SOIENT
         T , CloneT DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList UN POINTEUR VERS UNE LISTE DE ENTIER ;
         i , hauteur UN ENTIER ;

   DEBUT
        hauteur := HEIGHT ( T ) ;
        CloneT := CloneTree ( T ) ;
        POUR i:=1 , hauteur
             APPEL LL_RL  ( CloneT , HeadList ) ;
        FINPOUR ;
   FIN

{ Checks if the traversal 4 (LL_RL) is correct by deleting the visited leaves and comparing them with List_LL }
   FONCTION CheckTraversal_4 ( T , HeadList ) : BOOLEEN
   SOIENT
         T , R , R2 , P DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         HeadList , q UN POINTEUR VERS UNE LISTE DE ENTIER ;
         Check UN BOOLEEN ;

   DEBUT
        q := HeadList ;
        R := NIL ;
        Check := VRAI ;

        TQ ( T <> NIL ) ET ( q <> NIL ) ET ( Check = VRAI )
           SI R = NIL
              R := Mostright ( T ) ;
           FSI ;

           APPEL Nextleft ( R , R2 ) ;
           P := PERE ( R ) ;

           SI STRUCT(INFO(R),1) = VALEUR(q)
              SI p <> NIL
                 SI R = FG ( P )
                    AFF_FG ( P , NIL ) ;
                 SINON
                    AFF_FD ( P , NIL ) ;
                 FSI ;
              SINON
                 T := NIL ;
              FSI ;

           SINON
              Check := FAUX ;

           FSI ;

           q := SUIVANT ( q ) ;
           R := R2 ;
        FTQ ;

        CheckTraversal_4 := Check ;
   FIN 
