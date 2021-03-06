{**********************************************************************}
{*                           EINUNDZWANZIG                            *}
{*--------------------------------------------------------------------*}
{* Ziel dieses Spiels ist es, durch geschickte Addition der beiden    *}
{* Werte 1 und 2 das Eregbnis 21 zu erreichen. Dabei wird gegen den   *}
{* Computer gespielt. Wer als erster den Wert 21 erreicht hat, ist    *}
{* Sieger.                                                            *}
{*--------------------------------------------------------------------*}
{* Dateiname:  21.PAS                                                 *}
{**********************************************************************}

PROGRAM Einundzwanzig;

USES Crt;

VAR
   xz,  boMyTurn : BOOLEAN;         {* True => Computer ist an der Reihe *}
     iWert : INTEGER;                           { aktueller Spielstand }

PROCEDURE Stand;
BEGIN
     WriteLn(^j,' Spielstand: ', iWert);
END;

PROCEDURE Spieler;
VAR
     cEingabe : CHAR;
BEGIN

     boMyTurn := FALSE;                       {* Computer darf NICHT! *}

     Write('Ihr Zug bitte: ');
     cEingabe := ReadKey;                  {* auf eine Eingabe warten *}

     CASE cEingabe OF                        {* und Eingabe auswerten *}
        '1':                       {* er m�chte also um 1 erh�hen ... *}
            BEGIN
            WriteLn('Genehmigt!');
            Inc(iWert);                               {* Wert erh�hen *}
            END;
        '2':
           BEGIN                                      {* um 2 erh�hen *}
           WriteLn('Sie gehen aber ran!');
           Inc(iWert, 2);
           END;
        ELSE                              {* Falscheingabe! SO Nicht! *}
           WriteLn('Das kann wohl nicht ganz sein.... NOCHMAL!');
           Spieler;                {* Spieler mu� Eingabe wiederholen *}
     END;
END;

PROCEDURE Computer;
BEGIN
     boMyTurn := TRUE;                 {* jetzt bin ich endlich dran! *}
                             {* je nach dem augenblicklichen Stand um *}
     CASE iWert OF                          {* um 1 oder um 2 erh�hen *}
        1,                {* unsere Kandidaten f�r eine Erh�hung um 2 *}
        4,
        7,
        10,
        13,
        16,
        19:
        BEGIN
           WriteLn('Ich erh�he um 2!');
           Inc(iWert, 2);                 {* auch tats�chlich erh�hen *}
        END
        ELSE                  {* in allen �brigen F�llen: erh�he um 1 *}
           WriteLn('Ich erh�he um 1!');
           Inc(iWert);
       END;
END;


BEGIN

bomyturn:=true;
     ClrScr;                                     {* Bildschirm l�schen *}
                                               {* und neu aufbauen... *}
     WriteLn('****************************************************');
     WriteLn('*                   EINUNDZWANZIG                  *');
     WriteLn('*--------------------------------------------------*');
     WriteLn('* Das Ziel des Spiels ist es, durch Addition der   *');
     WriteLn('* beiden Zahlen 1 oder 2 den Wert 21 zu erreichen. *');
     WriteLn('* Derjenige, der diesen als erster erreicht, ist   *');
     WriteLn('* Sieger.                                          *');
     WriteLn('****************************************************');
     WriteLn(^j);

     REPEAT
     xz:=true;
        iWert := 0;                         {* wir beginnen mit NULL! *}
        Write('M�chten Sie anfangen?: ');           {* immer h�flich... *}
        IF UpCase(ReadKey) = 'J' THEN               {* der Schurke... *}
           boMyTurn := FALSE;                 {* Gegner darf anfangen *}
        WriteLn;
        IF boMyTurn = FALSE THEN            {* Gegner m�chte beginnen *}
        BEGIN
           Stand;                  {* augenblicklichen Stand ausgeben *}
           Spieler;                   {* mein Gegner darf beginnen... *}
        END;

        WHILE(iWert < 21) DO        {* solange 21 noch nicht erreicht *}
        BEGIN
           Stand;                  {* augenblicklichen Stand ausgeben *}
           Computer;                       {* jetzt darf der Computer *}
           if iwert=21 then begin
             WriteLn('Ich habe gewonnen!');
             xz:=false;
            end;
          if xz=true then
          begin
           Stand;                  {* augenblicklichen Stand ausgeben *}
           Spieler;
           if iwert=21 then
           WriteLn('Gratuliere, Sie haben gewonnen!');

           end                   {* mein Gegner ist an der Reihe *}
        END;


        WriteLn('M�chten Sie noch einmal?');
        boMyTurn := (UpCase(ReadKey) = 'J');

     UNTIL boMyTurn = FALSE;

     WriteLn('Es hat viel Spass gemacht - bis zum n�chsten Mal!');

END.


