
   SOIENT
{=========================== Variables =================================}
       Tree : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
       TAB_LL UN VECTEUR ( 100 ) DE ENTIER ;
       Val UN ENTIER ;
       B UN BOOLEEN;
{=========================== Modules =================================}
       Isuniquevalue : FONCTION ( BOOLEEN ) ;
       Isbst : FONCTION ( BOOLEEN ) ;
       HEIGHT : FONCTION ( ENTIER ) ;
       Insert UNE ACTION ;
       Create_tree UNE ACTION ;
       Display UNE ACTION ;
       ArbreExemple UNE ACTION ;
          {BB-LR}
       Mostleft : FONCTION (POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ));
       Nextright UNE ACTION;
       Traversal_1 UNE ACTION; 
          {BB-RL}
       Mostright : FONCTION (POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ));
       Nextleft UNE ACTION;
       Traversal_3 UNE ACTION;
          {LL_LR}
       LL_LR UNE ACTION ;
       Traversal_2 UNE ACTION ;
          {LL_RL}
       LL_RL UNE ACTION ;
       Traversal_4 UNE ACTION ;
{====================== Programme Principaples ======================}
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

       { ECRIRE ( ' LEAVES LL_LR ' ) ;
       APPEL Traversal_2 ( Tree , TAB_LL ) ; }
       ECRIRE ( ' LEAVES BB_RL ' ) ;
       APPEL traversal_3( Tree );

   FIN

{=================== Implimentation des modules ======================}

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

       FSI ;

   FIN

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
           FSI
        FSI
   FIN

