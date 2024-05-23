
   SOIENT
{=========================== Variables =================================}
       Tree : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;
{=========================== Modules =================================}
       Isuniquevalue : FONCTION ( BOOLEEN ) ;
       Insert UNE ACTION ;
       Create_tree UNE ACTION ;
       Display UNE ACTION ;
{====================== Programme Principaples ======================}      
   DEBUT
       APPEL Create_tree ( Tree ) ;
       APPEL Display ( Tree ) ;
      
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
