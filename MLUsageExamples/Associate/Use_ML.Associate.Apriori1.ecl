/*
   The Associate.Apriori1 definition returns a dataset that contains
   an item of RecordSet that occurred in RecordSet at
   least Count times.

*/

   IMPORT ML;
   IMPORT ML.Docs AS Docs;
   d11 := DATASET([
      {'In the beginning God created the heavens and the earth. '}
      ,{'The earth was without form, and void; and darkness was[a] on the face of the deep.'}
      ,{'Then God said, "Let there be light"; and there was light. '}
      ,{'And God saw the light, that it was good; God divided the light from the darkness. '}
   ],
   {STRING r});

   d := d11;
   d1 := PROJECT(d,TRANSFORM(Docs.Types.Raw,SELF.Txt := LEFT.r));
   d2 := Docs.Tokenize.Enumerate(d1);
   d3 := Docs.Tokenize.Clean(d2);
   d4 := Docs.Tokenize.Split(d3);
   OUTPUT(d4,NAMED('d4'));
   lex := Docs.Tokenize.Lexicon(d4);
   o1 := Docs.Tokenize.ToO(d4,lex);
   o2 := Docs.Trans(O1).WordBag;
   ForAssoc:=PROJECT(o2,TRANSFORM(ML.Types.ItemElement,SELF.value:=LEFT.word,SELF:=LEFT));
   Apriori1:=ML.Associate(ForAssoc,2).Apriori1;
   OUTPUT(SORT(Apriori1,-support),NAMED('Apriori1'));
