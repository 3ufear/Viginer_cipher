#!/usr/bin/perl
use POSIX;
&POSIX::setlocale(&POSIX::LC_CTYPE, 'ru_RU.CP1251');
#use utf8;
my @mas = qw(а б в г д е ж з и к л м н о п р с и у ф х ц ч ш щ ы ь ю я);

#sub code_symbol {
#    my $symbol = shift;
#    my $code = shift;
#    return chr((((ord($symbol) - ord('а')) + (ord($code) - ord('а'))) + 29)%29 + ord('а'));
#}





sub code_symbol {
    my $symbol = shift;
    my $code = shift;
    print  "!!! $symbol !!!";
    #my $code_s = get_symbol_code($symbol);
    #my $code_c = get_symbol_code($code);
    return $mas[(($code + $symbol + 29)%29)];
}


sub get_symbol_code {
     my $symb = shift;
     for (my $i=0;$i<=$#mas;$i++) {
         if ($symb eq $mas[$i]) {
             return $i;
         }
     }
}

#my @mas = qw(а б в г д е ж з и к л м н о п р с и у ф х ц ч ш щ ы ь ю я);
#my $str = 'if thou wilt leave me do not leave me last';
#my $str = 'anyone who reads old and middle english literary texts will be familiar with the midbrown volumes of the eets with the symbol of alfreds jewel embossed on the front cover most of the works attributed to king alfred or to aelfric along with some of those by bishop wulfstan and much anonymous prose and verse from the preconquest period are to be found within the societys three series all of the surviving medieval drama most of the middle english romances much religious and secular prose and verse including the english works of john gower thomas hoccleve and most of caxtons prints all find their place in the publications without eets editions study of medieval english texts would hardly be possible';

#my $str = 'two households both alike in dignity in fair verona where we lay our scene from ancient grudge break to new mutiny where civil blood makes civil hands unclean from forth the fatal loins of these two foes a pair of star-crossd lovers take their life whose misadventured piteous overthrows do with their death bury their parents strife the fearful passage of their deathmarkd love and the continuance of their parents rage which but their childrens end nought could remove is now the two hours traffic of our stage the which if you with patient ears attend what here shall miss our toil shall strive to mend';

#my $str = 'ее находят что то странной провинциальной и жеманной';

my @str = qw(5 5 12 0 20 13 4 28 17 22 17 13 17 13 16 17 15 0 12 12 13 8  );
my @str_1 = qw(14 15 13 2 8 12 21 8 0 10 26 12 13 8 8 6 5 11 0 12 12 13 8  );
my @str_2 = qw(8 22 17 13 17 13 1 10 5 4 12 13 8 8 20 18 4 13 8);
my @str_3 = qw(0 2 14 15 13 22 5 11 13 22 5 12 26 8 20 18 4 13 8);
print "Input string: @str \n";
print 'Input code: ' . "\n";
my @code = qw(14 0 15 13 10 26);
#homp $code;

#my @string = split //,$str;
#my @codes = split //,$code;
print "!!!!!!!!!!!!!" . $#code;
print "Cypher: \n";
my $i = 0;


#print 'AAAAAAAA^ ' . $codes[1];
foreach my $el (@str) {
    print code_symbol($el,$code[$i]);
    $i++;
    print ' ';
       # print ' ';
    if ($i > $#code ) {
        $i = 0;
    }

}
print "\n";
foreach my $el (@str_1) {
        print code_symbol($el,$code[$i]);
            $i++;
                print ' ';
                       # print ' ';
                           if ($i > $#code ) {
                                       $i = 0;
                                           }

}
print "\n";
foreach my $el (@str_2) {
        print code_symbol($el,$code[$i]);
            $i++;
                print ' ';
                       # print ' ';
                           if ($i > $#code ) {
                                       $i = 0;
                                           }

}

print "\n";
foreach my $el (@str_3) {
        print code_symbol($el,$code[$i]);
            $i++;
                print ' ';
                       # print ' ';
                           if ($i > $#code ) {
                                       $i = 0;
                                           }

}
print "\n";






use Data::Dumper;
#print get_symbol_code('в');
