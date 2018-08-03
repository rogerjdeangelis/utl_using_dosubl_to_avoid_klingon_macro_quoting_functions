Using dosubl to avoid klingon macro quoting functions

github
https://tinyurl.com/y8jb85p7
https://github.com/rogerjdeangelis/utl_using_dosubl_to_avoid_klingon_macro_quoting_functions

see SAS forum
https://tinyurl.com/y87bdfzb
https://communities.sas.com/t5/SAS-Enterprise-Guide/How-to-create-a-macro-variable-into-a-macro-function-containing/m-p/483237

Replace double quote, '"',  with '%bquote(")'.
Not sure why you want to do this

I am doing this to show how to avoid macro quoting functions.

INPUT
=====

 %let prolog=<?xml version="1.0" encoding="windows-1252" ?>;
 %put &=prolog;

 PROLOG=<?xml version="1.0" encoding="windows-1252" ?>

EXAMPLE OUTPUT macro variable
=============================

 Macro variable prolog1

 PROLOG1='<?xml version=%bquote(")1.0%bquote(") encoding=%bquote(")windows-1252%bquote(") ?>'

Note prolog1 is single quoted.
Dequoting will cause the %bquote(") to be resolved to just a double quote.
I don't think you want this.
Dequote when and where you want resolve the bquote.


PROCESS
=======

%symdel prolog prolog1 / nowarn;
%macro tst;

 %let rc=%sysfunc(dosubl(%nrstr(
   data _null_;
     prolog=tranwrd('<?xml version="1.0" encoding="windows-1252" ?>','"','%bquote(")');
     call symputx('prolog',cats("'",prolog,"'")); *  quoting prevents subsequent resolution;
     run;quit;
 )));

 &prolog

%mend tst;

%let prolog1=%tst;

%put &=prolog1;

OUTPUT
======

 PROLOG1='<?xml version=%bquote(")1.0%bquote(") encoding=%bquote(")windows-1252%bquote(") ?>'













