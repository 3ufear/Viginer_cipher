use strict;
use Data::Dumper;


my $text_1 = "xt xafs lwpm ccpji fv bd bsm ccpji fv jpgx qycc cxavp ecxmp egwiyj fpji wflt hlxzp hdmmv zjh mg kft crlvr rcqx jm hveec g iowmv yi tmkjr ivi ovpn kskjr dt jhirjbi l dgvvx teb dhlxi qifebeq dt ahv uwwga eml gixd uds ghdnpfiw ngiv phjq dt xavc lwpe emi gixd qd";
my $text = 'xtxafslwpmccpjifvbdbsmccpjifvjpgxqycccxavpecxmpegwiyjepjiwflthlxzphdmmvzjhmgkftcrlvrrcqxjmhveecgiowmvyitmkjriviovpnkskjrdtjhirjbildgvvxtebdhlxiqifebeqdtahvuwwgaemlgixdudsghdnpfiwngivphjqdtxavclwpeemigixdqd';

my $text_2="xtxafslwpmccpjifvbdbsmccpjifvjpgxqycccxavpecxmpegwiyjfpjiwflthlxzphdmmvzjhmgkftcrlvrrcqxjmhveecgiowmvyitmkjriviovpnkskjrdtjhirjbildgvvxtebdhlxiqifebeqdtahvuwwgaemlgixdudsghdnpfiwngivphjqdtxavclwpeemigixdqd";
my %bigrams;

my %res;


#%res = map { exists($res{$planets{$_}}) ?  print("$_") : $planets{$_} => [$_] } keys %planets;
#%res = map { $planets{$_} => [$_] } keys %planets;
#push $res{$planets{$_}},$_


my @chars = split //, $text;

sub get_bigrams_frequency {
    my %bigrams;
    my $bigram;
    my $f_time = 1;
    foreach my $ch (@chars) {
        if ($f_time == 1) {
            $bigram = $ch;
            $f_time++;
            next;
        }
        $bigram .= $ch;
        #if ($bigram =~ /.*\s.*/) {
        #    $bigram =~ /.(.)/;
        #    $bigram = $1;
        #    next;
        #}
        if (exists($bigrams{$bigram})) {
            $bigrams{$bigram}++;
        } else {
            $bigrams{$bigram} = 1;
        }
        $bigram =~ /.(.)/;
        $bigram = $1;
    }
    return %bigrams;
}


#%bigrams = get_bigrams_frequency();
#%res = reverse_hash(%bigrams);
sub reverse_hash {
    my %bigrams = @_;
    #use Data::Dumper;
    #print(Dumper(%bigrams));
    my %res;
    foreach my $k (keys %bigrams) {
        if (exists($res{$bigrams{$k}})) {
            push  @res{$bigrams{$k}}, $k;
        } else {
            $res{$bigrams{$k}} = [$k];
        }
    }
    return %res;
}
#%res = reverse_hash(%bigrams);
#%res = map { $_ => $res{$_} } sort{$b <=> $a} keys %res;

#my @keys = sort {$b <=> $a} keys %res;


#print Dumper(map{$_ => $res{$_} } @keys);
my @distance;
sub get_distance_between {
    my @distance;
    my $keyref = shift;
    my @keys = @$keyref;
   # print Dumper(@$keyref);
    my %res = @_;
    my $f_time;
    for (my $i = 0; $i < 2; $i++) {
        my $array = $res{$keys[$i]};
        foreach my $el (@$array) {
            my $pos = 0;
            my $pr_pos = 0;
            $f_time = 1;
            while ($pos != -1) {
                $pos++;
                $pos = index($text,$el, $pos);
                if ($f_time != 1) {
                    if ($pos != -1) {
                        push @distance, ($pos - $pr_pos);
                    }
                }
                $f_time = 0;            
                $pr_pos = $pos;
            }
        }
    }
    return @distance;
}

#@distance = get_distance_between(%res);
#print Dumper(\@distance);

my %length_key;
sub get_length_key {
    my %length_key;
    my @distance = @_;
    for(my $i = 5;$i <= 8; $i++ ) {
        my $count = 0;
        foreach my $el (@distance) {
            if ( ($el % $i) == 0) {
                $count++;
            }
        }
        $length_key{$count}= $i;
    }
    return %length_key;
}

