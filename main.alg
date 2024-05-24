
   SOIENT
{=========================== Variables =================================}
       Tree : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;
       B UN BOOLEEN;
{=========================== Modules =================================}
       Isuniquevalue : FONCTION ( BOOLEEN ) ;
       Isbst : FONCTION ( BOOLEEN ) ;
       Insert UNE ACTION ;
       Create_tree UNE ACTION ;
       Display UNE ACTION ;
       LL_LR UNE ACTION ;
       LL_RL UNE ACTION ;
       ArbreExemple UNE ACTION ;
{====================== Programme Principaples ======================}
   DEBUT
       APPEL Create_tree ( Tree ) ;
       APPEL Display ( Tree ) ;
       B := Isbst ( Tree , -1000 , 1000 ) ;
      { Min and Max values are put -1000 to 1000 because of the interval of generating the random numbers }
       SI B = VRAI
           ECRIRE ( 'Tree is a BST.' ) ;

       SINON
           ECRIRE ( 'Tree is NOT a BST.' ) ;

       FSI ;

       ECRIRE ( ' LEAVES ' ) ;
       APPEL LL_LR ( Tree ) ;

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

{ Gives the leaves of the tree from left to right (Their children are NIL or visited) }
   ACTION LL_LR ( T )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;

   DEBUT

        SI T <> NIL
           SI FG(T) = NIL
              SI FD(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                 AFF_STRUCT ( S , 2 , VRAI ) ;
                 AFF_INFO ( T , S ) ;
              SINON
                 SI STRUCT(INFO(FD(T)),2) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                 SINON
                    APPEL LL_LR (FD(T)) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT(INFO(FG(T)),2) = VRAI
                 SI FD(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                 SINON
                    SI STRUCT(INFO(FD(T)),2) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                       AFF_STRUCT ( S , 2 , VRAI ) ;
                       AFF_INFO ( T , S ) ;
                    SINON
                       APPEL LL_LR (FD(T)) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_LR (FG(T)) ;
                 SI FD(T) <> NIL
                    APPEL LL_LR (FD(T)) ;
                 FSI ;
              FSI ;
           FSI ;
        FSI ;

   FIN

{ Gives the leaves of the tree from right to left (Their children are NIL or visited) }
   ACTION LL_RL ( T )
   SOIENT
         T UN POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
         S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;

   DEBUT

        SI T <> NIL
           SI FD(T) = NIL
              SI FG(T) = NIL
                 ECRIRE ( INFO ( T ) , ' ' ) ;
                 AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                 AFF_STRUCT ( S , 2 , VRAI ) ;
                 AFF_INFO ( T , S ) ;
              SINON
                 SI STRUCT(INFO(FG(T)),2) = VRAI
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                 SINON
                    APPEL LL_RL (FG(T)) ;
                 FSI ;
              FSI ;
           SINON
              SI STRUCT(INFO(FD(T)),2) = VRAI
                 SI FG(T) = NIL
                    ECRIRE ( INFO ( T ) , ' ' ) ;
                    AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                    AFF_STRUCT ( S , 2 , VRAI ) ;
                    AFF_INFO ( T , S ) ;
                 SINON
                    SI STRUCT(INFO(FG(T)),2) = VRAI
                       ECRIRE ( INFO ( T ) , ' ' ) ;
                       AFF_STRUCT ( S , 1 , STRUCT(INFO(T), 1) ) ;
                       AFF_STRUCT ( S , 2 , VRAI ) ;
                       AFF_INFO ( T , S ) ;
                    SINON
                       APPEL LL_RL (FG(T)) ;
                    FSI ;
                 FSI ;
              SINON
                 APPEL LL_RL (FD(T)) ;
                 SI FG(T) <> NIL
                    APPEL LL_RL (FG(T)) ;
                 FSI ;
              FSI ;
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

        CREERNOEUD ( R ) ;
        AFF_STRUCT ( S , 1 , 20 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R , S ) ;
        AFF_FG ( T , R ) ;

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 10 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FG ( R , R2 ) ;
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 35 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FD ( R , R2 ) ;
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;

        CREERNOEUD ( R ) ;
        AFF_STRUCT ( S , 1 , 65 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R , S ) ;
        AFF_FD ( T , R ) ;
        AFF_FG ( R , NIL ) ;

        CREERNOEUD ( R2 ) ;
        AFF_STRUCT ( S , 1 , 55 ) ;
        AFF_STRUCT ( S, 2 , FAUX ) ;
        AFF_INFO ( R2 , S ) ;
        AFF_FG ( R , R2 ) ;
        AFF_FG ( R2 , NIL ) ;
        AFF_FD ( R2 , NIL ) ;

   FIN