{ Gives the most left leaf of a given tree ( or sub-tree ) }
   FONCTION Mostleft ( T ) : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )
   SOIT
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
   SOIT
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

   ACTION Traversal_1 ( T )
   SOIT
       T UN POINTEUR VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE (ENTIERS,BOOLEEN) ;
       Up UN BOOLEEN ;
   DEBUT
       P := Mostleft(T);  {We start from the most LC}
       F := P ;
       TQ F <> NIL
           S := F ;      {S is to save the current leaf so that we can move to exactly the next leaf}
           SI STRUCT(INFO(F),2)=FAUX
           ECRIRE ( INFO ( F ) ) ;        {We ascend while processing the nodes}
           AFF_STRUCT ( INFO(F), 2 , VRAI ); {We mark the processed nodes as visited}
           FSI  ;
           Q := F ;
           P := PERE ( Q ) ;
           Up := VRAI ;
           TQ ( P <> NIL ) ET Up
               SI STRUCT(INFO(P),2)  {While ascending if we found an already visited node we stop}
                   Up := FAUX
               SINON                  {Else we keep going up}
                   ECRIRE ( INFO ( P ) ) ;
                   AFF_STRUCT ( INFO(P), 2 , VRAI );
                   Q := P ;
                   P := PERE ( P )
               FSI
           FTQ ;
 {once we stop ascending, either we reached the root or a visited node}
 {we move on to the next leaf to start again}
         APPEL Nextright ( S , F )
       FTQ
   FIN

   { Gives the most right leaf of a given tree ( or sub-tree ) }
   FONCTION Mostright ( T ) : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN )
   SOIT
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
               Stop := VRAI
           SINON
               P := FG ( P )   {Else we go left once and procceed to descend right again}
           FSI
       FTQ ;
       Mostright := P
   FIN

   { Gives the next leaf on the left of a given leaf }
   ACTION Nextleft ( Leaf , leftleaf ) ;
   SOIT
       Leaf , P , Q , F , leftleaf DES POINTEURS VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       Up UN BOOLEEN ;

   DEBUT
       Q := Leaf ;
       Up := VRAI ;
       P := PERE ( Q ) ;
       TQ ( P <> NIL ) ET Up        {We're in the leaf and we go up}
           SI Q = FG ( P )
               Q := P ;
               P := PERE ( Q )
           SINON
               SI FG ( P ) <> NIL    {If p has a LC then we stop going up}
                   Up := FAUX
               SINON
                   Q := P ;
                   P := PERE ( Q )
               FSI
           FSI
       FTQ ;
       SI P <> NIL
 {Once we get to the parent of the wanted next leaf we descend to the most RC to reach it}
           F := Mostright ( FG ( P ) ) ;
       SINON
            F := NIL;
       FSI ;
       leftleaf := F ;

   FIN

   ACTION Traversal_3 ( T )
   SOIT
       T UN POINTEUR VERS UN ARB DE ( ENTIERS , BOOLEEN ) ;
       P , F , Q , S DES POINTEURS VERS UN ARB DE (ENTIERS,BOOLEEN) ;
       Up UN BOOLEEN ;
   DEBUT
       P := Mostright(T);        {We start from the most RC}
       F := P ;
       TQ F <> NIL
           S := F ;  {S is to save the current leaf so that we can move to exactly the next leaf}
           SI STRUCT(INFO(F),2)=FAUX
           ECRIRE ( INFO ( F ) ) ;       {We ascend while processing the nodes}
           AFF_STRUCT ( INFO(F), 2 , VRAI ); {We mark the processed nodes as visited}
           FSI  ;
           Q := F ;
           P := PERE ( Q ) ;
           Up := VRAI ;
           TQ ( P <> NIL ) ET Up
               SI STRUCT(INFO(P),2)
                   Up := FAUX     {While ascending if we found an already visited node we stop}
               SINON
                   ECRIRE ( INFO ( P ) ) ;    {Else we keep going up}
                   AFF_STRUCT ( INFO(P), 2 , VRAI );
                   Q := P ;
                   P := PERE ( P )
               FSI
           FTQ ;
 {once we stop ascending, either we reached the root or a visited node}
 {we move on to the next leaf to start again}
         APPEL Nextleft ( S , F )
       FTQ
   FIN 

       { ============= TRAVERSAL 2 : LL_LR ============= }

{ Gives the leaves of the tree from left to right (Their children are NIL or visited) }
   ACTION LL_LR ( T , TAB_LL , indice )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
         TAB_LL UN VECTEUR ( 100 ) DE ENTIER ;
         indice UN ENTIER ;

   DEBUT

        SI T <> NIL
           SI FG(T) = NIL
              SI FD(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                 AFF_STRUCT ( S , 2 , VRAI ) ;
                 AFF_INFO ( T , S ) ;
                 AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                 indice := indice + 1 ;
              SINON
                 SI STRUCT( INFO(FD(T)) , 2 ) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                    AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                    indice := indice + 1 ;
                 SINON
                    APPEL LL_LR ( FD(T) , TAB_LL , indice ) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT( INFO(FG(T)) , 2 ) = VRAI
                 SI FD(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                    AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                    indice := indice + 1 ;
                 SINON
                    SI STRUCT( INFO(FD(T)) , 2 ) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                       AFF_STRUCT ( S , 2 , VRAI ) ;
                       AFF_INFO ( T , S ) ;
                       AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                       indice := indice + 1 ;
                    SINON
                       APPEL LL_LR ( FD(T) , TAB_LL , indice ) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_LR ( FG(T) , TAB_LL , indice ) ;
                 SI FD(T) <> NIL
                    SI STRUCT ( INFO(FD(T)) , 2 ) = FAUX
                       APPEL LL_LR ( FD(T) , TAB_LL , indice ) ;
                    FSI ;
                 FSI ;
              FSI ;
           FSI ;
        FSI ;
   FIN

{ Reapeat the action LL_LR 'till it reaches the height of the tree so it treats all the nodes }
   ACTION Traversal_2 ( T , TAB_LL )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
         TAB_LL UN VECTEUR ( 100 ) DE ENTIER ;
         i , hauteur , indice DES ENTIER ;

   DEBUT
        indice := 1 ;
        hauteur := HEIGHT ( T ) ;
        POUR i:=1 , hauteur
             APPEL LL_LR  ( T , TAB_LL , indice ) ;
        FINPOUR ;
   FIN

       { ============= TRAVERSAL 4 : LL_RL ============= }

{ Gives the leaves of the tree from right to left (Their children are NIL or visited) }
   ACTION LL_RL ( T , TAB_LL , indice )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
         TAB_LL UN VECTEUR ( 100 ) DE ENTIER ;
         indice UN ENTIER ;

   DEBUT

        SI T <> NIL
           SI FD(T) = NIL
              SI FG(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                 AFF_STRUCT ( S , 2 , VRAI ) ;
                 AFF_INFO ( T , S ) ;
                 AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                 indice := indice + 1 ;
              SINON
                 SI STRUCT ( INFO(FG(T)) , 2 ) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                    AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                    indice := indice + 1 ;
                 SINON
                    APPEL LL_RL ( FG(T) , TAB_LL , indice ) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT ( INFO(FD(T)) , 2 ) = VRAI
                 SI FG(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                    AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                    indice := indice + 1 ;
                 SINON
                    SI STRUCT ( INFO(FG(T)) , 2 ) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( S , 1 , STRUCT (INFO(T) , 1) ) ;
                       AFF_STRUCT ( S , 2 , VRAI ) ;
                       AFF_INFO ( T , S ) ;
                       AFF_ELEMENT ( TAB_LL [ indice ] , STRUCT (INFO(T) , 1) ) ;
                       indice := indice + 1 ;
                    SINON
                       APPEL LL_RL ( FG(T) , TAB_LL , indice ) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_RL ( FD(T) , TAB_LL , indice ) ;
                 SI FG(T) <> NIL
                    SI STRUCT ( INFO(FG(T)) , 2 ) = FAUX
                       APPEL LL_RL ( FG(T) , TAB_LL , indice ) ;
                    FSI ;
                 FSI ;
              FSI ;
           FSI ;
        FSI ;
   FIN

{ Reapeat the action LL_RL 'till it reaches the height of the tree so it treats all the nodes }
   ACTION Traversal_4 ( T , TAB_LL )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
         TAB_LL UN VECTEUR ( 100 ) DE ENTIER ;
         i , hauteur , indice UN ENTIER ;

   DEBUT
        indice := 1 ;
        hauteur := HEIGHT ( T ) ;
        POUR i:=1 , hauteur
             APPEL LL_RL  ( T , TAB_LL , indice ) ;
        FINPOUR ;
   FIN 

