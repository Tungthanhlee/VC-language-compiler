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
          System.out.println(e);
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
    // printToken("Keyword", yytext(), yyline, yycolumn);
  }

  {Booleans} {
    WriteToFile( "Booleans: " , yytext());
    // printToken("Boolean", yytext(), yyline, yycolumn);
  }

  {Separators} {
    WriteToFile( "Separators: " , yytext());
    // printToken("Separator", yytext(), yyline, yycolumn);
  }

  {ArithmeticOperators} {
    WriteToFile( "ArithmeticOperators: " , yytext());
    // printToken("Arithmetic Operator", yytext(), yyline, yycolumn);
  }

  {RelationalOperators} {
    WriteToFile( "RelationalOperators: " , yytext());
    // printToken("Relational Operator", yytext(), yyline, yycolumn);
  }

  {EqualityOperators} {
    WriteToFile( "EqualityOperators: " , yytext());
    // printToken("Equality Operator", yytext(), yyline, yycolumn);
  }

  {LogicalOperators} {
    WriteToFile( "LogicalOperators: " , yytext());
    // printToken("Logical Operator", yytext(), yyline, yycolumn);
  }

  {AssignmentOperator} {
    WriteToFile( "AssignmentOperator: " , yytext());
    // printToken("Assignment Operator", yytext(), yyline, yycolumn);
  }

  \" { yybegin(STRING); string.setLength(0); }

  {Integers} {
    WriteToFile( "Integers: " , yytext());
    // printToken("Integer", yytext(), yyline, yycolumn);
  }

  {Floats} {
    WriteToFile( "Floats: " , yytext());
    // printToken("Float", yytext(), yyline, yycolumn);
  }

  {Comments} {
    WriteToFile( "Comments: " , yytext());
    // printToken("Comment", yytext(), yyline, yycolumn);
  }
 
  {WhiteSpace} {
    /* ignore */
  }

  {Identifiers} {
    WriteToFile( "Identifiers: " , yytext());
    // printToken("Identifier", yytext(), yyline, yycolumn);
  }
}

<STRING> {
  \" { 
   yybegin(YYINITIAL); 
   WriteToFile( "String:" , yytext());
  //  printToken("String", string.toString(), yyline, yycolumn); 
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
    // printToken("Unterminated String", yytext(), yyline, yycolumn);
  }
}

[^] {
  WriteToFile( "Error: Unknow token" , yytext());
  // printToken("Error: Unknow token", yytext(), yyline, yycolumn);
}