ptf 

sub patch
{
    my $s = shift;
    $s =~ s/\) *\(/\)\+\(/g;
    return $s;
}

sub adjust_g_format
{
    my $s = shift;
    $s =~ s/(\-?)(\d+)(\.?)(\d*)e(\+)(\d)(\d)(\d)(\@)/ $1$2$3$4e$6$7$8$9/g;
    $s =~ s/(\-?)(\d+)(\.?)(\d*)e(0)(\d)(\d)(\@)/ $1$2$3$4e$6$7$8/g;
    $s =~ s/(\-?)(\d+)(\.?)(\d*)e(0)(\d)(\@)/ $1$2$3$4e$6$7/g;
    $s =~ s/(\-?)(\d+)(\.?)(\d*)e(\-?)(0)(\d)(\d)(\@)/ $1$2$3$4e$5$7$8$9/g;
    $s =~ s/(\-?)(\d+)(\.?)(\d*)e(\-?)(0)(\d)(\@)/ $1$2$3$4e$5$7$8/g;
    $s =~ s/( )( *)(-?)(\d+)(\@)/$2$3$4\.$5/g;
    $s =~ s/\@//g;
    return $s;
}

sub esprintf
{
    my $form = shift;
    my $value = shift;
    $form =~ /(\%)(\d+)(.*)/;
    my $lng = $2;
    my $ret_val = adjust_g_format sprintf $form, $value;
    if($lng < length($ret_val))
    {
      while( $lng < length($ret_val) )
      {
        if($ret_val =~ /( )(.*)/)
        {
            $ret_val =~ s/( )(.*)/$2/;
        }
        else
        {
            $ret_val =~ s/(.*)(\de)(.*)/ $1e$3/i;
        }
      }
    }
    if($ret_val =~ /[^ ].*/)
    {
       $ret_val =~ s/(.*)(\de)(.*)/ $1e$3/i;
    }
    return $ret_val;
}

sub Process
{
  my $source = shift;
  my $target = shift;
  open inp, "<$source";
  open out, ">$target";
  while(<inp>)
  {
    print out adjust_g_format eval patch $_;
  }
  close inp;
  close out;
}
$Kx_10 =                Kx_10;
$Ky_10 =                Ky_10;
$Kz_10 =                Kz_10;
$Kx_11 =                Kx_11;
$Ky_11 =                Ky_11;
$Kz_11 =                Kz_11;
$Kx_12 =                Kx_12;
$Ky_12 =                Ky_12;
$Kz_12 =                Kz_12;
$Kx_13 =                Kx_13;
$Ky_13 =                Ky_13;
$Kz_13 =                Kz_13;
$Kx__8 =                Kx__8;
$Ky__8 =                Ky__8;
$Kz__8 =                Kz__8;
$Kx__9 =                Kx__9;
$Ky__9 =                Ky__9;
$Kz__9 =                Kz__9;
undef %Source_Files_To_Process;
$Source_Files_To_Process{'MODELO_CENTRO_V8_2007_2009_CALIBRADO.BCF'} = 'MODELO_CENTRO_V8_2007_2009_CALIBRADO.BCF.SRC';
$Source_Files_To_Process{'MODELO_CENTRO_V8_2007_2009_CALIBRADO.WEL'} = 'MODELO_CENTRO_V8_2007_2009_CALIBRADO.WEL.SRC';
foreach $target ( keys %Source_Files_To_Process )
{
  $source = $Source_Files_To_Process{$target};
  Process $source, $target;
}
