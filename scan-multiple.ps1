$files = Get-ChildItem "input\"
$outFolder = "output\"
for ($i=0; $i -lt $files.Count; $i++) {
    $outfile = $outFolder + $files[$i].BaseName
    & java Scanner $files[$i].FullName > $outfile
}