sub get_characters_frequency{
    my $len = shift;
    my $start = shift;
    my %ch_hash;
    #print "Start el: $chars[$start]";

    for(my $i = $start;$i < $#chars ;$i = $i + $len) {
     #   print $i . "\n";
        my $ch = $chars[$i];
     #   print "$ch\n";
        if (exists($ch_hash{$ch})) {
            $ch_hash{$ch}++;
        } else {
            $ch_hash{$ch} = 1;
        }
    }
    return %ch_hash;
}

sub get_character_code {
    my $ch = shift;
    return ord($ch) - ord('a');
}

sub get_char_from_code {
    my $code = shift;
    return chr($code + ord('a'));
}

sub get_distances_to_symbol {
    my $ch = shift;
    my @t_mas;
    foreach my $el (qw(e a t o)) {
        push @t_mas, ((ord($ch) - ord($el) + 26)%26);
    }
    return @t_mas;
}

sub get_real_distance_to_symbol {
    my @array = @_;
    my @distances;
    #print Dumper(@array);
    foreach my $ref (@array) {
        foreach my $ch (@$ref) {
             push @distances, get_distances_to_symbol($ch);
        }
    }
    return @distances;
}

sub get_chars_frequency {
    my @array = @_;
    my %frequency;
    foreach my $el (@array) {
        if (exists $frequency{$el}) {
            $frequency{$el}++;
        } else {
            $frequency{$el} = 1;
        }
    }
    return reverse_hash(%frequency);
}

sub print_modify_msg {
    my $key = shift;
    my $len = shift;
    my @keys = split //, $key;
    my $i = 0;
    foreach my $el (@chars) {
        my $k_char = get_character_code($keys[$i]);
        my $msg_char = get_character_code($el);
        #print $k_char . "  " . $msg_char . "\n";
        my $code = ($msg_char - $k_char  + 26)%26;
        #print "$code \n";
        print get_char_from_code($code);
        $i++;
        if ($i == $len) {
            $i = 0;
        }
        
    }
    print "\n";
}

sub print_reformat_key {
    my @key = @_;
    #print Dumper(@key);
    my @possible_vars;
    foreach my $ref (@key) {
     #print $ref;
        if ($#$ref == 0) {
            print get_char_from_code($$ref[0]);
        } else {
            push @possible_vars, $ref;
            print '_';
        }
    }
    print "\n" . 'Possible variants for _: ';
    my $i = 0;
    foreach my $ref (@possible_vars) {
        print "for $i _ letter: \n";
        foreach my $code (@$ref) {
            print get_char_from_code($code) . "\n";
        }
        $i++;
    }
    print "\n";
}


%bigrams = get_bigrams_frequency();
%res = reverse_hash(%bigrams);
my @keys = sort {$b <=> $a} keys %res;
@distance = get_distance_between(\@keys,%res);
%length_key = get_length_key(@distance);
my @length = sort {$b <=> $a} keys %length_key;
my $len = $length_key{$length[0]};
my @key;
for (my $i=0; $i < $len; $i++) {
    my %char_freq = get_characters_frequency($len,$i); ###Сделать все в цикле......
    my %res_letters = reverse_hash(%char_freq);
    my @keys_letters = sort {$b <=> $a} keys %res_letters;
    #get_distances_to_symbol('d');
    my @distances = get_real_distance_to_symbol(@res_letters{$keys_letters[0]}, @res_letters{$keys_letters[1]});
    if ($i == 1 || $i == 4) {
        print Dumper(\@distances);
    }
    my %res_char = get_chars_frequency(@distances);
    my @key_char = sort { $b <=> $a } keys %res_char;
    push @key,$res_char{@key_char[0]};
}
print 'Key: ' . "\n";
print Dumper(\@key);
print_reformat_key(@key);


print 'Enter key:';
my $key = <STDIN>;
chomp $key;

print_modify_msg($key, $len);
#print Dumper(\%length_key);
#print Dumper(\@distances);
#print Dumper(@res_letters{$keys_letters[0]});
#print Dumper(%res_letters);
#print 'length of keys can be:' . "\n";
#print Dumper(map {$length_key{$_} => $_} sort {$b <=> $a} keys %length_key);




#foreach my $key ( sort {$b <=> $a} keys %length_key)


