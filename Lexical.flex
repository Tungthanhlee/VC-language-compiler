import java.io.*;
%%

%class Scanner
%standalone
%unicode
%line
%column


%{
  StringBuilder string = new StringBuilder();

  public static File file = new File("output/output.txt");

  public static void WriteToFile(String tokenType, String token) {
      try {
          FileWriter fr = new FileWriter(file, true);
          fr.write(tokenType + token.trim() + "\n");
          fr.close();
      } catch (IOException e) {
          e.printStackTrace();
      }
  }
  
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

Comments = {TraditionalComment} | {EndOfLineComment} | 
          {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/*" "*"+ [^/*] ~"*/"

Letter = [A-Za-z_]
Digit = [0-9]
Identifiers = {Letter}({Letter}|{Digit})*
Keywords = boolean|break|continue|else|for|float|if|int|return|void|while

ArithmeticOperators = \+|\-|\*|\/
RelationalOperators = \<|\<=|\>|\>=
EqualityOperators = "=="|"!="
LogicalOperators = \|\||\&\&|\!
AssignmentOperator = "="
Separators = \{|\}|\(|\)|\[|\]|\;|\,

Integers = {Digit}({Digit})*

Fraction = \.{Digit}+
Exponent = (E|e)(\+|\-)?{Digit}+
Floats = {Digit}* {Fraction} {Exponent}? | {Digit}+\. | {Digit}+ \.? {Exponent}

Booleans = "true"|"false"

EscapeSequences = \b|\f|\n|\r|\t|\'|\"|\\
Strings = \"([^\r\n\"\\]*)\"
StringCharacter = [^\r\n\"\\]
%state STRING

%%
<YYINITIAL> {
  {Keywords} {
    WriteToFile( "Keyword: " , yytext());
  }

  {Booleans} {
    WriteToFile( "Booleans: " , yytext());
  }

  {Separators} {
    WriteToFile( "Separators: " , yytext());
  }

  {ArithmeticOperators} {
    WriteToFile( "ArithmeticOperators: " , yytext());
  }

  {RelationalOperators} {
    WriteToFile( "RelationalOperators: " , yytext());
  }

  {EqualityOperators} {
    WriteToFile( "EqualityOperators: " , yytext());
  }

  {LogicalOperators} {
    WriteToFile( "LogicalOperators: " , yytext());
  }

  {AssignmentOperator} {
    WriteToFile( "AssignmentOperator: " , yytext());
  }

  \" { yybegin(STRING); string.setLength(0); }

  {Integers} {
    WriteToFile( "Integers: " , yytext());
  }

  {Floats} {
    WriteToFile( "Floats: " , yytext());
  }

  {Comments} {
    WriteToFile( "Comments: " , yytext());
  }
 
  {WhiteSpace} {
    /* ignore */
  }

  {Identifiers} {
    WriteToFile( "Identifiers: " , yytext());
  }
}

<STRING> {
  \" { 
   yybegin(YYINITIAL); 
   WriteToFile( "String:" , yytext());
  }

  {StringCharacter}+ {
    string.append( yytext() ); 
  }

  "\\b" { string.append( '\b' ); }
  "\\t" { string.append( '\t' ); }
  "\\n" { string.append( '\n' ); }
  "\\f" { string.append( '\f' ); }
  "\\r" { string.append( '\r' ); }
  "\\\"" { string.append( '\"' ); }
  "\\'" { string.append( '\'' ); }
  "\\\\" { string.append( '\\' ); }

  {LineTerminator} {
    WriteToFile( "Unterminated String" , yytext());
  }
}

[^] {
  WriteToFile( "Error: Unknow token" , yytext());
}