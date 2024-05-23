   SOIENT
   //===================== Variables =======================================
       Tree : POINTEUR VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       Val UN ENTIER ;
       S UNE STRUCTURE ( ENTIER , BOOLEEN ) ;
   //===================== Modules =======================================
       Insert UNE ACTION ;
       Create_tree UNE ACTION ;
       Display UNE ACTION ;
   //===================== Programme Principale =======================================  
   DEBUT
       APPEL Create_tree ( Tree ) ;
       APPEL Display ( Tree ) ;
      
   FIN

  //===================== Implimentation des modules =======================================
  
  //Inserts a value in a binary search tree rule (doesn't treat the case where the value exists)  
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

   // Creates a binary search tree with 100 random data all initialized to false (not visited)
   ACTION Create_tree ( T )
   SOIENT
       V UN VECTEUR ( 100 ) DE ENTIER ;
       T , R DES POINTEURS VERS UN ARB DE ( ENTIER , BOOLEEN ) ;
       I , Value UN ENTIER ;
      
   DEBUT
       POUR I := 1 , 100
           AFF_ELEMENT ( V [ I ] , ALEANOMBRE ( 1000 ) ) ;
          
       FPOUR ;
       POUR I := 1 , 100
           Value := ELEMENT ( V [ I ] ) ;
           APPEL Insert ( T , Value ) ;
          
       FPOUR ;
      
   FIN

   // Displays nodes inorder (did it for verification)
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
